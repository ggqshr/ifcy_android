part of "device_supervisor_component.dart";

class OnlineDeviceFaultComponent extends StatefulWidget {
  @override
  _OnlineDeviceFaultComponentState createState() =>
      _OnlineDeviceFaultComponentState();
}

class _OnlineDeviceFaultComponentState extends State<OnlineDeviceFaultComponent>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _scrollController = ScrollController(initialScrollOffset: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  scroToTopCall() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(0,
          duration: Duration(seconds: 1), curve: Curves.ease);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: <Widget>[
        SliverPersistentHeader(
          delegate:
              ChangeOnlineDeviceFaultType(_tabController, scroToTopCall()),
        ),
        SliverFillRemaining(
          child: Container(
            child: TabBarView(
              children: [
                getUnconfirmedDeviceFault(),
                getConfirmedDeviceFault()
              ],
              controller: _tabController,
            ),
          ),
        )
      ],
    );
  }

  getUnconfirmedDeviceFault() {
    return StoreConnector<AppState, OnlineDeviceFaultMessageViewModel>(
      converter: (Store<AppState> store) {
        DeviceSupervisorModel model = store.state.deviceSupervisorModel;
        return OnlineDeviceFaultMessageViewModel(
            onlineDeviceFaultUnSuredMessage: model.onlineDeviceFaultUnSuredList,
            onRefreshCall: () async {
              await Future.delayed(Duration(seconds: 2));
            });
      },
      builder: (BuildContext context, OnlineDeviceFaultMessageViewModel vm) {
        print(vm);
        return RefreshIndicator(
          child: ListView.builder(
              itemCount: vm.onlineDeviceFaultUnSuredMessage.length,
              key: PageStorageKey("OnlineDeviceFaultComponentgetUnconfirmedDeviceFault"),
              controller: _scrollController,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.fromLTRB(15, 6, 15, 6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  child: ExpansionTile(
                    key: PageStorageKey("${vm.onlineDeviceFaultUnSuredMessage[index].id}"),
                    title: Text(
                      vm.onlineDeviceFaultUnSuredMessage[index].alarmTimeLast.substring(1,20) +
                          "${vm.onlineDeviceFaultUnSuredMessage[index].deviceLocation}" +
                          "${vm.onlineDeviceFaultUnSuredMessage[index].deviceName}" +
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
                            "设备名称:   ${vm.onlineDeviceFaultUnSuredMessage[index].deviceName}"),
                      ),
                      ListTile(
                        dense: true,
                        title: Text(
                            "设备位置:    ${vm.onlineDeviceFaultUnSuredMessage[index].deviceLocation}"),
                      ),
                      ListTile(
                        dense: true,
                        title: Text(
                            "首次报警时间:"+vm.onlineDeviceFaultUnSuredMessage[index].alarmTimeFirst.substring(1,20)),
                      ),
                      ListTile(
                        dense: true,
                        title: Text(
                            "最后一次报警时间:"+vm.onlineDeviceFaultUnSuredMessage[index].alarmTimeLast.substring(1,20)),
                      ),
                    ],
                  ),
                );
              }),
          onRefresh: () async {
            await vm.onRefreshCall();
          },
        );
      },
    );
  }

  getConfirmedDeviceFault() {
    return StoreConnector<AppState, OnlineDeviceFaultMessageViewModel>(
      converter: (Store<AppState> store) {
        DeviceSupervisorModel model = store.state.deviceSupervisorModel;
        return OnlineDeviceFaultMessageViewModel(
            onlineDeviceFaultSuredMessage: model.onlineDeviceFaultSuredList,
            onRefreshCall: () async {
              await Future.delayed(Duration(seconds: 2));
            });
      },
      builder: (BuildContext context, OnlineDeviceFaultMessageViewModel vm) {
        return RefreshIndicator(
          child: ListView.builder(
              itemCount: vm.onlineDeviceFaultSuredMessage.length,
              key: PageStorageKey("OnlineDeviceFaultComponentgetConfirmedDeviceFault"),
              controller: _scrollController,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.fromLTRB(15, 6, 15, 6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child:  ExpansionTile(
                    key: PageStorageKey("${vm.onlineDeviceFaultSuredMessage[index].id}"),
                    title: Text(
                      "${vm.onlineDeviceFaultSuredMessage[index].alarmTimeLast}" +
                          "${vm.onlineDeviceFaultSuredMessage[index].deviceLocation}" +
                          "${vm.onlineDeviceFaultSuredMessage[index].deviceName}" +
                          "发出警报",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 13,
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
                            "设备名称:${vm.onlineDeviceFaultSuredMessage[index].deviceName}"),
                      ),
                      ListTile(
                        dense: true,
                        title: Text(
                            "设备位置:${vm.onlineDeviceFaultSuredMessage[index].deviceLocation}"),
                      ),
                      ListTile(
                        dense: true,
                        title: Text(
                            "首次报警时间:${vm.onlineDeviceFaultSuredMessage[index].alarmTimeFirst}"),
                      ),
                      ListTile(
                        dense: true,
                        title: Text(
                            "最后一次报警时间:${vm.onlineDeviceFaultSuredMessage[index].alarmTimeLast}"),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      ListTile(
                        dense: true,
                        title: Text(
                            "反馈:${vm.onlineDeviceFaultSuredMessage[index].confirmResult}"),
                      ),
                      ListTile(
                        dense: true,
                        title: Text(
                            "确认人员:${vm.onlineDeviceFaultSuredMessage[index].excutor}"),
                      ),
                      ListTile(
                        dense: true,
                        title: Text(
                            "反馈时间:${vm.onlineDeviceFaultSuredMessage[index].faultDeclareTime}"),
                      ),
                      ListTile(
                        dense: true,
                        title: Text(
                            "设备故障原因:${vm.onlineDeviceFaultSuredMessage[index].deviceFaultDes}"),
                      ),
                      ListTile(
                        dense: true,
                        title: Text(
                            "设备故障照片:${vm.onlineDeviceFaultSuredMessage[index].devicePhoto}"),
                      ),
                      ListTile(
                        dense: true,
                        title: Text(
                            "备注说明:${vm.onlineDeviceFaultSuredMessage[index].remarks}"),
                      ),
                    ],
                  ),
                );
              }),
          onRefresh: () async {
            await vm.onRefreshCall();
          },
        );
      },
    );
  }
}

class ChangeOnlineDeviceFaultType extends SliverPersistentHeaderDelegate {

  TabController _tabController;
  Function scroCall;

  ChangeOnlineDeviceFaultType(this._tabController, this.scroCall);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return TabBar(
      tabs: <Widget>[
        Tab(
          child: Text("待确认"),
        ),
        Tab(
          child: Text("已确认"),
        )
      ],
      controller: _tabController,
      onTap: (index) {
        if (!_tabController.indexIsChanging) {
          scroCall();
        }
      },
    );
  }

  @override
  double get maxExtent => 40;

  @override
  double get minExtent => 40;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

