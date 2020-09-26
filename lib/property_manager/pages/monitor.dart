part of "property_manager_pages.dart";

class MonitorPage extends StatelessWidget {
  final Function drawerCall;
  final ScrollController controller;

  MonitorPage(this.drawerCall, this.controller);

  @override
  Widget build(BuildContext context) {
    MonitorBloc bloc = BlocProvider.of<MonitorBloc>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: GestureDetector(
          child: Text((BlocProvider.of<AuthorizationBloc>(context).state
                  as Authenticated)
              .currentBuild
              .buildName),
          onTap: () => controller.animateTo(0.0,
              duration: Duration(milliseconds: 500), curve: Curves.decelerate),
        ),
        leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              drawerCall();
            }),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Auth.getInstance().reset();
                DioUtils.getInstance().resetDio();
              })
        ],
      ),
      body: BlocBuilder<MonitorBloc, MonitorState>(
          // ignore: missing_return
          builder: (context, state) {
        if (state is LoadedErrorMonitorState) {
          return Center(
            child: Text("网络出现错误"),
          );
        }
        if (state is UnInitializationMonitorState) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircularProgressIndicator(),
                Text("加载中"),
              ],
            ),
          );
        }
        if (state is LoadedMonitorState) {
          return RefreshIndicator(
            //todo 刷新回调
            onRefresh: () async {
              bloc.add(FetchMonitorDataEvent());
            },
            child: CustomScrollView(
              controller: controller,
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                    child: Card(
                      elevation: 5,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Flexible(
                              flex: 3,
                              child: GestureDetector(
                                //todo 跳转页面逻辑
                                onTap: () => Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text("test"))),
                                child: FaultNumComponent(
                                    state.deviceFaultNum.toString()),
                              ),
                            ),
                            Flexible(
                              flex: 3,
                              child: GestureDetector(
                                child:
                                    TaskRateComponent(state.taskCompleteRate),
                                //todo 跳转到任务
                                onTap: () => Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text("跳转任务"))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                ),
                TrueFireComponent(state.trueFireNum),
                FireAlarmComponent(state.fireAlarmMsg),
                DeviceFaultComponent(state.deviceFaultMsg),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
