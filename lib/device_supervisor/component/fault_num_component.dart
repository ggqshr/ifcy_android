part of 'device_supervisor_component.dart';

class FaultNumComponent extends StatelessWidget {
  final String deviceFaultNum;

  FaultNumComponent(this.deviceFaultNum);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(height: 120),
      child: Stack(
        children: <Widget>[
          Text(
            deviceFaultNum,
            style: TextStyle(
              color: Colors.yellow[600],
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
            textScaleFactor: 3.5,
          ),
          Positioned(
            child: Text("有故障的设备数"),
            bottom: 0,
          )
        ],
        alignment: AlignmentDirectional.center,
      ),
    );
  }
}
