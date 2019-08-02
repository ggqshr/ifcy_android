part of 'device_supervisor_component.dart';

class TaskListComponent extends StatefulWidget {
  @override
  _TaskListComponentState createState() => _TaskListComponentState();
}

class _TaskListComponentState extends State<TaskListComponent>
    with SingleTickerProviderStateMixin {
  TabController controller; //tab控制器

  int _currentIndex = 0; //选中下标

  List<String> _taskTabItems = new List();
  List<TaskListModel> _taskListData = new List();

  @override
  void initState() {
    super.initState();
    _taskTabItems = ['周', '月', '季度', '年'];

    _taskListData = [
      TaskListModel(choice: '周', taskDetailList: [
        TaskDetailModel(
            des: '任务描述1', type: '日常任务', executor: '李超', progress: 60),
        TaskDetailModel(
            des: '任务描述2', type: '日常任务', executor: '李超', progress: 60),
        TaskDetailModel(
            des: '任务描述3', type: '日常任务', executor: '李超', progress: 60),
        TaskDetailModel(
            des: '任务描述4', type: '日常任务', executor: '李超', progress: 60),
      ]),
      TaskListModel(choice: '月', taskDetailList: [
        TaskDetailModel(
            des: '任务描述1', type: '月度任务', executor: '李超', progress: 60),
        TaskDetailModel(
            des: '任务描述2', type: '月度任务', executor: '李超', progress: 60),
        TaskDetailModel(
            des: '任务描述3', type: '月度任务', executor: '李超', progress: 60),
        TaskDetailModel(
            des: '任务描述4', type: '月度任务', executor: '李超', progress: 60),
      ]),
      TaskListModel(choice: '季度', taskDetailList: [
        TaskDetailModel(
            des: '任务描述1', type: '季度任务', executor: '李超', progress: 60),
        TaskDetailModel(
            des: '任务描述2', type: '季度任务', executor: '李超', progress: 60),
        TaskDetailModel(
            des: '任务描述3', type: '季度任务', executor: '李超', progress: 60),
        TaskDetailModel(
            des: '任务描述4', type: '季度任务', executor: '李超', progress: 60),
      ]),
      TaskListModel(choice: '年', taskDetailList: [
        TaskDetailModel(
            des: '任务描述1', type: '年度任务', executor: '李超', progress: 60),
        TaskDetailModel(
            des: '任务描述2', type: '年度任务', executor: '李超', progress: 60),
        TaskDetailModel(
            des: '任务描述3', type: '年度任务', executor: '李超', progress: 60),
        TaskDetailModel(
            des: '任务描述4', type: '年度任务', executor: '李超', progress: 60),
      ]),
    ];
    controller = new TabController(length: _taskTabItems.length, vsync: this);
  }

  _onTabChanged() {
    if (controller.indexIsChanging) {
      if (this.mounted) {
        //赋值并更新数据
        this.setState(() {
          _currentIndex = controller.index;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: _taskTabItems.length,
      child: new Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,

          title: Text("任务安排列表"),
//          textTheme:TextTheme(
//
//          ),
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
//                drawerCall();
              }),
          bottom: new TabBar(
            controller: controller,
            //控制器
            labelColor: Colors.yellow,
            //选中的颜色
            labelStyle: TextStyle(fontSize: 16),
            //选中的样式
            unselectedLabelColor: Colors.white,
            //未选中的颜色
            unselectedLabelStyle: TextStyle(fontSize: 14),
            //未选中的样式
            indicatorColor: Colors.yellow,
            //下划线颜色
            isScrollable: true,
            //是否可滑动
            //tab标签
            tabs: _taskTabItems.map((f) {
              return new Tab(
                text: f,
              );
            }).toList(),
            //点击事件
            onTap: (int i) {
              print(i);
            },
          ),
        ),
        body: new TabBarView(
          controller: controller,
          children: _taskTabItems.map((f) {
            return new ListView.builder(
                itemCount: _taskTabItems.length,
                itemBuilder: (BuildContext context, int position) {
                  return getRow(position);
                });
          }).toList(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromRGBO(102, 231, 142, 1.0),
          child: Icon(Icons.add),
          onPressed: () {
            print('FloatingActionButton');
            Navigator.push(context, new MaterialPageRoute(
              builder: (context) {
                return new TaskAddComponent();
              },
//                    fullscreenDialog: true
            ));
          },
        ),
      ),
    );
  }

  Widget getRow(int i) {
    return new GestureDetector(
      child: new Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.all(10),
        child: new Card(
          elevation: 3,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  flex: 5,
                  child: new Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
//                      new GridView(
//                          scrollDirection: Axis.horizontal,
//                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//                            maxCrossAxisExtent: MediaQuery.of(context).size.height/5,
//                            mainAxisSpacing: 10,
//                            crossAxisSpacing: 10,
//                          ),
//                        children: <Widget>[
//                          Text('任务描述:'),
//                          Text(_taskListData[i].taskDetailList[i].des,
//                          style: TextStyle(
//                              fontSize: 14, fontWeight: FontWeight.bold),
//                          maxLines: 3,
//                          overflow: TextOverflow.ellipsis,
//                          ),
//                        ]
//                  ),
                      new Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: new Text(
                          _taskListData[i].taskDetailList[i].des,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      new Padding(
                        padding: EdgeInsets.all(10),
                        child: new Text(
                          _taskListData[i].taskDetailList[i].type,
                          style: TextStyle(fontSize: 14),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      new Container(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          children: <Widget>[
                            new Expanded(
                              flex: 1,
                              child: new Padding(
                                padding: EdgeInsets.all(10),
                                child: new Text(
                                    _taskListData[i].taskDetailList[i].executor,
                                    style: TextStyle(fontSize: 14)),
                              ),
                            ),

//                          new Padding(
//                            padding: EdgeInsets.all(10),
//                            child: new Text(
//                              _taskListData[i].taskDetailList[i].progress.toString(),
//                              style: TextStyle(fontSize: 14),
//                              textAlign: TextAlign.right,
//                            ),
//                          )
                          ],
                        ),
                      ),
                      new Padding(
                        padding: EdgeInsets.all(10),
                        child: new Text(
                          _taskListData[i]
                              .taskDetailList[i]
                              .progress
                              .toString(),
                          style: TextStyle(fontSize: 14),
//                          maxLines: 3,
//                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
//      onTap: () {
//        //点击item跳转到详情
//        Navigator.push(
//          context,
//          new MaterialPageRoute(
//              builder: (context) => new ArticleDetail(
//                  title: _taskListData[i].title, url: _listDatas[i].link)),
//        );
//      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
