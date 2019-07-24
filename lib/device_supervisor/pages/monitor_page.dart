part of "device_supvisor_pages.dart";

class MonitorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: AppBarComponent(),
      ),
      body: RefreshIndicator(
        //todo 刷新回调
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 2));
        },
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: Card(
                  elevation: 5,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Flexible(
                          flex: 3,
                          child: GestureDetector(
                            //todo 跳转页面逻辑
                            onTap: () => Scaffold.of(context)
                                .showSnackBar(SnackBar(content: Text("test"))),
                            child: FaultNumComponent(),
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: GestureDetector(
                            child: TaskRateComponent(),
                            //todo 跳转到任务
                            onTap: () => Scaffold.of(context)
                                .showSnackBar(SnackBar(content: Text("跳转任务"))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            ),
            FireAlarmComponent(),
            DeviceFaultComponent(),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Card(
                    child: ExpansionTile(
                      title: Text(
                        "今日巡检进度",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                        textScaleFactor: 1.3,
                      ),
//                  leading: Icon(
//                    FontAwesomeIcons.fireAlt,
//                    color: Colors.red,
//                  ),
                      initiallyExpanded: true,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Card(
                            child: ExpansionTile(
                              leading: Icon(
                                Icons.check_circle_outline,
                                color: Colors.green,
                              ),
                              trailing: Icon(
                                Icons.chevron_right,
                              ),
                              title: Text("已完成任务 2"),
                              children: <Widget>[
                                ListTile(
                                  title: Text("员工1完成了二楼的巡检任务"),
                                )
                              ],
                              initiallyExpanded: true,
                            ),
                            elevation: 10,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                          child: Card(
                            child: ExpansionTile(
                              leading: Icon(
                                FontAwesomeIcons.playCircle,
                                color: Colors.yellow.shade700,
                              ),
                              trailing: Icon(
                                Icons.chevron_right,
                              ),
                              title: Text("进行中任务 3"),
                              children: <Widget>[
                                ListTile(
                                  title: Text("员工1完成了二楼的巡检任务"),
                                )
                              ],
                              initiallyExpanded: true,
                            ),
                            elevation: 10,
                          ),
                        )
                      ],
                    ),
                  );
                },
                childCount: 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}