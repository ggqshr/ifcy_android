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
          '设备故障申报处理',
          style: TextStyle(fontSize: 16),
        ),
        centerTitle: true,
      ),
//      floatingActionButton: FloatingActionButton(
//          child: Icon(Icons.arrow_upward),
//          onPressed: () {
//            //返回到顶部时执行动画
//            _scrollController.animateTo(.0,
//                duration: Duration(milliseconds: 200),
//                curve: Curves.ease
//            );
//          }
//      ),
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: <Widget>[
          SliverFillRemaining(
            child: Container(
              child: ListView(
                children: [
//                  getProcessedFaultDeclare(),
                ],
                physics: NeverScrollableScrollPhysics(),
              ),
            ),
          ),
        ],
      ),
    );

  }

//  getProcessedFaultDeclare() {
//    return StoreConnector<AppState, ProcessedDeviceFaultMessage>(
//        converter: (Store<AppState> store) {
//          DeviceSupervisorModel model = store.state.deviceSupervisorModel;
//          return FaultDeclareMessageViewModel(
//              processedDeviceFaultDeclareList: model.processedDeviceFaultList,
//              onRefreshCall: () async {
//                await Future.delayed(Duration(seconds: 2));
//              });
//        }, builder: (BuildContext context, FaultDeclareMessageViewModel vm) {
//      return Stack(
//        children: <Widget>[
//          RefreshIndicator(
//            child: ListView.builder(
//              itemCount: vm.processedDeviceFaultDeclareList.length,
//              key: PageStorageKey("FaultDeclarePagegetProcessedFaultDeclare"),
//              controller: _scrollController,
//              itemBuilder: (context, index) {
//                return Card(
//                  elevation: 5,
//                  margin: EdgeInsets.fromLTRB(15, 6, 15, 6),
//                  shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.circular(5)),
//                  child: Column(
//                    mainAxisSize: MainAxisSize.min,
//                    children: <Widget>[
//                      Flexible(
//                        flex: 3,
//                        child: ExpansionTile(
//                          key: PageStorageKey(
//                              "${vm.processedDeviceFaultDeclareList[index].id}"),
//                          title: Text(
//                            "申报编号:" +
//                                vm.processedDeviceFaultDeclareList[index]
//                                    .declareNum,
//                            textAlign: TextAlign.start,
//                            style: TextStyle(
//                              color: Colors.red,
//                              fontSize: 14,
//                            ),
//                          ),
//                          backgroundColor: Colors.white,
//                          initiallyExpanded: true,
//                          //默认是否展开
//                          children: <Widget>[
//                            Divider(
//                              color: Colors.black,
//                            ),
//                            ListTile(
//                              dense: true,
//                              title: Text(
//                                  "申报时间:   ${vm.processedDeviceFaultDeclareList[index].declareTime.substring(0, 19)}"),
//                            ),
//                            ListTile(
//                              dense: true,
//                              title: Text(
//                                  "申报内容:    ${vm.processedDeviceFaultDeclareList[index].deviceFaultDes}"),
//                            ),
//                            ListTile(
//                              dense: true,
//                              title: Text(
//                                  "备注说明:    ${vm.processedDeviceFaultDeclareList[index].remarks}"),
//                            ),
//                            ListTile(
//                              dense: true,
//                              title: Text(
//                                  "故障设备照片:  ${vm.processedDeviceFaultDeclareList[index].devicePhoto}"),
//                            ),
//                            Divider(
//                              color: Colors.black,
//                            ),
//                            ListTile(
//                              dense: true,
//                              leading: Icon(
//                                Icons.feedback,
//                                color: Colors.green,
//                              ),
//                              title: Text("申报处理反馈",style: TextStyle(fontSize: 14,color: Colors.green),),
//                            ),
//                            Divider(
//                              color: Colors.black,
//                            ),
//                            ListTile(
//                              dense: true,
//                              title: Text(
//                                  "处理结果:  ${vm.processedDeviceFaultDeclareList[index].declareFeedback}"),
//                            ),
//                            ListTile(
//                              dense: true,
//                              title: Text(
//                                  "处理时间:  ${vm.processedDeviceFaultDeclareList[index].feedbackTime}"),
//                            ),
//                            ListTile(
//                              dense: true,
//                              title: Text(
//                                  "处理人:  ${vm.processedDeviceFaultDeclareList[index].supervisor}"),
//                            ),
//                          ],
//                        ),
//                      )
//                    ],
//                  ),
//                );
//              },
//            ),
//            onRefresh: () async {
//              await vm.onRefreshCall();
//            },
//          ),
//        ],
//      );
//    });
//  }
}
