///@author ggq
///@description: 工作页面
///@date :2019/8/21 15:40
part of 'device_supvisor_pages.dart';

class WorkPage extends StatefulWidget {
  @override
  _WorkPageState createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _controller;
  List<Widget> tabViews = [];
  List<Tab> tabs = [
    Tab(
      child: Text("计划"),
    ),
    Tab(
      child: Text("任务"),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: tabs.length, vsync: this);
    tabViews..add(PlanListPage())..add(TaskPage());
  }

  @override
  Widget build(BuildContext context) {
    AppState state = StoreProvider.of<AppState>(context).state;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => AddTaskPage()),
          );
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text("工作"),
        bottom: TabBar(
          tabs: tabs,
          controller: _controller,
          labelStyle: TextStyle(fontWeight: FontWeight.w900),
          indicatorWeight: 5,
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w100),
          isScrollable: false,
        ),
      ),
      body: BlocProvider<PlanListBloc>(
        builder: (context) {
          PlanListRepositories repositories = PlanListRepositories(
              state.deviceSupervisorModel.buildingList,
              state.selectProjectModel.selectedProject.projectId);
          return PlanListBloc(repositories);
        },
        child: TabBarView(
          children: tabViews,
          controller: _controller,
          physics: NeverScrollableScrollPhysics(),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
