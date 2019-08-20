part of "building_owner_pages.dart";

class FaultPage extends StatelessWidget {
  final Function drawerCall;

  FaultPage(this.drawerCall);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          '设备故障申报记录',
          style: TextStyle(fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            ),
            DeviceFaultDeclareListComponent(),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
            ),
          ],
        ),
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 2));
        },
      ),
    );
  }
}

class DeviceFaultDeclareListComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return StoreConnector <AppState, DeviceFaultDeclareModel>(
            converter: (Store<AppState> store) {
              BuildingOwnerModel model = store.state.buildingOwnerModel;
              return DeviceFaultDeclareModel(
                processedDeviceFaultList: model.processedDeviceFaultList,
                onRefreshCall: () async {
                  //todo 刷新回调
                  await Future.delayed(Duration(seconds: 2));
                },
              );
            },
            builder: (BuildContext context, DeviceFaultDeclareModel vm) {
              List<Widget> viewList = <Widget>[];
              if (vm.processedDeviceFaultList.length == 0) {
                viewList.add(ListTile(title: Text("当前无故障设备申报"),
                ));
              } else {
                viewList = vm.processedDeviceFaultList.map<Widget>((ProcessedDeviceFaultMessage msg) {
                  return ProcessedDeviceFaultMessageCard(msg);
                }).toList();
              }
              return Column(
                children: viewList,
              );
            },
          );
        },
        childCount: 1,
      ),
    );
  }
}


class ProcessedDeviceFaultMessageCard extends StatelessWidget {

  final ProcessedDeviceFaultMessage msg;

  ProcessedDeviceFaultMessageCard(this.msg);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Card(
        elevation: 5,
        margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: ExpansionTile(
          key: PageStorageKey("${msg.id}"),
          title: Text(
            "申报编号:" +
                msg.declareNum,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.red,
              fontSize: 14,
            ),
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
                  "申报时间:   ${msg.declareTime.substring(0, 19)}"),
            ),
            ListTile(
              dense: true,
              title: Text(
                  "申报内容:    ${msg.deviceFaultDes}"),
            ),
            ListTile(
              dense: true,
              title: Text(
                  "备注说明:    ${msg.remarks}"),
            ),
            ListTile(
              dense: true,
              title: Text(
                  "故障设备照片:  ${msg.devicePhoto}"),
            ),
            Divider(
              color: Colors.black,
            ),
            ListTile(
              dense: true,
              leading: Icon(
                Icons.feedback,
                color: Colors.green,
              ),
              title: Text(
                "申报处理反馈",
                style: TextStyle(
                    fontSize: 14, color: Colors.green),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            ListTile(
              dense: true,
              title: Text(
                  "处理结果:  ${msg.declareFeedback}"),
            ),
            ListTile(
              dense: true,
              title: Text(
                  "处理时间:  ${msg.feedbackTime}"),
            ),
            ListTile(
              dense: true,
              title: Text(
                  "处理人:  ${msg.supervisor}"),
            ),
          ],
        ),
//        child: Column(
//          mainAxisSize: MainAxisSize.min,
//          children: <Widget>[
//            Flexible(
//              flex: 3,
//              child: ExpansionTile(
//                key: PageStorageKey(
//                    "${msg.id}"),
//                title: Text(
//                  "申报编号:" +
//                      msg.declareNum,
//                  textAlign: TextAlign.start,
//                  style: TextStyle(
//                    color: Colors.red,
//                    fontSize: 14,
//                  ),
//                ),
//                backgroundColor: Colors.white,
//                initiallyExpanded: true,
//                //默认是否展开
//                children: <Widget>[
//                  Divider(
//                    color: Colors.black,
//                  ),
//                  ListTile(
//                    dense: true,
//                    title: Text(
//                        "申报时间:   ${msg.declareTime.substring(0, 19)}"),
//                  ),
//                  ListTile(
//                    dense: true,
//                    title: Text(
//                        "申报内容:    ${msg.deviceFaultDes}"),
//                  ),
//                  ListTile(
//                    dense: true,
//                    title: Text(
//                        "备注说明:    ${msg.remarks}"),
//                  ),
//                  ListTile(
//                    dense: true,
//                    title: Text(
//                        "故障设备照片:  ${msg.devicePhoto}"),
//                  ),
//                  Divider(
//                    color: Colors.black,
//                  ),
//                  ListTile(
//                    dense: true,
//                    leading: Icon(
//                      Icons.feedback,
//                      color: Colors.green,
//                    ),
//                    title: Text(
//                      "申报处理反馈",
//                      style: TextStyle(
//                          fontSize: 14, color: Colors.green),
//                    ),
//                  ),
//                  Divider(
//                    color: Colors.black,
//                  ),
//                  ListTile(
//                    dense: true,
//                    title: Text(
//                        "处理结果:  ${msg.declareFeedback}"),
//                  ),
//                  ListTile(
//                    dense: true,
//                    title: Text(
//                        "处理时间:  ${msg.feedbackTime}"),
//                  ),
//                  ListTile(
//                    dense: true,
//                    title: Text(
//                        "处理人:  ${msg.supervisor}"),
//                  ),
//                ],
//              ),
//            )
//          ],
//        ),
      ),
    );
  }
}

