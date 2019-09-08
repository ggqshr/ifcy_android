part of "device_supvisor_pages.dart";

class FaultDeclarePage extends StatefulWidget {
  Function drawerCall;

  FaultDeclarePage(this.drawerCall);

  @override
  _FaultDeclarePageState createState() => _FaultDeclarePageState();
}

class _FaultDeclarePageState extends State<FaultDeclarePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController;

  List<Tab> tabs = [
    Tab(
      child: Text('已处理故障申报'),
    ),
    Tab(
      child: Text('处理中故障申报'),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _scrollController = ScrollController(initialScrollOffset: 0);
  }

  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          '设备故障申报',
          style: TextStyle(fontSize: 16),
        ),
        centerTitle: true,
        bottom: TabBar(
          tabs: tabs,
          controller: _tabController,
          //labelColor: Colors.lightGreenAccent,   // 选中的Widget颜色
          indicatorColor: Colors.green,
          // 选中的指示器颜色
          labelStyle: TextStyle(fontWeight: FontWeight.w900),
          indicatorSize: TabBarIndicatorSize.label,
          indicatorWeight: 3,
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w100),
          isScrollable: false,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_upward),
          onPressed: () {
            //返回到顶部时执行动画
            _scrollController.animateTo(.0,
                duration: Duration(milliseconds: 200),
                curve: Curves.ease
            );
          }
      ),
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: <Widget>[
          SliverFillRemaining(
            child: Container(
              child: TabBarView(
                children: [
                  getProcessedFaultDeclare(),
                  getProcessingFaultDeclare()
                ],
                controller: _tabController,
                physics: NeverScrollableScrollPhysics(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getProcessedFaultDeclare() {
    return StoreConnector<AppState, FaultDeclareMessageViewModel>(
        converter: (Store<AppState> store) {
      DeviceSupervisorModel model = store.state.deviceSupervisorModel;
      return FaultDeclareMessageViewModel(
          processedDeviceFaultDeclareList: model.processedDeviceFaultList,
          onRefreshCall: () async {
            await Future.delayed(Duration(seconds: 2));
          });
    }, builder: (BuildContext context, FaultDeclareMessageViewModel vm) {
      return Stack(
        children: <Widget>[
          RefreshIndicator(
            child: ListView.builder(
              itemCount: vm.processedDeviceFaultDeclareList.length,
              key: PageStorageKey("FaultDeclarePagegetProcessedFaultDeclare"),
              controller: _scrollController,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.fromLTRB(15, 6, 15, 6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Flexible(
                        flex: 3,
                        child: ExpansionTile(
                          key: PageStorageKey(
                              "${vm.processedDeviceFaultDeclareList[index].id}"),
                          title: Text(
                            "申报编号:" +
                                vm.processedDeviceFaultDeclareList[index]
                                    .declareNum,
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
                                  "申报时间:   ${vm.processedDeviceFaultDeclareList[index].declareTime.substring(0, 19)}"),
                            ),
                            ListTile(
                              dense: true,
                              title: Text(
                                  "申报内容:    ${vm.processedDeviceFaultDeclareList[index].deviceFaultDes}"),
                            ),
                            ListTile(
                              dense: true,
                              title: Text(
                                  "备注说明:    ${vm.processedDeviceFaultDeclareList[index].remarks}"),
                            ),
                            ListTile(
                              dense: true,
                              title: Text(
                                  "故障设备照片:  ${vm.processedDeviceFaultDeclareList[index].devicePhoto}"),
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
                              title: Text("申报处理反馈",style: TextStyle(fontSize: 14,color: Colors.green),),
                            ),
                            Divider(
                              color: Colors.black,
                            ),
                            ListTile(
                              dense: true,
                              title: Text(
                                  "处理结果:  ${vm.processedDeviceFaultDeclareList[index].declareFeedback}"),
                            ),
                            ListTile(
                              dense: true,
                              title: Text(
                                  "处理时间:  ${vm.processedDeviceFaultDeclareList[index].feedbackTime}"),
                            ),
                            ListTile(
                              dense: true,
                              title: Text(
                                  "处理人:  ${vm.processedDeviceFaultDeclareList[index].supervisor}"),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            onRefresh: () async {
              await vm.onRefreshCall();
            },
          ),
        ],
      );
    });
  }

  getProcessingFaultDeclare() {
    return StoreConnector<AppState, FaultDeclareMessageViewModel>(
        converter: (Store<AppState> store) {
      DeviceSupervisorModel model = store.state.deviceSupervisorModel;
      return FaultDeclareMessageViewModel(
          processingDeviceFaultDeclareList: model.processingDeviceFaultList,
          onRefreshCall: () async {
            await Future.delayed(Duration(seconds: 2));
          });
    }, builder: (BuildContext context, FaultDeclareMessageViewModel vm) {
      return RefreshIndicator(
        child: ListView.builder(
            itemCount: vm.processingDeviceFaultDeclareList.length,
            key: PageStorageKey("FaultDeclarePagegetProcessingFaultDeclare"),
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.fromLTRB(15, 6, 15, 6),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    //Text("${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}"),
                    Flexible(
                      flex: 3,
                      child: ExpansionTile(
                        key: PageStorageKey(
                            "${vm.processingDeviceFaultDeclareList[index].id}"),
                        title: Text(
                          "申报编号:${vm.processingDeviceFaultDeclareList[index].declareNum}",
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
                                "申报时间:   ${vm.processingDeviceFaultDeclareList[index].declareTime.substring(0, 20)}"),
                          ),
                          ListTile(
                            dense: true,
                            title: Text(
                                "申报内容:    ${vm.processingDeviceFaultDeclareList[index].deviceFaultDes}"),
                          ),
                          ListTile(
                            dense: true,
                            title: Text(
                                "备注说明:    ${vm.processingDeviceFaultDeclareList[index].remarks}"),
                          ),
                          ListTile(
                            dense: true,
                            title: Text(
                                "故障设备照片:  ${vm.processingDeviceFaultDeclareList[index].devicePhoto}"),
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.feedback,
                              color: Colors.green,
                            ),
                            title: Text(
                              "处理中",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 14.0),
                            ),
                            trailing: IconButton(
                                icon: Icon(Icons.alarm, color: Colors.green),
                                onPressed: null),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }),
        onRefresh: () async {
          await vm.onRefreshCall();
        },
      );
    });
  }
}
