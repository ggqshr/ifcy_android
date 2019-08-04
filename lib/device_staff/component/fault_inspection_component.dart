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
    return StoreConnector<AppState, FaultInspectionModel>(
      converter: (Store<AppState> store) {
        return FaultInspectionModel(
          tasks: store.state.deviceStaffModel.faultTasks,
          onRefreshCall: () async {
            await Future.delayed(Duration(seconds: 2));
          },
        );
      },
      builder: (BuildContext context, FaultInspectionModel vm) {
        return RefreshIndicator(
          onRefresh: () async {
            await vm.onRefreshCall();
          },
          child: ListView.builder(itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              elevation: 5,
              margin: EdgeInsets.fromLTRB(15, 6, 15, 6),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    dense: true,
                    title: Text("任务编号${vm.tasks[index].id}"),
                    trailing:
                        vm.tasks[index].taskStatus == TaskStatus.uncompleted
                            ? Text(
                                "待排查",
                                style: TextStyle(color: Colors.red),
                              )
                            : Text("已排查"),
                  ),
                  ListTile(
                    dense: true,
                    title: Text("任务内容：${vm.tasks[index].taskContent}"),
                  ),
                  ListTile(
                    dense: true,
                    title: Text("具体位置：${vm.tasks[index].location}"),
                  ),
                  ListTile(
                    dense: true,
                    title: Text("设备名称：${vm.tasks[index].deviceName}"),
                  ),
                  ListTile(
                    dense: true,
                    title: Text("设备故障警报时间：${vm.tasks[index].deviceBellTime}"),
                  ),
                  ListTile(
                    dense: true,
                    title: Text("委派人员：${vm.tasks[index].taskPeople}"),
                  ),
                  ListTile(
                    dense: true,
                    title: Text("任务创建时间：${vm.tasks[index].taskCreateTime}"),
                  ),
                  Divider(),
                  ButtonBar(
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () => Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text("跳转到${vm.tasks[index].id}"),
                              ),
                            ),
                        child: index % 2 == 0 ? Text("现场维修") : Text("查看详情"),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      RaisedButton(
                        onPressed: () => Scaffold.of(context).showSnackBar(
                            SnackBar(
                                content: Text("跳转到${vm.tasks[index].id}"))),
                        child: Text("申报维修"),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          itemCount: vm.tasks.length,),
        );
      },
    );
  }
}
