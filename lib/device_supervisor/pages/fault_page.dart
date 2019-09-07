part of "device_supvisor_pages.dart";

class FaultPage extends StatefulWidget {
  Function drawerCall;

  FaultPage(this.drawerCall);

  @override
  _FaultPageState createState() => _FaultPageState();
}

class _FaultPageState extends State<FaultPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _controller;
  ScrollController _scrollController;
  EasyRefreshController _faultController;
  EasyRefreshController _runningController;
  DeviceMessageBloc _bloc;
  Map<String, String> mapStateToString = {
    "RUNNING": "正常",
    "DEFECT": "缺陷",
    "FAULT": "故障",
  };
  Map<String, Color> mapStateToColor = {
    "RUNNING": Colors.green,
    "DEFECT": Colors.yellow,
    "FAULT": Colors.red,
  };

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    _scrollController = ScrollController(initialScrollOffset: 0);
    _faultController = EasyRefreshController();
    _runningController = EasyRefreshController();
    _bloc = BlocProvider.of<DeviceMessageBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _scrollController.dispose();
    _faultController.dispose();
    _runningController.dispose();
  }

  scroToTopCall() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(0,
          duration: Duration(seconds: 1), curve: Curves.ease);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeviceMessageBloc, DeviceMessageState>(
      listener: (context, state) {
        _runningController.resetLoadState();
        _faultController.resetLoadState();
        if (state is LoadedDeviceMessageState) {
          if (state.faultListReachMax) {
            _faultController.finishLoad(success: true, noMore: true);
          }
          if (state.runningListReachMax) {
            _runningController.finishLoad(success: true, noMore: true);
          }
          if (!state.faultListReachMax) {
            _faultController.finishLoad(success: true);
          }
          if (!state.runningListReachMax) {
            _runningController.finishLoad(success: true);
          }
        }
        if (state is LoadErrorDeviceMessageState) {
          _runningController.finishLoad(success: false);
          _faultController.finishLoad(success: false);
        }
      },
      child: BlocBuilder<DeviceMessageBloc, DeviceMessageState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("设备列表"),
              actions: <Widget>[
                FlatButton(
                  child: Text("设备申报"),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return BlocProvider<ReportDeviceBloc>(
                        builder: (context) {
                          return ReportDeviceBloc(ReportDeviceRepositories())
                            ..dispatch(FetchReportDevice());
                        },
                        child: ReportDevicePage(),
                      );
                    }));
                  },
                ),
              ],
            ),
            body: CustomScrollView(
              scrollDirection: Axis.vertical,
              slivers: <Widget>[
                SliverPersistentHeader(
                  delegate: ChangeDeviceStateHeader(_controller, scroToTopCall),
                ),
                SliverFillRemaining(
                  child: Container(
                    child: TabBarView(
                      children: [
                        if (state is LoadingDeviceMessageState) ...[
                          Center(
                            child: CircularProgressIndicator(),
                          ),
                          Center(
                            child: CircularProgressIndicator(),
                          ),
                        ],
                        if (state is LoadErrorDeviceMessageState) ...[
                          Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text("网络出现错误,请稍候重试"),
                                RaisedButton(
                                  child: Text("重新加载"),
                                  onPressed: () =>
                                      _bloc.dispatch(FetchAllDevices()),
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text("网络出现错误,请稍候重试"),
                                RaisedButton(
                                  child: Text("重新加载"),
                                  onPressed: () =>
                                      _bloc.dispatch(FetchAllDevices()),
                                ),
                              ],
                            ),
                          ),
                        ],
                        if (state is LoadedDeviceMessageState) ...[
                          getDevices(
                              controller: _faultController,
                              devices: state.faultDeviceList.dataList,
                              refreshType: RefreshFaultDevices(),
                              fetchType: FetchFaultDevices()),
                          getDevices(
                              controller: _runningController,
                              devices: state.runningDeviceList.dataList,
                              refreshType: RefreshRunningDevices(),
                              fetchType: FetchRunningDevices()),
                        ],
                      ],
                      controller: _controller,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  getDevices({
    EasyRefreshController controller,
    List<DeviceMessage> devices,
    DeviceMessageEvent refreshType,
    DeviceMessageEvent fetchType,
  }) {
    if (devices.isEmpty) {
      return Center(
        child: Text("列表为空"),
      );
    } else {
      return EasyRefresh(
        footer: ClassicalFooter(
          loadText: "释放加载更多",
          loadReadyText: "释放加载更多",
          loadingText: "正在加载",
          loadedText: "加载成功",
          loadFailedText: "加载失败",
          noMoreText: "没有更多数据",
          infoText: "更新于 %T",
        ),
        bottomBouncing: false,
        enableControlFinishLoad: true,
        controller: controller,
        onRefresh: () async {
          _bloc.dispatch(refreshType);
        },
        onLoad: () async {
          _bloc.dispatch(fetchType);
        },
        child: ListView.builder(
          itemCount: devices.length,
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
                    child: ListTile(
                      title: Text(devices[index].name),
                      trailing: FlatButton(
                        child: Text("查看详情"),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  ListTile(
                    dense: true,
                    title: Text("位置"),
                    trailing:
                        Text("${devices[index].floor}${devices[index].area}"),
                  ),
                  ListTile(
                    dense: true,
                    title: Text("位置备注"),
                    trailing: Text("${devices[index].position}"),
                  ),
                  ListTile(
                    dense: true,
                    title: Text("设备状态"),
                    trailing: Text(
                      "${mapStateToString[devices[index].status]}",
                      style: TextStyle(
                        color: mapStateToColor[devices[index].status],
                      ),
                    ),
                  ),
                  ListTile(
                    dense: true,
                    title: Text("设备类别"),
                    trailing: Text("${devices[index].category}"),
                  ),
                  ListTile(
                    dense: true,
                    title: Text("设备类型"),
                    trailing:
                        Text("${devices[index].online ? "线上设备" : "线下设备"}"),
                  ),
                ],
              ),
            );
          },
        ),
      );
    }
  }

  @override
  bool get wantKeepAlive => true;
}

class ChangeDeviceStateHeader extends SliverPersistentHeaderDelegate {
  TabController _controller;
  Function scroCall;

  ChangeDeviceStateHeader(this._controller, this.scroCall);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return TabBar(
      tabs: [
        Tab(
          child: Text("故障"),
        ),
        Tab(
          child: Text("正常"),
        )
      ],
      controller: _controller,
      onTap: (index) {
        if (!_controller.indexIsChanging) {
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
