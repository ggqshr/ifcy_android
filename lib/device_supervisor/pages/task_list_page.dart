///@author ggq
///@description: 显示计划的页面
///@date :2019/8/21 15:47
part of 'device_supvisor_pages.dart';

class TaskListPage extends StatefulWidget {
  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage>
    with AutomaticKeepAliveClientMixin {
  EasyRefreshController _controller;
  TaskListBloc bloc;

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    bloc = BlocProvider.of<TaskListBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskListBloc, TaskListState>(
      listener: (context, state) {
        _controller.resetLoadState();
        if (state is FetchedTaskListState) {
          if (state.isReachMax) {
            _controller.finishLoad(success: true, noMore: true);
          } else {
            _controller.finishLoad(success: true);
          }
        }
      },
      child: BlocBuilder<TaskListBloc, TaskListState>(
        builder: (context, state) {
          if (state is FetchErrorTaskListState) {
            return LoadErrorPage(() => bloc.add(RefreshTask()));
          } else if (state is InitialTaskListState) {
            bloc.add(FetchTask());
            return LoadingPage();
          } else if (state is FetchedTaskListState) {
            PlanTaskListPageModel model = state.model;
            return model.planLists.isEmpty
                ? BlankPage(
                    showText: "无已发布的任务",
                    onRefreshCall: () => bloc.add(RefreshTask()),
                  )
                : EasyRefresh(
                    footer: getFooter(),
                    header: getHeader(),
                    bottomBouncing: false,
                    enableControlFinishLoad: true,
                    controller: _controller,
                    onRefresh: () async {
                      bloc.add(RefreshTask());
                    },
                    onLoad: () async {
                      bloc.add(FetchTask());
                    },
                    child: ListView.builder(
                      itemCount: model.planLists.length,
                      itemBuilder: (context, index) {
                        var thisTask = model.planLists[index];
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
                                  title: Text(thisTask.name),
                                ),
                              ),
                              Divider(
                                color: Colors.black,
                              ),
                              ListTile(
                                dense: true,
                                title: Text(
                                    "检查大厦:${(BlocProvider.of<AuthorizationBloc>(context).state as Authenticated).currentBuild.buildName}"),
                              ),
                              ListTile(
                                dense: true,
                                title: Text(
                                    "开始时间：${thisTask.startTime.toString().substring(0, 10)}"),
                              ),
                              ListTile(
                                dense: true,
                                title: Text(
                                    "结束时间：${thisTask.endTime.toString().substring(0, 10)}"),
                              ),
                              ListTile(
                                dense: true,
                                title: Text("备注信息：${thisTask.noteText ?? "空"}"),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
          }
          return Container();
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
