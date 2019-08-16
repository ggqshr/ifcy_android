part of "device_supvisor_pages.dart";

class FaultPage extends StatefulWidget {
  Function drawerCall;
  FaultPage(this.drawerCall);

  @override
  _FaultPageState createState() => _FaultPageState();
}

class _FaultPageState extends State<FaultPage> with SingleTickerProviderStateMixin{

  TabController _tabController;
  List<Widget> tabViews=[];
  List<Tab> tabs=[
    Tab(child: Text('线上设备故障'),),
    Tab(child: Text('线下设备故障'),),
  ];

  @override
  void initState(){
    super.initState();
    _tabController=TabController(length: tabs.length, vsync: this);
    tabViews
    ..add(OnlineDeviceFaultComponent())
    ..add(OfflineDeviceFaultComponent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         automaticallyImplyLeading: false,
         title:AppBarComponent(),
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
