///@author ggq
///@description:
///@date :2019/9/7 15:14
part of "device_supvisor_pages.dart";

class ReportDevicePage extends StatelessWidget {
  final Map<String, String> mapStateToString = {
    "RUNNING": "正常",
    "DEFECT": "缺陷",
    "FAULT": "故障",
  };
  final Map<String, Color> mapStateToColor = {
    "RUNNING": Colors.green,
    "DEFECT": Colors.yellow,
    "FAULT": Colors.red,
  };

  @override
  Widget build(BuildContext context) {
    ReportDeviceBloc _bloc = BlocProvider.of<ReportDeviceBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("设备申报"),
        centerTitle: true,
      ),
      body: BlocListener<ReportDeviceBloc, ReportDeviceState>(
        listener: (context, state) async {
          if (state is LoadedReportDevicesState) {
            if (state.isSuccess) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('申报成功'),
                        Icon(Icons.check),
                      ],
                    ),
                  ),
                );
              await Future.delayed(Duration(seconds: 1));
              Navigator.of(context).pop();
            }
            if (state.isFault) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('提交失败，请稍后再试'), Icon(Icons.error)],
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
            }
            if (state.isSubmitting) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('提交中'),
                        CircularProgressIndicator(),
                      ],
                    ),
                  ),
                );
            }
          }
        },
        child: BlocBuilder<ReportDeviceBloc, ReportDeviceState>(
          // ignore: missing_return
          builder: (context, state) {
            if (state is LoadingReportDevicesState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is LoadErrorDeviceMessageState) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    FlatButton.icon(
                      icon: Icon(Icons.refresh),
                      label: Text("重新加载"),
                      onPressed: () => _bloc.dispatch(FetchReportDevice()),
                    ),
                  ],
                ),
              );
            }
            if (state is LoadedReportDevicesState) {
              if (state.devicesToShow.isEmpty) {
                return Center(
                  child: Text("无待申报设备"),
                );
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  var thisDevice = state.devicesToShow[index];
                  return Card(
                    child: ExpansionTile(
                      leading: Checkbox(
                        value: state.devicesToReport.contains(thisDevice.code),
                        onChanged: (value) {
                          if (value) {
                            _bloc.dispatch(AddToReportList(thisDevice.code));
                          } else {
                            _bloc.dispatch(
                                RemoveFromReportList(thisDevice.code));
                          }
                        },
                      ),
                      title: Text(thisDevice.name),
                      children: getExpandedWidget(thisDevice),
                    ),
                  );
                },
                itemCount: state.devicesToShow.length,
              );
            }
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<ReportDeviceBloc, ReportDeviceState>(
        builder: (context, state) {
          return Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: FlatButton(
              onPressed: (state is LoadedReportDevicesState &&
                      state.devicesToShow.isNotEmpty &&
                      state.devicesToReport.isNotEmpty)
                  ? () => _bloc.dispatch(ReportToServer())
                  : null,
              child: Text(
                "申报",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: Colors.blue,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
            ),
          );
        },
      ),
    );
  }

  List<Widget> getExpandedWidget(DeviceMessage device) {
    return [
      ListTile(
        dense: true,
        title: Text("位置"),
        trailing: Text("${device.floor}${device.area}"),
      ),
      ListTile(
        dense: true,
        title: Text("位置备注"),
        trailing: Text("${device.position}"),
      ),
      ListTile(
        dense: true,
        title: Text("设备状态"),
        trailing: Text(
          "${mapStateToString[device.status]}",
          style: TextStyle(
            color: mapStateToColor[device.status],
          ),
        ),
      ),
      ListTile(
        dense: true,
        title: Text("设备类别"),
        trailing: Text("${device.category}"),
      ),
      ListTile(
        dense: true,
        title: Text("设备类型"),
        trailing: Text("${device.online ? "线上设备" : "线下设备"}"),
      ),
    ];
  }
}
