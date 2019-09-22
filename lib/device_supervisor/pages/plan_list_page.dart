///@author ggq
///@description: 显示计划的页面
///@date :2019/8/21 15:47
part of 'device_supvisor_pages.dart';

class PlanListPage extends StatefulWidget {
  @override
  _PlanListPageState createState() => _PlanListPageState();
}

class _PlanListPageState extends State<PlanListPage>
    with AutomaticKeepAliveClientMixin {
  EasyRefreshController _controller;
  PlanListBloc bloc;

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    bloc = BlocProvider.of<PlanListBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlanListBloc, PlanListState>(
      listener: (context, state) {
        _controller.resetLoadState();
        if (state is FetchedPlanListState) {
          if (state.isReachMax) {
            _controller.finishLoad(success: true, noMore: true);
          } else {
            _controller.finishLoad(success: true);
          }
        }
      },
      child: BlocBuilder<PlanListBloc, PlanListState>(
        builder: (context, state) {
          if (state is FetchErrorPlanListState) {
            return Center(
              child: Text("网络出现错误"),
            );
          } else if (state is InitialPlanListState) {
            bloc.dispatch(FetchPlan());
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FetchedPlanListState) {
            PlanTaskListPageModel model = state.model;
            return EasyRefresh(
              footer: getFooter(),
              header: getHeader(),
              bottomBouncing: false,
              enableControlFinishLoad: true,
              controller: _controller,
              onRefresh: () async {
                bloc.dispatch(RefreshPlan());
              },
              onLoad: () async {
                bloc.dispatch(FetchPlan());
              },
              child: ListView.builder(
                itemCount: model.planLists.length,
                itemBuilder: (context, index) {
                  var thisPlan = model.planLists[index];
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
                            title: Text(thisPlan.name),
                            trailing: FlatButton(
                              color: Colors.green[300],
                              child: Text("修改"),
                              onPressed: () {
                                UserLoginRepositories userRepo =
                                    RepositoryProvider.of<
                                        UserLoginRepositories>(context);
                                PlanListRepositories planListRepo =
                                    RepositoryProvider.of<PlanListRepositories>(
                                        context);
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return MultiRepositoryProvider(
                                    providers: [
                                      RepositoryProvider<
                                          UserLoginRepositories>.value(
                                        value: userRepo,
                                      ),
                                      RepositoryProvider<
                                              PlanListRepositories>.value(
                                          value: planListRepo),
                                      RepositoryProvider<
                                          AddTaskPlanRepositories>(
                                        builder: (context) =>
                                            AddTaskPlanRepositories(),
                                      ),
                                    ],
                                    child: BlocProvider<ChangePlanBloc>(
                                      builder: (context) => ChangePlanBloc(
                                        repositories: RepositoryProvider.of<
                                            PlanListRepositories>(context),
                                        userLoginRepositories:
                                            RepositoryProvider.of<
                                                UserLoginRepositories>(context),
                                        addTaskPlanRepositories:
                                            RepositoryProvider.of<
                                                    AddTaskPlanRepositories>(
                                                context),
                                        model: thisPlan,
                                      )..dispatch(InitPageEvent()),
                                      child: ChangePlanPage(thisPlan),
                                    ),
                                  );
                                }));
                              },
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        ListTile(
                          dense: true,
                          title: Text(
                              "检查大厦:${(BlocProvider.of<AuthorizationBloc>(context).currentState as Authenticated).currentBuild.buildName}"),
                        ),
                        ListTile(
                          dense: true,
                          title: Text(
                              "第一次开始时间：${thisPlan.firstStartTime.toString().substring(0, 10)}"),
                        ),
                        ListTile(
                          dense: true,
                          title: Text("持续时间：${thisPlan.taskExecuteTime}天"),
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
