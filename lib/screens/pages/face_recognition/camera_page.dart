import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_ml_vision/google_ml_vision.dart';
import 'package:image/image.dart' as imglib;

// import 'package:path_provider/path_provider.dart';
import 'package:quiver/collection.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;

import '../../../data/repositories/repositories.dart';
import '../../../screens/pages/face_recognition/success_page.dart';
import '../../../bloc/absen/absen_bloc.dart';
import '../../../shared/shared.dart';
import '../../../utility/prefs_data.dart';
import '../login/login_page.dart';
import 'model.dart';
import 'utils.dart';
import 'detector.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addObserver(this);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    _start();
  }

  void _start() async {
    interpreter = await loadModel();
    initialCamera();
  }

  @override
  void dispose() async {
    WidgetsBinding.instance!.removeObserver(this);
    if (_camera != null) {
      await _camera!.stopImageStream();
      await Future.delayed(const Duration(milliseconds: 200));
      await _camera!.dispose();
      _camera = null;
    }
    super.dispose();
  }

  Future<dynamic> Function(GoogleVisionImage visionImage) getDetectionMethod() {
    return _faceDetector.processImage;
  }

  // late File jsonFile;
  var interpreter;
  CameraController? _camera;
  dynamic data = {};
  bool _isDetecting = false;
  double threshold = 1.0;
  dynamic _scanResults;
  String _predRes = '';
  bool isStream = true;

  // Directory? tempDir;
  bool _faceFound = false;
  bool _verify = false;
  List? e1;
  bool loading = true;
  final FaceDetector _faceDetector = GoogleVision.instance
      .faceDetector(const FaceDetectorOptions(enableContours: true));
  final TextEditingController _nik_controler = TextEditingController();
  int countValid = 0;
  final KaryawanRepository _karyawanRepository = KaryawanRepository();

  void initialCamera() async {
    CameraDescription description = await getCamera(CameraLensDirection.front);

    _camera = CameraController(
      description,
      ResolutionPreset.low,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );
    await _camera!.initialize();
    await Future.delayed(const Duration(milliseconds: 500));
    loading = false;

    // tempDir = await getApplicationDocumentsDirectory();
    // String _embPath = tempDir!.path + '/emb.json';
    // jsonFile = File(_embPath);
    //
    // data[_nik.text] = e1;
    // jsonFile.writeAsStringSync(
    //     json.encode(data));
    //
    // if (jsonFile.existsSync()) {
    //   data = json.decode(jsonFile.readAsStringSync());
    // }
    if (PrefsData.instance.user != null) {
      final _nama = PrefsData.instance.user!.nama;
      final facePoint = PrefsData.instance.user!.facePoint;
      data[_nama] = jsonDecode(facePoint);
    }

    await Future.delayed(const Duration(milliseconds: 500));

    _camera!.startImageStream((CameraImage image) async {
      if (_camera != null) {
        if (_isDetecting) return;
        _isDetecting = true;
        dynamic finalResult = Multimap<String, Face>();

        detect(image, getDetectionMethod()).then((dynamic result) async {
          if (result.length == 0 || result == null) {
            _faceFound = false;
            _predRes = 'Face not found';
          } else {
            _faceFound = true;
          }

          String res = '';
          Face _face;

          imglib.Image convertedImage =
              convertCameraImage(image, CameraLensDirection.front);

          for (_face in result) {
            double x, y, w, h;
            x = (_face.boundingBox.left - 50);
            y = (_face.boundingBox.top - 50);
            w = (_face.boundingBox.width + 50);
            h = (_face.boundingBox.height + 50);
            imglib.Image croppedImage = imglib.copyCrop(
                convertedImage, x.round(), y.round(), w.round(), h.round());
            croppedImage = imglib.copyResizeCropSquare(croppedImage, 112);
            res = recog(croppedImage);
            finalResult.add(res, _face);
          }

          _scanResults = finalResult;
          _isDetecting = false;
          if (PrefsData.instance.user != null) {
            final _nama = PrefsData.instance.user!.nama;
            if (res.toLowerCase() == _nama.toLowerCase()) {
              countValid++;
            } else {
              countValid = 0;
            }
          }
          setState(() {});
        }).catchError(
          (_) async {
            _isDetecting = false;
            if (_camera != null) {
              await _camera!.stopImageStream();
              await Future.delayed(const Duration(milliseconds: 400));
              await _camera!.dispose();
              await Future.delayed(const Duration(milliseconds: 400));
              _camera = null;
            }
          },
        );
      }
    });
  }

  String recog(imglib.Image img) {
    List input = imageToByteListFloat32(img, 112, 128, 128);
    input = input.reshape([1, 112, 112, 3]);
    List output = List.filled(1 * 192, null, growable: false).reshape([1, 192]);
    interpreter.run(input, output);
    output = output.reshape([192]);
    e1 = List.from(output);
    return compare(e1!).toUpperCase();
  }

  String compare(List currEmb) {
    double minDist = 999;
    double currDist = 0.0;
    _predRes = "Not Recognized";
    for (String label in data.keys) {
      currDist = euclideanDistance(data[label], currEmb);
      if (currDist <= threshold && currDist < minDist) {
        minDist = currDist;
        _predRes = label;
        if (_verify == false) {
          _verify = true;
        }
      }
    }
    return _predRes;
  }

  @override
  Widget build(BuildContext context) {
    if (PrefsData.instance.user != null && countValid > 15) {
      _camera = null;
      _faceDetector.close();
      final _nik = PrefsData.instance.user!.nik;
      context.read<AbsenBloc>().add(SendAbsenEvent(_nik));
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const SuccessPage(),
            ));
      });
    }

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text('Face Recognition'),
        ),
        body: Builder(builder: (context) {
          if ((_camera == null || !_camera!.value.isInitialized) || loading) {
            return const Center(
              child: CircularProgressIndicator(color: kPurple),
            );
          }
          return Container(
            constraints: const BoxConstraints.expand(),
            padding: EdgeInsets.only(
                top: 0, bottom: MediaQuery.of(context).size.height * 0.2),
            child: _camera == null
                ? const Center(child: SizedBox())
                : Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      CameraPreview(_camera!),
                      _buildResults(),
                    ],
                  ),
          );
        }),
        floatingActionButton: Visibility(
          visible: PrefsData.instance.user == null ? true : false,
          child: FloatingActionButton(
              onPressed: _faceFound
                  ? () {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      controller: _nik_controler,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Cancel')),
                                        ElevatedButton(
                                            style: OutlinedButton.styleFrom(
                                                foregroundColor: kWhite,
                                                backgroundColor: kPurple),
                                            onPressed: () async {
                                              final response =
                                                  await _karyawanRepository
                                                      .register(
                                                          _nik_controler.text,
                                                          e1.toString());
                                              String message =
                                                  'Failed to register';
                                              if (response.isRight()) {
                                                message = 'Success to register';
                                              }
                                              if (_camera != null) {
                                                await _camera!
                                                    .stopImageStream();
                                                await Future.delayed(
                                                    const Duration(
                                                        milliseconds: 400));
                                                await _camera!.dispose();
                                                await Future.delayed(
                                                    const Duration(
                                                        milliseconds: 400));
                                                _camera = null;
                                              }
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      content: Text(
                                                        message,
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
                                            },
                                            child: const Text(
                                              'Register',
                                            ))
                                      ],
                                    )
                                  ]),
                            );
                          });
                    }
                  : null,
              backgroundColor: _faceFound ? kYellow : kGrey,
              child:
                  Icon(Icons.camera, color: _faceFound ? kPurple : kLightGrey)),
        ));
  }

  Widget _buildResults() {
    Center noResultsText = const Center(
        child: Text('Please wait...',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Colors.white)));
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
}
