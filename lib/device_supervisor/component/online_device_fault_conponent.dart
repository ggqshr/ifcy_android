part of "device_supervisor_component.dart";

class OnlineDeviceFalutComponent extends StatefulWidget {
  @override
  _OnlineDeviceFalutComponentState createState() =>
      _OnlineDeviceFalutComponentState();
}

class _OnlineDeviceFalutComponentState extends State<OnlineDeviceFalutComponent>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar:PreferredSize(
          child: AppBar(
            centerTitle: false,
            backgroundColor: Colors.white,
            leading: Text(''),
            bottom: new TabBar(
              tabs: <Widget>[
                new Tab(
                  text: '待确定',
                ),
                new Tab(
                  text: '已确定',
                ),
              ],
              controller: _tabController,
            ),
          ),
          preferredSize: Size.fromHeight(screenSize.height * 0.07)),

      body: new TabBarView(
        controller: _tabController,
        children: <Widget>[
          new Center(child: new Text('自行车')),
          new Center(child: new Text('船')),
        ],
      ),
    );

//    return Container(
//      child: Column(
//        children: <Widget>[
//          Row(
//            children: <Widget>[
//              TabBar(
//                tabs: <Widget>[
//                  new Tab(text: '待确定',),
//                  new Tab(text: '已确定',),
//                ],
//                controller: _tabController,
//              ),
//              TabBarView(
//                  controller: _tabController,
//                children: <Widget>[
//                  new Center(child: new Text('自行车')),
//                  new Center(child: new Text('船')),
//                  new Center(child: new Text('巴士')),
//                ],)
//            ],
//          ),
//        ],
//      ),
//    );
  }
}
