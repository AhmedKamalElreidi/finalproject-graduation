part of 'map_screen.dart';

class MyMapViewWidget extends StatefulWidget {
  final List<CompoundModel> compounds;
  const MyMapViewWidget({Key key, @required this.compounds}) : super(key: key);
  @override
  _MyMapViewWidgetState createState() => _MyMapViewWidgetState();
}

class _MyMapViewWidgetState extends State<MyMapViewWidget> {
  Map<String, Marker> markers = {};
  BitmapDescriptor mapMarker;
  GoogleMapController controller;
  CompoundModel compound = CompoundModel();

  @override
  void initState() {
    setUpMarkerIcon();
    super.initState();
  }

  _onMapCreated() {
    widget.compounds.forEach((_compound) {
      var marker = Marker(
        zIndex: 13,
        onTap: () {
          final LatLng latLng = LatLng(double.parse(_compound.location.lat),
              double.parse(_compound.location.long));
          controller
            ..moveCamera(CameraUpdate.newLatLng(
              latLng,
            ))
            ..moveCamera(CameraUpdate.scrollBy(0, 65));

          showCompoundBottomSheet(
            context: context,
            compound: _compound,
          );
          setState(() {
            compound = _compound;
          });
        },
        icon: compound != _compound
            ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)
            : mapMarker,
        position: LatLng(double.parse(_compound.location.lat),
            double.parse(_compound.location.long)),
        infoWindow: InfoWindow(
          title: _compound.name,
          snippet: "${_compound.distinct} compound",
        ),
        markerId: MarkerId(_compound.id),
      );
      markers[_compound.name] = marker;
    });
    setState(() {});
  }

  final LatLng _center = const LatLng(29.999062, 31.728331);

  @override
  Widget build(BuildContext context) {
    _onMapCreated();

    return ResponsiveBuilder(
      builder: (context, deviceInfo) => GoogleMap(
        trafficEnabled: true,

        indoorViewEnabled: false,
        mapToolbarEnabled: true,
        compassEnabled: true,
        rotateGesturesEnabled: true,
        tiltGesturesEnabled: true,
        buildingsEnabled: true,

        myLocationEnabled: false,
        // onMapCreated:
        onTap: (argument) {
          dismissed();
        },
        onMapCreated: (_controller) => controller = _controller,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 12,
        ),
        markers: markers.values.toSet(),
      ),
    );
  }

  void dismissed() {
    compound = CompoundModel();
    setState(() {});
  }
   ///get image or icon from assets and convert it to bytes to use it as bitmap
  ///to add this icon alternative of parameters.
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }
  ///load asset icon and convert into bytes then convert bytes into bitmap icon (google map special marker)
  void setUpMarkerIcon() async {
    final Uint8List markerIcon =
        await getBytesFromAsset(Assets.imagesSelectedMarker, 180);

    mapMarker = BitmapDescriptor.fromBytes(markerIcon);
  }
}
