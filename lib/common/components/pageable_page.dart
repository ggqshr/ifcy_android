///@author ggq
///@description:
///@date :2019/9/2 19:39
part of "components.dart";

class PageablePage<BlocType extends Bloc<dynamic, BlocState>, BlocState,FetchedState>
    extends StatefulWidget {
  dynamic fetchEvent;
  dynamic refreshEvent;

  @override
  _PageablePageState createState() => _PageablePageState<BlocType, BlocState>();
}

class _PageablePageState<BlocType extends Bloc<dynamic, BlocState>, BlocState>
    extends State<PageablePage> {
  EasyRefreshController _controller;
  BlocType bloc;

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    bloc = BlocProvider.of<BlocType>(context);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BlocType, BlocState>(
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
            return Center(
              child: Text("网络出现错误"),
            );
          } else if (state is InitialTaskListState) {
            bloc.dispatch(FetchTask());
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FetchedTaskListState) {
            PlanTaskListPageModel model = state.model;
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
              controller: _controller,
              onRefresh: () async {
                bloc.dispatch(RefreshTask());
              },
              onLoad: () async {
                bloc.dispatch(FetchTask());
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
                              "检查大厦:${(BlocProvider.of<AuthorizationBloc>(context).currentState as Authenticated).currentBuild.buildName}"),
                        ),
                        ListTile(
                          dense: true,
                          title: Text(
                              "开始时间：${thisTask.startTime.toString().substring(0, 10)}"),
                        ),
                        ListTile(
                          dense: true,
                          title: Text("结束时间：${thisTask.endTime}天"),
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
}
