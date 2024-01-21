part of '../attendance_page.dart';

const double cameraZoom = 18;
const double cameraTilt = 10;
const double cameraBearing = 30;

class Maps extends StatefulWidget {
  const Maps({Key? key}) : super(key: key);

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  final Completer<GoogleMapController> _controller = Completer();
  Location? _location;
  LocationData? _currentLocation;
  StreamSubscription<LocationData>? _locationSubscription;
  final Set<Marker> _markers = <Marker>{};
  bool isInSelectedArea = false;
  LatLng? initialLocation;
  List<LatLng> polygonPoints = const [
    LatLng(-6.9450518458379324, 107.60260411764959),
    LatLng(-6.9451009234508225, 107.6029294672563),
    LatLng(-6.945409637349967, 107.60286726806679),
  ];

  @override
  void initState() {
    super.initState();

    context.read<MapBloc>().add(const SetMapAreaEvent(false));

    if (_locationSubscription != null) {
      _locationSubscription!.resume();
    }

    _location = Location();
    _locationSubscription = _location!.onLocationChanged.listen((event) {
      _currentLocation = event;
      updatePinOnMap();
    });
    setInitialLocation();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    _locationSubscription!.pause();
    super.dispose();
  }

  void setInitialLocation() async {
    _currentLocation = await _location!.getLocation();
  }

  void updatePinOnMap() async {
    CameraPosition cPosition = CameraPosition(
      zoom: cameraZoom,
      tilt: cameraTilt,
      bearing: cameraBearing,
      target: LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    final BitmapDescriptor markerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, mapMarker);

    setState(() {
      if (_currentLocation != null) {
        var pinPosition =
            LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!);

        _markers.clear();
        _markers.add(Marker(
            markerId: const MarkerId('sourcePin'),
            position: pinPosition,
            icon: markerIcon));
        isInSelectedArea = checkUpdatedLocation(pinPosition, polygonPoints);
        context.read<MapBloc>().add(SetMapAreaEvent(isInSelectedArea));
      }
    });
  }

  bool checkUpdatedLocation(LatLng coordinates, List<LatLng> polygonPoints) {
    List<map_tool.LatLng> convertedPolygonPoints = polygonPoints
        .map((e) => map_tool.LatLng(e.latitude, e.longitude))
        .toList();

    return map_tool.PolygonUtil.containsLocation(
        map_tool.LatLng(coordinates.latitude, coordinates.longitude),
        convertedPolygonPoints,
        false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.h,
      width: double.infinity,
      color: kLightGrey,
      child: Stack(
        children: [
          BlocBuilder<KordinatBloc, KordinatState>(
            builder: (context, state) {
              if (state is KordinatSuccess) {
                final result =
                    state.data.where((e) => e.nama == 'initial').toList();

                initialLocation = LatLng(result[0].lat, result[0].lng);

                final polygon =
                    state.data.where((e) => e.nama != 'initial').toList();
                polygonPoints = [];
                for (var e in polygon) {
                  polygonPoints.add(LatLng(e.lat, e.lng));
                }

                return GoogleMap(
                    myLocationEnabled: false,
                    compassEnabled: false,
                    tiltGesturesEnabled: false,
                    zoomControlsEnabled: false,
                    mapType: MapType.normal,
                    polygons: {
                      Polygon(
                          polygonId: const PolygonId('polygonPoints'),
                          points: polygonPoints,
                          fillColor: const Color(0xFF006491).withOpacity(0.2),
                          strokeWidth: 2)
                    },
                    markers: _markers,
                    initialCameraPosition: CameraPosition(
                        zoom: 16,
                        tilt: cameraTilt,
                        bearing: cameraBearing,
                        target: initialLocation!),
                    onMapCreated: (GoogleMapController controller) {
                      if (!_controller.isCompleted) {
                        _controller.complete(controller);
                        if (_currentLocation != null) {
                          var pinPosition = LatLng(_currentLocation!.latitude!,
                              _currentLocation!.longitude!);

                          _markers.clear();
                          _markers.add(Marker(
                            markerId: const MarkerId('sourcePin'),
                            position: pinPosition,
                          ));
                        }
                      }
                    });
              }
              return const SizedBox();
            },
          ),
          Positioned(
            right: 5,
            bottom: 5,
            child: Material(
              color: kYellow,
              type: MaterialType.circle,
              clipBehavior: Clip.antiAlias,
              borderOnForeground: true,
              elevation: 0,
              child: IconButton(
                onPressed: () {
                  updatePinOnMap();
                },
                icon: const Icon(Icons.my_location),
                color: kPurple,
                padding: const EdgeInsets.all(10),
              ),
            ),
          )
        ],
      ),
    );
  }
}
