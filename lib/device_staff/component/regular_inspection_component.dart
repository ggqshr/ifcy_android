part of "device_staff_components.dart";

class RegularInspectionComponent extends StatefulWidget {
  @override
  _RegularInspectionComponentState createState() =>
      _RegularInspectionComponentState();
}

class _RegularInspectionComponentState extends State<RegularInspectionComponent>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _controller;
  ScrollController _scrollController;
  EasyRefreshController _completeController;
  EasyRefreshController _unCompleteController;
  DeviceStaffTaskListBloc _bloc;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    _scrollController = ScrollController(initialScrollOffset: 0);
    _completeController = EasyRefreshController();
    _unCompleteController = EasyRefreshController();
    _bloc = BlocProvider.of<DeviceStaffTaskListBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _scrollController.dispose();
    _completeController.dispose();
    _unCompleteController.dispose();
  }

  scroToTopCall() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(0,
          duration: Duration(seconds: 1), curve: Curves.ease);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeviceStaffTaskListBloc, DeviceStaffTaskListState>(
      listener: (context, state) {
        _unCompleteController.resetLoadState();
        _completeController.resetLoadState();
        if (state is LoadedDeviceStaffTaskListState) {
          if (state.unCompleteIsReachMax) {
            _unCompleteController.finishLoad(success: true, noMore: true);
          }
          if (state.completeIsReachMax) {
            _completeController.finishLoad(success: true, noMore: true);
          }
          if (!state.completeIsReachMax) {
            _completeController.finishLoad(success: true);
          }
          if (!state.unCompleteIsReachMax) {
            _unCompleteController.finishLoad(success: true);
          }
        }
        if (state is LoadErrorDeviceStaffTaskList) {
          _unCompleteController.finishLoad(success: false);
          _completeController.finishLoad(success: false);
        }
      },
      child: BlocBuilder<DeviceStaffTaskListBloc, DeviceStaffTaskListState>(
        builder: (context, state) {
          return CustomScrollView(
            scrollDirection: Axis.vertical,
            slivers: <Widget>[
              SliverPersistentHeader(
                delegate: ChangeTaskState(_controller, scroToTopCall),
              ),
              SliverFillRemaining(
                child: Container(
                  child: TabBarView(
                    children: [
                      if (state is UnInitialDeviceStaffTaskListState) ...[
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                      ],
                      if (state is LoadErrorDeviceStaffTaskList) ...[
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text("网络出现错误,请稍候重试"),
                              RaisedButton(
                                child: Text("重新加载"),
                                onPressed: () => _bloc.dispatch(FetchAll()),
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
                                onPressed: () => _bloc.dispatch(FetchAll()),
                              ),
                            ],
                          ),
                        ),
                      ],
                      if (state is LoadedDeviceStaffTaskListState) ...[
                        getTasks(
                            controller: _unCompleteController,
                            tasks: state.unCompleteTask.taskInfoList,
                            actionButton: getUnCompleteActionButton,
                            refreshType: RefreshUnComplete(),
                            fetchType: FetchUnComplete()),
                        getTasks(
                            controller: _completeController,
                            tasks: state.completeTask.taskInfoList,
                            actionButton: getCompleteActionButton,
                            refreshType: RefreshComplete(),
                            fetchType: FetchComplete()),
                      ],
                    ],
                    controller: _controller,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  getTasks({
    EasyRefreshController controller,
    List<InspectionTaskModel> tasks,
    Function actionButton,
    DeviceStaffTaskListEvent refreshType,
    DeviceStaffTaskListEvent fetchType,
  }) {
    if (tasks.isEmpty) {
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
          itemCount: tasks.length,
          key: PageStorageKey("RegularInspectionComponentgetUnFinishTask"),
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
                    child: actionButton(tasks, index),
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  ListTile(
                    dense: true,
                    title: Text("备注:${tasks[index].noteText}"),
                  ),
                  ListTile(
                    dense: true,
                    title: Text(
                        "开始时间：${tasks[index].startTime.toString().substring(0, 10)}"),
                  ),
                  ListTile(
                    dense: true,
                    title: Text(
                        "开始时间：${tasks[index].endTime.toString().substring(0, 10)}"),
                  ),
                  ListTile(
                    dense: true,
                    title: Text(
                        "巡检情况：总设备数    ${tasks[index].deviceNum},已巡检    ${tasks[index].checkedDeviceNum}"),
                  ),
                  ListTile(
                    dense: true,
                    title: Text("进度"),
                    subtitle: SizedBox(
                      height: 10,
                      child: LinearProgressIndicator(
                        value: int.parse(tasks[index].deviceNum) == 0
                            ? 0
                            : double.parse(tasks[index].checkedDeviceNum) /
                                double.parse(tasks[index].deviceNum),
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
  }

  Widget getUnCompleteActionButton(List<InspectionTaskModel> tasks, int index) {
    return ListTile(
      title: Text(tasks[index].name),
      trailing: FlatButton.icon(
        onPressed: tasks[index].taskStatus == TaskStatus.running
            ? () => Application.router.navigateTo(
                context, Routes.regularInspection,
                transition: TransitionType.inFromBottom)
            : null,
        icon: Icon(Icons.play_arrow),
        label: Text("执行"),
      ),
    );
  }

  Widget getCompleteActionButton(List<InspectionTaskModel> tasks, int index) {
    return ListTile(
      title: Text(tasks[index].name),
      trailing: FlatButton.icon(
        onPressed: () => Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text("跳转到${tasks[index].id}"),
          ),
        ),
        icon: Icon(
          Icons.check_circle_outline,
          color: Colors.green,
        ),
        label: Text(taskStatusToString[tasks[index].taskStatus]),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class ChangeTaskState extends SliverPersistentHeaderDelegate {
  TabController _controller;
  Function scroCall;

  ChangeTaskState(this._controller, this.scroCall);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return TabBar(
      tabs: [
        Tab(
          child: Text("未完成"),
        ),
        Tab(
          child: Text("完成"),
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
