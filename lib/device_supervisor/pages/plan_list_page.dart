///@author ggq
///@description: 显示计划的页面
///@date :2019/8/21 15:47
part of 'device_supvisor_pages.dart';

class PlanListPage extends StatefulWidget {
  @override
  _PlanListPageState createState() => _PlanListPageState();
}

class _PlanListPageState extends State<PlanListPage> with AutomaticKeepAliveClientMixin{
  EasyRefreshController _controller;
  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
  }
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      onInit: (store) {
        if(store.state.deviceSupervisorModel.planPageModel.planLists==null){
          store.dispatch(initPlanListThunkAction);
        }
      },
      builder: (context, store) {
        PlanListPageModel model =
            store.state.deviceSupervisorModel.planPageModel;
        return EasyRefresh(
          footer: ClassicalFooter(
            loadText: "释放加载更多",
            loadReadyText: "释放加载更多",
            loadingText: "正在加载",
            loadedText: "加载成功",
            loadFailedText:"加载失败",
            noMoreText: "没有更多数据",
            infoText: "更新于 %T",
          ),
          bottomBouncing:false,
          enableControlFinishLoad: true,
          controller: _controller,
          onLoad: ()async{
            await Future.delayed(Duration(seconds: 1));
            store.dispatch(planLoadMoreDataThunkAction(_controller));
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
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    ListTile(
                      dense: true,
                      title: Text("检查大厦:${thisPlan.currentBuild.buildName}"),
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
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
