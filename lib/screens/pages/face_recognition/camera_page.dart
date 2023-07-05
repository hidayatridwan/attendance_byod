import 'dart:convert';
import 'dart:io';

import 'package:attendance_byod/screens/pages/face_recognition/success_page.dart';
import 'package:attendance_byod/screens/pages/login/login_page.dart';
import 'package:attendance_byod/utility/prefs_data.dart';
import 'package:attendance_byod/utility/size_config.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_ml_vision/google_ml_vision.dart';
import 'package:image/image.dart' as img_lib;
import 'package:path_provider/path_provider.dart';
import 'package:quiver/collection.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

import '../../../bloc/absen/absen_bloc.dart';
import '../../../data/repositories/repositories.dart';
import '../../../shared/shared.dart';
import 'face_detection.dart';
import 'face_detector_painter.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? jsonFile;
  dynamic _scanResults;
  CameraController? _camera;
  late Interpreter interpreter;
  bool _isDetecting = false;
  final CameraLensDirection _direction = CameraLensDirection.front;
  dynamic data = {};
  double threshold = 1.0;
  Directory? tempDir;
  List? e1 = [];
  List? e2 = [];
  bool _faceFound = false;
  final FaceDetector _faceDetector = GoogleVision.instance
      .faceDetector(const FaceDetectorOptions(enableContours: true));
  final TextEditingController _nik = TextEditingController();
  final KaryawanRepository _karyawanRepository = KaryawanRepository();

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    if (PrefsData.instance.user != null) {
      _initializeData();
    }
    _initializeCamera();
  }

  void _initializeData() async {
    tempDir = await getApplicationDocumentsDirectory();
    String embPath = '${tempDir!.path}/emb.json';
    jsonFile = File(embPath);
    jsonFile!.writeAsStringSync('');
    final nama = PrefsData.instance.user!.nama;
    final facePoint = PrefsData.instance.user!.facePoint;
    data[nama] = jsonDecode(facePoint);
    jsonFile!.writeAsStringSync(jsonEncode(data));
  }

  void _initializeCamera() async {
    await loadModel();
    CameraDescription description = await getCamera(_direction);

    _camera =
        CameraController(description, ResolutionPreset.low, enableAudio: false);
    await _camera!.initialize();

    _camera!.startImageStream((CameraImage image) {
      if (_camera != null) {
        if (_isDetecting) return;
        _isDetecting = true;
        String res;
        dynamic finalResult = Multimap<String, Face>();
        detect(
                image: image,
                detectInImage: _getDetectionMethod(),
                imageRotation: description.sensorOrientation)
            .then(
          (dynamic result) async {
            if (result.length == 0) {
              _faceFound = false;
            } else {
              _faceFound = true;
            }
            Face face;
            img_lib.Image convertedImage =
                _convertCameraImage(image, _direction);
            for (face in result) {
              double x, y, w, h;
              x = (face.boundingBox.left - 10);
              y = (face.boundingBox.top - 10);
              w = (face.boundingBox.width + 10);
              h = (face.boundingBox.height + 10);
              img_lib.Image croppedImage = img_lib.copyCrop(
                  convertedImage, x.round(), y.round(), w.round(), h.round());
              croppedImage = img_lib.copyResizeCropSquare(croppedImage, 112);
              res = _recog(croppedImage);
              if (PrefsData.instance.user != null) {
                if (res != 'NOT RECOGNIZED' && res != 'NO FACE SAVED') {
                  _camera = null;
                  _faceDetector.close();
                  final nik = PrefsData.instance.user!.nik;
                  context.read<AbsenBloc>().add(DoAbsenEvent(nik));
                  Future.delayed(const Duration(seconds: 3), () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const SuccessPage(isRegistered: false),
                        ));
                  });
                  return;
                }
              }
              finalResult.add(res, face);
            }
            setState(() {
              _scanResults = finalResult;
            });

            _isDetecting = false;
          },
        ).catchError(
          (_) {
            _isDetecting = false;
          },
        );
      }
    });
  }

  Future loadModel() async {
    try {
      final gpuDelegateV2 = GpuDelegateV2(
          options: GpuDelegateOptionsV2(
              false,
              TfLiteGpuInferenceUsage.fastSingleAnswer,
              TfLiteGpuInferencePriority.minLatency,
              TfLiteGpuInferencePriority.auto,
              TfLiteGpuInferencePriority.auto));

      var interpreterOptions = InterpreterOptions()..addDelegate(gpuDelegateV2);
      interpreter =
          await Interpreter.fromAsset(tflite, options: interpreterOptions);
    } on Exception {
      if (kDebugMode) {
        print('Failed to load model.');
      }
    }
  }

  Future<dynamic> Function(GoogleVisionImage visionImage)
      _getDetectionMethod() {
    return _faceDetector.processImage;
  }

  Widget _buildResults() {
    const Text noResultsText = Text('');
    if (_scanResults == null ||
        _camera == null ||
        !_camera!.value.isInitialized) {
      return noResultsText;
    }
    CustomPainter painter;

    final Size imageSize = Size(
      _camera!.value.previewSize!.height,
      _camera!.value.previewSize!.width,
    );
    painter = FaceDetectorPainter(imageSize, _scanResults);
    return CustomPaint(
      painter: painter,
    );
  }

  Widget _buildImage() {
    if (_camera == null || !_camera!.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(
          color: kPurple,
        ),
      );
    }

    return Container(
      constraints: const BoxConstraints.expand(),
      child: _camera == null
          ? const Center(child: null)
          : Stack(
              fit: StackFit.expand,
              children: <Widget>[
                CameraPreview(_camera!),
                _buildResults(),
              ],
            ),
    );
  }

  @override
  void dispose() async {
    _faceDetector.close();
    if (_camera != null) {
      await _camera!.stopImageStream();
      await _camera!.dispose();
      _camera = null;
    }
    super.dispose();
  }

  img_lib.Image _convertCameraImage(
      CameraImage image, CameraLensDirection dir) {
    int width = image.width;
    int height = image.height;
    var img = img_lib.Image(width, height); // Create Image buffer
    const int hexFF = 0xFF000000;
    final int uvyButtonStride = image.planes[1].bytesPerRow;
    final int uvPixelStride = image.planes[1].bytesPerPixel!;
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        final int uvIndex =
            uvPixelStride * (x / 2).floor() + uvyButtonStride * (y / 2).floor();
        final int index = y * width + x;
        final yp = image.planes[0].bytes[index];
        final up = image.planes[1].bytes[uvIndex];
        final vp = image.planes[2].bytes[uvIndex];
        int r = (yp + vp * 1436 / 1024 - 179).round().clamp(0, 255);
        int g = (yp - up * 46549 / 131072 + 44 - vp * 93604 / 131072 + 91)
            .round()
            .clamp(0, 255);
        int b = (yp + up * 1814 / 1024 - 227).round().clamp(0, 255);
        img.data[index] = hexFF | (b << 16) | (g << 8) | r;
      }
    }
    var img1 = (dir == CameraLensDirection.front)
        ? img_lib.copyRotate(img, -90)
        : img_lib.copyRotate(img, 90);
    return img1;
  }

  String _recog(img_lib.Image img) {
    List input = imageToByteListFloat32(img, 112, 128, 128);
    input = input.reshape([1, 112, 112, 3]);
    List output = List.filled(1 * 192, 0).reshape([1, 192]);
    interpreter.run(input, output);
    output = output.reshape([192]);
    e1 = List.from(output);
    return compare(e1!).toUpperCase();
  }

  String compare(List currEmb) {
    if (data.length == 0) return "No Face saved";
    double minDist = 999;
    double currDist = 0.0;
    String predRes = "NOT RECOGNIZED";
    for (String label in data.keys) {
      currDist = euclideanDistance(data[label], currEmb);
      if (currDist <= threshold && currDist < minDist) {
        minDist = currDist;
        predRes = label;
      }
    }

    return predRes;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: _buildImage(),
      floatingActionButton: Visibility(
        visible: PrefsData.instance.user == null ? true : false,
        child: FloatingActionButton(
          onPressed: _faceFound
              ? () {
                  e2 = e1;
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: SizedBox(
                            height: 96,
                            child: Column(children: [
                              TextField(
                                controller: _nik,
                                style: kOpenSansRegular,
                                decoration:
                                    const InputDecoration(hintText: 'NIK'),
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: kPurple),
                                  onPressed: _faceFound
                                      ? () async {
                                          final response =
                                              await _karyawanRepository
                                                  .register(
                                                      _nik.text, e2.toString());
                                          _camera = null;
                                          _faceDetector.close();

                                          if (response.isRight()) {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const SuccessPage(
                                                          isRegistered: true),
                                                ));
                                          } else {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    content: Text(
                                                      'Gagal melakukan register',
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator
                                                                .pushReplacement(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              LoginPage(),
                                                                    ));
                                                          },
                                                          child: Text('Okay'))
                                                    ],
                                                  );
                                                });
                                          }
                                        }
                                      : null,
                                  child: const Text('Save'))
                            ]),
                          ),
                        );
                      });
                }
              : null,
          backgroundColor: _faceFound ? kYellow : kGrey,
          child: Icon(
            Icons.camera,
            color: _faceFound ? kPurple : kLightGrey,
          ),
        ),
      ),
    );
  }
}
