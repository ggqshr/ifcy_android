///@author ggq
///@description:
///@date :2019/9/3 9:45
part of "device_supervisor_component.dart";

class CheckAlarmPanelComponent extends StatelessWidget {
  final CheckAlarmMessage message;
  final CheckResultComponent resultComponents;

  CheckAlarmPanelComponent(this.message, this.resultComponents);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: ExpandablePanel(
        header: ListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: <Widget>[
            ListTile(
              title: Text("设备名称"),
              trailing: Text(message.deviceName),
            ),
            ListTile(
              title: Text("设备报警时间"),
              trailing: Text(message.recordTime.toString().substring(0, 19)),
            ),
            ListTile(
              title: Text("确认时间"),
              trailing: Text(DateTime.fromMillisecondsSinceEpoch(int.parse(message.checkTIme)).toString().substring(0,19)),
            ),
            resultComponents,
          ],
        ),
        collapsed: Container(),
        expanded: ListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: <Widget>[
            ListTile(
              title: Text("确认人"),
              trailing: Text(message.checkUserRealName),
            ),
            ListTile(
              title: Text("主机号"),
              trailing: Text(message.engineCode),
            ),
            ListTile(
              title: Text("设备编码"),
              trailing: Text(message.deviceCode),
            ),
          ],
        ),
        tapHeaderToExpand: true,
        hasIcon: true,
      ),
    );
  }
}

class CheckResultComponent extends StatelessWidget {
  final String result;

  CheckResultComponent(this.result);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("检查结果"),
      trailing: Text(result),
    );
  }
}
