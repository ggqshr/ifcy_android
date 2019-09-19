part of "components.dart";

class StackMap extends StatefulWidget {
  final double buildHeight;
  final double buildWidth;
  final String backgroundImgUrl;

  StackMap({this.buildHeight, this.buildWidth, this.backgroundImgUrl});

  @override
  _StackMapState createState() => _StackMapState();
}

class _StackMapState extends State<StackMap> {
  Future<List<ui.Image>> init() async {
    List<ui.Image> images = [];
    images.add(await loadImage("images/build_floor.png", 200, 100));
    images.add(await loadImage("images/fire.png", 30, 30));
    return images;
  }

  Future<ui.Image> loadImage(name, width, height) async {
    final ByteData data = await rootBundle.load(name);
    final ss = await instantiateImageCodec(Uint8List.view(data.buffer),
        targetHeight: height, targetWidth: width);
    final sss = await ss.getNextFrame();
    return sss.image;
  }

  @override
  Widget build(BuildContext context) {
    Future<List<ui.Image>> ss = init();
    return Scaffold(
      body: FutureBuilder(
        future: ss,
        // ignore: missing_return
        builder: (context, AsyncSnapshot<List<ui.Image>> snapshot) {
          if (snapshot.hasData) {
            return CustomPaint(
              size: Size(200, 200),
              painter: MapPainter(
                snapshot.data[0],
                snapshot.data.getRange(1, snapshot.data.length).toList(),
              ),
            );
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Text("Error");
          } else {
            return Text("loading");
          }
        },
      ),
    );
  }
}

class MapPainter extends CustomPainter {
  ui.Image image;
  List<ui.Image> icons;

  MapPainter(this.image, this.icons);

  @override
  void paint(Canvas canvas, Size size) async {
    canvas.drawImage(image, Offset(0, 0), Paint());
    for (var i in icons) {
      canvas.drawImage(i, Offset(20, 40), Paint());
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class MapAndIcon extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {}

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
