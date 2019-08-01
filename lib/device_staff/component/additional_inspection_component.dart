part of "device_staff_components.dart";

class AdditionalInspectionComponent extends StatefulWidget {
  AdditionalInspectionComponent({Key key}) : super(key: key);

  @override
  _AdditionalInspectionComponentState createState() =>
      _AdditionalInspectionComponentState();
}

class _AdditionalInspectionComponentState
    extends State<AdditionalInspectionComponent>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _controller;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _scrollController.dispose();
  }

  scrollCall() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(0,
          duration: Duration(seconds: 1), curve: Curves.easeIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: <Widget>[
        SliverPersistentHeader(
          delegate: ChangeTaskState(_controller, scrollCall),
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
    return RefreshIndicator(
      child: ListView.builder(
        key: PageStorageKey("RegularInspectionComponentgetFinishTask"),
        controller: _scrollController,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            margin: EdgeInsets.fromLTRB(15, 6, 15, 6),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(
                  flex: 2,
                  child: ListTile(
                    title: Text("ss"),
                    trailing: FlatButton.icon(
                      onPressed: null,
                      icon: Icon(
                        Icons.check_circle_outline,
                        color: Colors.green,
                      ),
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
      ),
      onRefresh: () async {
        //todo 完成任务下拉刷新回调
        await Future.delayed(Duration(seconds: 2));
      },
    );
  }

  getUnFinishTask() {
    return RefreshIndicator(
      child: ListView.builder(
        key: PageStorageKey("RegularInspectionComponentgetUnFinishTask"),
        controller: _scrollController,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            margin: EdgeInsets.fromLTRB(15, 6, 15, 6),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
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
      ),
      onRefresh: () async {
        //todo 未完成下拉刷新回调
        await Future.delayed(Duration(seconds: 2));
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
