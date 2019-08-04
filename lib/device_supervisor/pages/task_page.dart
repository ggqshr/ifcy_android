part of "device_supvisor_pages.dart";

class TaskPage extends StatefulWidget {
  final Function drawerCall;

  TaskPage(this.drawerCall);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> with TickerProviderStateMixin {
  TabController _tabController;
  List _tabbarItems = new List();
  int curIndex = 0; //选中下标

  @override
  Widget build(BuildContext context) {
    return StoreBuilder(builder: (context, Store<AppState> store) {
      _tabbarItems = store.state.deviceSupervisorModel.taskCycleMessages;
      _tabController =
          new TabController(length: _tabbarItems.length, vsync: this)
            ..addListener(() => getRow(_tabController.index));

      return Scaffold(
        appBar: AppBar(
          title: Text('任务安排列表'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
//               this.drawerCall();
              }),
          //动态渲染tabbar
          bottom: TabBar(
            isScrollable: true,
            controller: _tabController,
            indicatorColor: Colors.red,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.red,
            unselectedLabelColor: Colors.black,
            indicatorWeight: 5.0,
            labelStyle: TextStyle(height: 2),
            tabs: _tabbarItems.map((item) {
              return Center(
                child: new Text(item.item),
              );
            }).toList(),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: _tabbarItems.map((item) {
            return Container(
              child: getRow(_tabController.index),
            );
          }).toList(),
        ),
      );
    });
  }

  Widget getRow(int index) {
    return StoreConnector<AppState, TaskListViewModel>(
        converter: (Store<AppState> store) {
      return TaskListViewModel(
        taskExecuteModel: store.state.deviceSupervisorModel.taskExecuteModel[index],
        taskDetailList: store.state.deviceSupervisorModel
            .taskMessageViewList[index].taskDetailList,
      );
    }, builder: (BuildContext context, TaskListViewModel vm) {
      List<Widget> viewList = <Widget>[];
      if (vm.taskExecuteModel.taskNum == 0) {
        viewList.add(Text('当前无任务'));
      } else {
          viewList = vm.taskDetailList.map<Widget>((TaskDetailModel meg) {
          return TaskTile(meg);
        }).toList();
      }
      return ListView(
        children: <Widget>[...viewList],
      );
    });
  }
}

class TaskTile extends StatelessWidget {
  final TaskDetailModel meg;

  TaskTile(this.meg);

  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      height: 500,
      child: new Card(
        elevation: 5.0,
        child: new Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('任务描述'),
                Text(meg.des),
              ],
            ),
            Row(
              children: <Widget>[
                Text('任务类型'),
                Text(meg.type),
              ],
            ),
            Row(
              children: <Widget>[
                Text('任务执行者'),
                Text(meg.executor),
              ],
            ),
            Row(
              children: <Widget>[
                Text('任务进度'),
                Text(meg.progress.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
