part of "device_supvisor_pages.dart";

class FaultDeclareFeedback extends StatefulWidget {
  Function drawerCall;
  FaultDeclareFeedback(this.drawerCall);

  @override
  _FaultDeclareFeedbackState createState() => _FaultDeclareFeedbackState();
}

class _FaultDeclareFeedbackState extends State<FaultDeclareFeedback>  with SingleTickerProviderStateMixin {

  TabController _tabController;
  List<Widget> tabViews=[];
  List<Tab> tabs=[
    Tab(child: Text('已处理故障申报'),),
    Tab(child: Text('处理中故障申报'),),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:false,
        title:Text('设备故障申报'),
        centerTitle: true,
        bottom: TabBar(
          tabs: tabs,
          controller: _tabController,
          //labelColor: Colors.lightGreenAccent,   // 选中的Widget颜色
          indicatorColor:Colors.green, // 选中的指示器颜色
          labelStyle: TextStyle(fontWeight: FontWeight.w900),
          indicatorSize: TabBarIndicatorSize.label,
          indicatorWeight: 3,
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w100),
          isScrollable: false,
        ),
      ),
      body: TabBarView(
        children:tabViews,
        controller: _tabController,
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }
}

