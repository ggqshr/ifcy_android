part of 'device_supervisor_compoent.dart';

class FaultNumCompoent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(height: 120),
      child: Stack(
        children: <Widget>[
          Text(
            StoreProvider.of<AppState>(context)
                .state
                .deviceSupervisorModel
                .faultNum
                .toString(),
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
            textScaleFactor: 3.5,
          ),
          Positioned(
            child: Text("设备故障数"),
            bottom: 0,
          )
        ],
        alignment: AlignmentDirectional.center,
      ),
    );
  }
}
