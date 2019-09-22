part of "components.dart";

class StackMap extends StatefulWidget {
  final double height;
  final double width;
  final ImageProvider buildingMap;
  final List<Marker> markers;

  const StackMap({
    @required this.height,
    @required this.width,
    @required this.buildingMap,
    @required this.markers,
  });

  @override
  _StackMapState createState() => _StackMapState();
}

class _StackMapState extends State<StackMap> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        zoom: 3,
        center: LatLng(-widget.height/2, widget.width/2),
        plugins: [
          MarkerClusterPlugin(),
        ],
      ),
      layers: [
        OverlayImageLayerOptions(
          overlayImages: [
            OverlayImage(
              imageProvider: widget.buildingMap,
              bounds: LatLngBounds(
                LatLng(0, 0),
                LatLng(-widget.height, widget.width),
              ),
            ),
          ],
        ),
        MarkerClusterLayerOptions(
          maxClusterRadius: 0,
          size: Size(0, 0),
          anchor: AnchorPos.align(AnchorAlign.center),
          markers: widget.markers,
          polygonOptions: PolygonOptions(
              borderColor: Colors.red, color: Colors.red, borderStrokeWidth: 3),
          builder: (context, markers) {
            return Container();
          },
        ),
      ],
    );
  }
}

Marker parseMarker({double x, double y, String imageName}) {
  return Marker(
    point: LatLng(-y, x),
    anchorPos: AnchorPos.align(AnchorAlign.center),
    builder: (ctx) => Image.asset(imageName),
  );
}
