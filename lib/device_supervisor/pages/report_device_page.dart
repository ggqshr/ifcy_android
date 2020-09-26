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
      body: BlocBuilder<ReportDeviceBloc, ReportDeviceState>(
          // ignore: missing_return
          builder: (context, state) {
            if (state is LoadingReportDevicesState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is LoadErrorDeviceMessageState) {
              return LoadErrorPage(() => _bloc.add(FetchReportDevice()));
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
                            _bloc.add(AddToReportList(thisDevice.code));
                          } else {
                            _bloc.add(
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
                  ? () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        TextEditingController titleController =
                        TextEditingController();
                        titleController.text = "设备故障";
                        TextEditingController contentController =
                        TextEditingController();
                        return Scaffold(
                          appBar: AppBar(
                            title: Text("申报信息填写"),
                            centerTitle: true,
                          ),
                          body: BlocProvider.value(
                            value: _bloc,
                            child: BlocListener<ReportDeviceBloc, ReportDeviceState>(
                              listener: (context, state) async {
                                if (state is LoadedReportDevicesState) {
                                  if (state.isSuccess) {
                                    Scaffold.of(context)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(
                                        SnackBar(
                                          content: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('申报成功'),
                                              Icon(Icons.check),
                                            ],
                                          ),
                                        ),
                                      );
                                    _bloc.add(FetchReportDevice());
                                    await Future.delayed(Duration(seconds: 1));
                                    Navigator.of(context).pop();
                                  }
                                  if (state.isFault) {
                                    Scaffold.of(context)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(
                                        SnackBar(
                                          content: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('提交失败，请稍后再试'),
                                              Icon(Icons.error)
                                            ],
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
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                              child: Container(
                                height: 500,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(20, 100, 20, 0),
                                  child: Form(
                                    autovalidate: true,
                                    child: ListView(
                                      shrinkWrap: true,
                                      children: <Widget>[
                                        TextFormField(
                                          controller: titleController,
                                          decoration: InputDecoration(
                                            labelText: "申报标题",
                                            hintText: "标题",
                                            prefixIcon: Icon(Icons.title),
                                            errorStyle: TextStyle(
                                                color: Colors.red, fontSize: 18),
                                          ),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return "请输入标题";
                                            }
                                            return null;
                                          },
                                          autovalidate: true,
                                        ),
                                        TextFormField(
                                          controller: contentController,
                                          decoration: InputDecoration(
                                            labelText: "申报备注",
                                            hintText: "备注",
                                            prefixIcon:
                                            Icon(Icons.format_color_text),
                                            errorStyle: TextStyle(
                                                color: Colors.red, fontSize: 18),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          bottomNavigationBar: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            child: FlatButton(
                              onPressed: () {
                                _bloc.add(ReportToServer(
                                    titleController.text??"设备故障了",
                                    contentController.text));
                              },
                              child: Text(
                                "提交",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              color: Colors.blue,
                              disabledColor: Colors.grey,
                              disabledTextColor: Colors.black,
                            ),
                          ),
                        );
                      }));
                    }
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
      if (device.online != null)
        ListTile(
          dense: true,
          title: Text("设备类型"),
          trailing: Text("${device.online ? "线上设备" : "线下设备"}"),
        ),
    ];
  }
}
