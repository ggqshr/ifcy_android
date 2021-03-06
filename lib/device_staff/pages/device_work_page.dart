part of 'device_staff_pages.dart';

class DeviceStaffWorkPage extends StatefulWidget {
  Function drawerCall;

  DeviceStaffWorkPage(this.drawerCall);

  @override
  _DeviceStaffWorkPageState createState() => _DeviceStaffWorkPageState();
}

class _DeviceStaffWorkPageState extends State<DeviceStaffWorkPage>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  List<Widget> tabViews = [];
  List<Tab> tabs = [
    Tab(
      child: Text("定期巡检"),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: tabs.length, vsync: this);
    tabViews..add(RegularInspectionComponent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading:
            IconButton(icon: Icon(Icons.menu), onPressed: widget.drawerCall),
        title: Text((BlocProvider.of<AuthorizationBloc>(context).state
                as Authenticated)
            .currentBuild
            .buildName),
        centerTitle: true,
        bottom: TabBar(
          tabs: tabs,
          controller: _controller,
          labelStyle: TextStyle(fontWeight: FontWeight.w900),
          indicatorWeight: 5,
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w100),
          isScrollable: false,
        ),
      ),
      body: TabBarView(
        children: tabViews,
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }
}
