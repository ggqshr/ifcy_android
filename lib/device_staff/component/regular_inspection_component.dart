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

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    _scrollController = ScrollController(initialScrollOffset: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
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
          delegate: ChangeTaskState(_controller, scroToTopCall),
        ),
        SliverFillRemaining(
          child: Container(
            child: TabBarView(
              children: [
                getUnFinishTask(),
                getFinishTask(),
              ],
              controller: _controller,
            ),
          ),
        ),
      ],
    );
  }

  getFinishTask(){
    return StoreConnector<AppState, RegularInspectionViewModel>(
      converter: (Store<AppState> store) {
        DeviceStaffModel model = store.state.deviceStaffModel;
        return RegularInspectionViewModel(
          completeTasks: model.regularTasks
              .where((item) => item.taskStatus == TaskStatus.completed).toList(),
          onRefreshCall: () async {
            //todo 刷新回调
            await Future.delayed(Duration(seconds: 2));
          },
        );
      },
      builder: (BuildContext context, RegularInspectionViewModel vm) {
        return RefreshIndicator(
          child: ListView.builder(
            key: PageStorageKey("RegularInspectionComponentgetFinishTask"),
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
                        title: Text(vm.completeTasks[index].taskTitle),
                        trailing: FlatButton.icon(
                          onPressed: () => Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text("跳转到${vm.completeTasks[index].id}"),
                                ),
                              ),
                          icon: Icon(
                            Icons.check_circle_outline,
                            color: Colors.green,
                          ),
                          label: Text("已完成"),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    ListTile(
                      dense: true,
                      title:
                          Text("任务内容:${vm.completeTasks[index].taskContent}"),
                    ),
                    ListTile(
                      dense: true,
                      title: Text("委派人员：${vm.completeTasks[index].taskPeople}"),
                    ),
                    ListTile(
                      dense: true,
                      title: Text("起始时间：${vm.completeTasks[index].taskTime}"),
                    ),
                  ],
                ),
              );
            },
          ),
          onRefresh: () async {
            await vm.onRefreshCall();
          },
        );
      },
    );
  }

  getUnFinishTask() {
    return StoreConnector<AppState, RegularInspectionViewModel>(
      converter: (Store<AppState> store) {
        DeviceStaffModel model = store.state.deviceStaffModel;
        return RegularInspectionViewModel(
          unCompleteTasks: model.regularTasks
              .where((item) => item.taskStatus == TaskStatus.uncompleted).toList(),
          onRefreshCall: () async {
            //todo 刷新回调
            await Future.delayed(Duration(seconds: 2));
          },
        );
      },
      builder: (BuildContext context, RegularInspectionViewModel vm) {
        return RefreshIndicator(
          child: ListView.builder(
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
                      child: ListTile(
                        title: Text(vm.unCompleteTasks[index].taskTitle),
                        trailing: FlatButton.icon(
                          onPressed: () => Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content:
                              Text("跳转到${vm.unCompleteTasks[index].id}"),
                            ),
                          ),
                          icon: Icon(Icons.play_arrow),
                          label: Text("执行"),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    ListTile(
                      dense: true,
                      title:
                      Text("任务内容:${vm.unCompleteTasks[index].taskContent}"),
                    ),
                    ListTile(
                      dense: true,
                      title: Text("委派人员：${vm.unCompleteTasks[index].taskPeople}"),
                    ),
                    ListTile(
                      dense: true,
                      title: Text("起始时间：${vm.unCompleteTasks[index].taskTime}"),
                    ),
                  ],
                ),
              );
            },
          ),
          onRefresh: () async {
            await vm.onRefreshCall();
          },
        );
      },
    );
  }

//  getUnFinishTask() {
//    return RefreshIndicator(
//      child: ListView.builder(
//        key: PageStorageKey("RegularInspectionComponentgetUnFinishTask"),
//        controller: _scrollController,
//        itemBuilder: (context, index) {
//          return Card(
//            elevation: 5,
//            margin: EdgeInsets.fromLTRB(15, 6, 15, 6),
//            shape:
//                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//            child: Column(
//              mainAxisSize: MainAxisSize.min,
//              children: <Widget>[
//                Flexible(
//                  flex: 2,
//                  child: ListTile(
//                    title: Text("ss"),
//                    trailing: FlatButton.icon(
//                      onPressed: () => {},
//                      icon: Icon(Icons.play_arrow),
//                      label: Text("执行"),
//                    ),
//                  ),
//                ),
//                Divider(
//                  color: Colors.black,
//                ),
//                ListTile(
//                  dense: true,
//                  title: Text("任务内容:巡检"),
//                ),
//                ListTile(
//                  dense: true,
//                  title: Text("委派人员：me"),
//                ),
//                ListTile(
//                  dense: true,
//                  title: Text("起始时间：2019年7月30日"),
//                ),
//              ],
//            ),
//          );
//        },
//      ),
//      onRefresh: () async {
//        //todo 未完成下拉刷新回调
//        await Future.delayed(Duration(seconds: 2));
//      },
//    );
//  }

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
          child: Text("完成"),
        ),
        Tab(
          child: Text("未完成"),
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
