part of "device_supvisor_pages.dart";

class FaultPage extends StatelessWidget {
  final Function drawerCall;
  FaultPage(this.drawerCall);

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: 2,
        child: new Scaffold(
            appBar: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: AppBarComponent(),
              leading: IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    drawerCall();
                  }),
          bottom: new TabBar(
            tabs: <Widget>[
              new Tab(
                text: '线上设备故障',
              ),
              new Tab(
                text: '线下设备故障',
              ),
            ],
          ),
        ),
          body: TabBarView(children: <Widget>[
            OnlineDeviceFalutComponent(),
            Text('222'),
          ]),
        ));
  }
}

//part of "device_supvisor_pages.dart";
//
//class FaultPage extends StatefulWidget {
//  final Function drawerCall;
//  FaultPage(this.drawerCall);
//
//  @override
//  _FaultPageState createState() => _FaultPageState();
//}
//
//class _FaultPageState extends State<FaultPage> {
//  ScrollController _scrollViewController;
//  TabController _tabController;

//
//  @override
//  void initState() {
//    _scrollViewController = ScrollController();
//    _tabController = TabController(length: tabs.length, vsync: null);
//  }
//
//  @override
//  void dispose() {
//    _scrollViewController.dispose();
//    _tabController.dispose();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('故障列表'),
////        centerTitle: true,
//////        automaticallyImplyLeading: false,
////        title: AppBarComponent(),
////        leading: IconButton(
////            icon: Icon(Icons.menu),
////            onPressed: () {
//////              drawerCall();
////            }),
//        bottom: TabBar(
//            controller: _tabController,
//            tabs: tabs.map((e) => Tab(text: e)).toList()),
//      ),
//      body:TabBarView(
//          controller: _tabController,
//          children: tabs.map((f){
//            return Container(
//              alignment: Alignment.center,
//              child: Text(f,textScaleFactor: 5,),
//            );
//          }).toList(),
//      ) ,
//    );
//  }
//}
//
////class FaultPage extends StatelessWidget {
////
////  final Function drawerCall;
////  FaultPage(this.drawerCall);
////
////  ScrollController _scrollViewController;
////  TabController _tabController;
////
//////  @override
//////  void initState(){
//////    _scrollViewController=ScrollController();
//////    _tabController=TabController(length: 2, vsync: null)
//////  }
//////
//////  @override
//////  void dispose(){
//////    _scrollViewController.dispose();
//////    _tabController.dispose();
//////    super.dispose();
//////  }
////
////  @override
////  Widget build(BuildContext context) {
////    return Scaffold(
////      appBar: AppBar(
////        centerTitle: true,
////        automaticallyImplyLeading: false,
////        title: AppBarComponent(),
////        leading: IconButton(
////            icon: Icon(Icons.menu),
////            onPressed: () {
////              drawerCall();
////            }),
////        bottom: TabBar(tabs: Widget[
////
////        ]),
////
////      ),
////      body: RefreshIndicator(
////        //todo 刷新回调
////        onRefresh: () async {
////          await Future.delayed(Duration(seconds: 2));
////        },
////        child: CustomScrollView(
////          slivers: <Widget>[
////            SliverToBoxAdapter(
////              child: Container(
////                padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
////                child: Card(
////                  elevation: 5,
////                  child: Container(
////                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
////                    child: Row(
////                      mainAxisSize: MainAxisSize.min,
////                      children: <Widget>[
////                        Flexible(
////                          flex: 3,
////                          child: GestureDetector(
////                            //todo 跳转页面逻辑
////                            onTap: () => Scaffold.of(context)
////                                .showSnackBar(SnackBar(content: Text("test"))),
////                            child: FaultNumComponent(),
////                          ),
////                        ),
////                        Flexible(
////                          flex: 3,
////                          child: GestureDetector(
////                            child: TaskRateComponent(),
////                            //todo 跳转到任务
////                            onTap: () => Scaffold.of(context)
////                                .showSnackBar(SnackBar(content: Text("跳转任务"))),
////                          ),
////                        ),
////                      ],
////                    ),
////                  ),
////                ),
////              ),
////            ),
////            SliverPadding(
////              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
////            ),
////            FireAlarmComponent(),
////            DeviceFaultComponent(),
////            TaskInfoComponent(),
////            SliverPadding(
////              padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
////            ),
////          ],
////        ),
////      ),
////    );
////  }
////}
////
////class TabBarFaultComponent extends StatefulWidget {
////  @override
////  _TabBarFaultComponentState createState() => _TabBarFaultComponentState();
////}
////
////class _TabBarFaultComponentState extends State<TabBarFaultComponent> with SingleTickerProviderStateMixin{
////  ScrollController _scrollViewController;
////  TabController _tabController;
////
////  @override
////  void initState(){
////    super.initState();
////    _scrollViewController=ScrollController();
////    _tabController=TabController(length: 2, vsync: null)
////  }
////
////  @override
////  void dispose(){
////    _scrollViewController.dispose();
////    _tabController.dispose();
////    super.dispose();
////  }
////
////  @override
////  Widget build(BuildContext context) {
////    return TabBar(
////        isScrollable: true,
////        controller: _tabController,
////        tabs:<Widget>[
////          Tab(text: '线上设备故障',),
////          Tab(text: '线下设备故障',)
////        ]
////    );
////  }
////}
