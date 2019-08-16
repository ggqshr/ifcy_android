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
  List<TaskDetailModel> taskDetailList = new List();
  int curIndex = 0; //选中下标
  var curCycle = "周检"; //选中的周期

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TaskListViewModel>(
      distinct: true,
      converter: (Store<AppState> store) {
        DeviceSupervisorModel model = store.state.deviceSupervisorModel;
        return TaskListViewModel(
            taskCycleList: model.taskCycleMessages,
            taskExecuteList: model.taskExecuteList,
            taskDetailList: model.taskDetailList,
            //taskDetailList: model.taskDetailList.where((i) => i.cycle ==curCycle).toList(),
            onRefreshCall: () async {
              await Future.delayed(Duration(seconds: 2));
            });
      },
      builder: (BuildContext context, TaskListViewModel vm) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              '任务安排列表',
              style: TextStyle(fontSize: 16),
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
            leading: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  widget.drawerCall();
                }),
            //动态渲染tabbar
            bottom: TabBar(
              isScrollable: true,
              controller: _tabController,
              indicatorColor: Colors.lightGreenAccent,
              indicatorSize: TabBarIndicatorSize.tab,
              unselectedLabelColor: Colors.black,
              indicatorWeight: 3.0,
              labelColor: Colors.lightGreenAccent,
              labelStyle: TextStyle(height: 2),
              tabs: _tabbarItems.map((item) {
                return Center(
                  child: new Text(item.item),
                );
              }).toList(),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Colors.green,
            onPressed: () {
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => TaskAddComponent()),
              );
            },
          ),
          body: TabBarView(
            controller: _tabController,
            children: _tabbarItems.map((item) {
              return Container(
                child: getRow(vm),
              );
            }).toList(),
          ),
        );
      },
      onInit: (Store<AppState> store) {
        _tabbarItems = store.state.deviceSupervisorModel.taskCycleMessages;
        _tabController = new TabController(length: _tabbarItems.length, vsync: this)
              ..addListener(() {
                if (_tabController.index.toDouble() == _tabController.animation.value) {
                  setState(() {
                    curIndex = _tabController.index;
                  });
                }
              });
      },
      onDispose: (Store<AppState> store) {
        _tabController.dispose();
      },
    );
  }

  Widget getRow(TaskListViewModel vm) {
    List<Widget> viewList = <Widget>[];
    var taskDetailListFilter=vm.taskDetailList.where((i) => i.cycle ==_tabbarItems[curIndex].item).toList();
    if (vm.taskExecuteList[curIndex].taskNum == 0) {
      viewList.add(Text('当前无任务'));
    } else {
       viewList = taskDetailListFilter.map<Widget>((TaskDetailModel meg) {
        return TaskTile(meg);
      }).toList();
    }
    return ListView(
      children: <Widget>[
        TaskExcuteChartComponent(vm.taskExecuteList[curIndex],vm.taskDetailList.where((i) => i.cycle ==_tabbarItems[curIndex].item).toList()),
        ...viewList
      ],
    );
  }
}

//任务详情列表
class TaskTile extends StatelessWidget {
  final TaskDetailModel meg;

  TaskTile(this.meg);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        new Card(
          elevation: 5.0,
          child: Container(
//        padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.all(5.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('任务描述:'),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Text(meg.des),
                          )
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.alarm, color: Colors.green),
                      onPressed: null,
                    ),
                    Text(
                      '催办',
                      style: TextStyle(color: Colors.green),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Text('任务类型:                            '),
                    Text(meg.type),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: <Widget>[
                    Text("任务执行进度:"),
//                    Text(meg.type),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: LinearProgressIndicator(
                    semanticsLabel: '任务执行:',
                    backgroundColor: Colors.green,
                    //value:.2,
                    value: meg.progress, //精确模式，进度20%
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        Colors.lightGreenAccent),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: <Widget>[
                    Text('任务执行者:                         '),
                    Text(meg.executor),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: <Widget>[
                    Text('任务周期:                            ${meg.cycle}'),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
