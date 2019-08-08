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
              key: PageStorageKey(
                  "OnlineDeviceFaultComponentgetUnconfirmedDeviceFault"),
              controller: _scrollController,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.fromLTRB(15, 6, 15, 6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Flexible(
                        flex: 2,
                        child: ExpansionTile(
                          title: Text(
                            "${vm.onlineDeviceFaultUnSuredMessage[index].alarmTimeLast}" +
                                "${vm.onlineDeviceFaultUnSuredMessage[index].deviceLocation}" +
                                "${vm.onlineDeviceFaultUnSuredMessage[index].deviceName}" +
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
                                  "设备名称:${vm.onlineDeviceFaultUnSuredMessage[index].deviceName}"),
                            ),
                            ListTile(
                              dense: true,
                              title: Text(
                                  "设备位置:${vm.onlineDeviceFaultUnSuredMessage[index].deviceLocation}"),
                            ),
                            ListTile(
                              dense: true,
                              title: Text(
                                  "首次报警时间:${vm.onlineDeviceFaultUnSuredMessage[index].alarmTimeFirst}"),
                            ),
                            ListTile(
                              dense: true,
                              title: Text(
                                  "最后一次报警时间:${vm.onlineDeviceFaultUnSuredMessage[index].alarmTimeLast}"),
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
              key: PageStorageKey(
                  "OnlineDeviceFaultComponentgetConfirmedDeviceFault"),
              controller: _scrollController,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.fromLTRB(15, 6, 15, 6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Flexible(
                        flex: 2,
                        child: ExpansionTile(
                          title: Text(
                            "${vm.onlineDeviceFaultSuredMessage[index].faultDeclareTime}" +
                                "${vm.onlineDeviceFaultSuredMessage[index].deviceLocation}" +
                                "${vm.onlineDeviceFaultUnSuredMessage[index].deviceName}" +
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
                                  "设备名称:${vm.onlineDeviceFaultUnSuredMessage[index].deviceName}"),
                            ),
                            ListTile(
                              dense: true,
                              title: Text(
                                  "设备位置:${vm.onlineDeviceFaultUnSuredMessage[index].deviceLocation}"),
                            ),
                            ListTile(
                              dense: true,
                              title: Text(
                                  "首次报警时间:${vm.onlineDeviceFaultUnSuredMessage[index].alarmTimeFirst}"),
                            ),
                            ListTile(
                              dense: true,
                              title: Text(
                                  "最后一次报警时间:${vm.onlineDeviceFaultUnSuredMessage[index].alarmTimeLast}"),
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
      },
    );
  }
}

class ChangeOnlineDeviceFaultType extends SliverPersistentHeaderDelegate {
  TabController _tabController;
  Function scroCall;

  ChangeOnlineDeviceFaultType(this._tabController, this.scroCall);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
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

