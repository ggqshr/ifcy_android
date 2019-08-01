///@author ggq
///@description: 故障确认任务的列表
///@date :2019/8/1 11:04

part of "device_staff_components.dart";

class FaultInspectionComponent extends StatefulWidget {
  @override
  _FaultInspectionComponentState createState() =>
      _FaultInspectionComponentState();
}

class _FaultInspectionComponentState extends State<FaultInspectionComponent> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        elevation: 5,
        margin: EdgeInsets.fromLTRB(15, 6, 15, 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              dense: true,
              title: Text("任务编号$index"),
              trailing: index % 2 == 0 ? Text("待排查") : Text("已排查"),
            ),
            ListTile(
              dense: true,
              title: Text("任务内容：111"),
            ),
            ListTile(
              dense: true,
              title: Text("具体位置：111"),
            ),
            ListTile(
              dense: true,
              title: Text("设备名称：111"),
            ),
            ListTile(
              dense: true,
              title: Text("设备故障警报时间：111"),
            ),
            ListTile(
              dense: true,
              title: Text("委派人员：111"),
            ),
            ListTile(
              dense: true,
              title: Text("任务创建时间：111"),
            ),
            Divider(),
            ButtonBar(
              children: <Widget>[
                RaisedButton(
                  onPressed: () => {},
                  child: index % 2 == 0 ? Text("现场维修") : Text("查看详情"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                RaisedButton(
                  onPressed: () => {},
                  child: Text("申报维修"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
