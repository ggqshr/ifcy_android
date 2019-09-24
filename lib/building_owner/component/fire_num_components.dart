part of "building_owner_component.dart";

class FireNumComponent extends StatelessWidget {
  final String deviceFaultNum;

  FireNumComponent(this.deviceFaultNum);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(height: 120),
      child: Stack(
        children: <Widget>[
          Text(
            deviceFaultNum,
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
            textScaleFactor: 3.5,
          ),
          Positioned(
            child: Text("火警报警数"),
            bottom: 0,
          )
        ],
        alignment: AlignmentDirectional.center,
      ),
    );
  }
}
