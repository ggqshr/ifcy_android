part of "device_staff_components.dart";

class RegularInspectionComponent extends StatefulWidget {
  @override
  _RegularInspectionComponentState createState() =>
      _RegularInspectionComponentState();
}

class _RegularInspectionComponentState extends State<RegularInspectionComponent>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: <Widget>[
        SliverPersistentHeader(
          delegate: ChangeTaskState(_controller),
        ),
        SliverFillRemaining(
          child: Container(
            child: TabBarView(
              children: [
                getUnFinishTask(),
                getFinishTask(),
              ],
              controller: _controller,
            ),
          ),
        ),
      ],
    );
  }

  getFinishTask() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          elevation: 5,
          margin: EdgeInsets.fromLTRB(15, 6, 15, 6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(
                flex: 2,
                child: ListTile(
                  title: Text("ss"),
                  trailing: FlatButton.icon(
                    onPressed: null,
                    icon: Icon(Icons.check_circle_outline,color: Colors.green,),
                    label: Text("已完成"),
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              ListTile(
                dense: true,
                title: Text("任务内容:巡检"),
              ),
              ListTile(
                dense: true,
                title: Text("委派人员：me"),
              ),
              ListTile(
                dense: true,
                title: Text("起始时间：2019年7月30日"),
              ),
            ],
          ),
        );
      },
    );
  }

  getUnFinishTask() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          elevation: 5,
          margin: EdgeInsets.fromLTRB(15, 6, 15, 6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(
                flex: 2,
                child: ListTile(
                  title: Text("ss"),
                  trailing: FlatButton.icon(
                    onPressed: () => {},
                    icon: Icon(Icons.play_arrow),
                    label: Text("执行"),
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              ListTile(
                dense: true,
                title: Text("任务内容:巡检"),
              ),
              ListTile(
                dense: true,
                title: Text("委派人员：me"),
              ),
              ListTile(
                dense: true,
                title: Text("起始时间：2019年7月30日"),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ChangeTaskState extends SliverPersistentHeaderDelegate {
  TabController _controller;

  ChangeTaskState(this._controller);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return TabBar(
      tabs: [
        Tab(
          child: Text("完成"),
        ),
        Tab(
          child: Text("未完成"),
        )
      ],
      controller: _controller,
    );
  }

  @override
  double get maxExtent => 40;

  @override
  double get minExtent => 40;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
