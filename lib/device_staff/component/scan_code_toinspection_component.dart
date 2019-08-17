///@author ggq
///@description: 扫码检查页面
///@date :2019/8/13 20:03
part of 'device_staff_components.dart';

class ScanCodeToInspectionComponent extends StatelessWidget {
  final RegularInspectionTaskDetail taskDetail;

  ScanCodeToInspectionComponent(this.taskDetail);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: taskDetail,
      child: Scaffold(
        appBar: AppBar(
          title: Text("${taskDetail.deviceName}"),
        ),
        body: ListView(
          children: <Widget>[
            InspectionTaskDetailPanel(true),
          ],
        ),
        bottomNavigationBar: Consumer<RegularInspectionTaskDetail>(
          builder: (context, model, child) {
            return Container(
              height: 50,
              width: 250,
              child: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pop(model);
                      },
                      child: Text(
                        "添加到待上传列表",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
