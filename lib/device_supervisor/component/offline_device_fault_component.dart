part of "device_supervisor_component.dart";

class OfflineDeviceFaultComponent extends StatefulWidget {
  OfflineDeviceFaultComponent({Key, key}) : super(key: key);

  @override
  _OfflineDeviceFaultComponentState createState() =>
      _OfflineDeviceFaultComponentState();
}

Widget _buildTableCell(String label) {
  return new Container(
    //单元格内小部件对齐方式
    alignment: Alignment.topLeft,
    padding: EdgeInsets.all(5.0),
    //文本小部件
    child: new Text(
      label,
      textAlign: TextAlign.left,
      style: TextStyle(color: Colors.black87, fontSize: 12.0),
      maxLines: 3,
      softWrap: true,
    ),
  );
}

class _OfflineDeviceFaultComponentState
    extends State<OfflineDeviceFaultComponent>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return StoreBuilder(builder: (context, Store<AppState> store) {
      var offlineDeviceFaultList = store.state.deviceSupervisorModel.offlineDeviceFaultList;
      return RefreshIndicator(
        child: ListView.builder(
            itemCount: offlineDeviceFaultList.length,
            key: PageStorageKey("OfflineDeviceFaultComponent"),
            controller: _scrollController,
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.fromLTRB(15, 6, 15, 6),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: ExpansionTile(
                  key: PageStorageKey("${offlineDeviceFaultList[index].id}"),
                  title: Text(
//                    vm.onlineDeviceFaultUnSuredMessage[index].alarmTimeLast.substring(1,20) +
//                        "${vm.onlineDeviceFaultUnSuredMessage[index].deviceLocation}" +
//                        "${vm.onlineDeviceFaultUnSuredMessage[index].deviceName}" +
                    "发出警报",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 11,
                    ),
                  ),
                  leading: Icon(
                    Icons.warning,
                    color: Colors.red,
                  ),
                  backgroundColor: Colors.white,
                  initiallyExpanded: true,
                  //默认是否展开
                  children: <Widget>[
                    Divider(
                      color: Colors.black,
                    ),
                    ListTile(
                      dense: true,
                      title: Text(
                          "设备名称:   ${offlineDeviceFaultList[index].deviceName}"),
                    ),
                    ListTile(
                      dense: true,
                      title: Text(
                          "设备类型:    ${offlineDeviceFaultList[index].deviceType}"),
                    ),
                    ListTile(
                      dense: true,
                      title: Text(
                          "故障设备位置:    ${offlineDeviceFaultList[index].deviceLocation}"),
                    ),
                    ListTile(
                      dense: true,
                      title: Text(
                          "设备故障描述:    ${offlineDeviceFaultList[index].deviceFaultDes}"),
                    ),
                    ListTile(
                      dense: true,
                      title: Text(
                          "检报时间:      ${offlineDeviceFaultList[index].deviceFaultTime.toString().substring(1, 20)}"),
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                        width: 18,
                    ),
                        Text("故障设备图片:"),
                        Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3caBRRBaDBug3hDSSgLFtlu5QkAE_dsc366ScpKc4ZvhilCbMDg',
                          scale: 0.5,
                          width: 100,
                          height: 120,
                        ),
                      ],
                    ),
                    ListTile(
                      dense: true,
                      title: Text("备注说明:  ${offlineDeviceFaultList[index].remarks}" ),
                    ),
                  ],
                ),
              );
            }),
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 2));
        },
      );
    });
  }
}
