///@author ggq
///@description: 扫码检查页面
///@date :2019/8/13 20:03
part of 'device_staff_components.dart';

class ScanCodeToInspectionComponent extends StatelessWidget {
  ScanCodeToInspectionComponent();

  @override
  Widget build(BuildContext context) {
    DeviceDetailBloc bloc = BlocProvider.of<DeviceDetailBloc>(context);
    return BlocBuilder<DeviceDetailBloc,DeviceDetailState>(
      // ignore: missing_return
      builder: (context, state) {
        if (state is LoadingDetail) {
          return Scaffold(
            body: Text("加载中"),
          );
        }
        if (state is LoadedDetail) {
          return Scaffold(
            appBar: AppBar(
              title: Text("${state.model.name}"),
            ),
            body: ListView(
              shrinkWrap: true,
              children: <Widget>[
                InspectionTaskDetailPanel(
                  isExpansion: true,
                  isEdit: true,
                ),
              ],
            ),
            bottomNavigationBar: Container(
              height: 50,
              width: 250,
              child: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pop(state.model);
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
            ),
          );
        }
      },
    );
  }
}
