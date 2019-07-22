part of "device_supvisor_pages.dart";

class MonitorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: AppBarCompoent(),
      ),
      body: CustomScrollView(
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
                          child: FaultNumCompoent(),
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: GestureDetector(
                          child: TaskRate(),
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
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Card(
                  child: ExpansionTile(
                    title: Text(
                      "紧急火警消息",
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
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: Card(
                          child: ListTile(
                            leading: Icon(
                              FontAwesomeIcons.fireAlt,
                              color: Colors.red,
                            ),
                            trailing: Icon(
                              Icons.chevron_right,
                            ),
                            title: Text("火灾！"),
                            subtitle: Text("发生火灾了!"),
                            onTap: () =>
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text("点击了火灾，跳转"),
                                )),
                          ),
                          elevation: 10,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: Card(
                          child: ListTile(
                            leading: Icon(
                              FontAwesomeIcons.fireAlt,
                              color: Colors.red,
                            ),
                            trailing: Icon(
                              Icons.chevron_right,
                            ),
                            title: Text("火灾！"),
                            subtitle: Text("发生火灾了!"),
                            onTap: () =>
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text("点击了火灾，跳转"),
                                )),
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
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Card(
                  child: ExpansionTile(
                    title: Text(
                      "今日设备故障",
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
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: Card(
                          child: ListTile(
                            leading: Icon(
                              FontAwesomeIcons.solidBell,
                              color: Colors.yellow.shade700,
                            ),
                            trailing: Icon(
                              Icons.chevron_right,
                            ),
                            title: Text("一楼烟感故障！"),
                            subtitle: Text("发生故障"),
                            onTap: () =>
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text("点击了火灾，跳转"),
                                )),
                          ),
                          elevation: 10,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: Card(
                          child: ListTile(
                            leading: Icon(
                              FontAwesomeIcons.solidBell,
                              color: Colors.yellow.shade700,
                            ),
                            trailing: Icon(
                              Icons.chevron_right,
                            ),
                            title: Text("二楼烟感故障！"),
                            subtitle: Text("二楼烟感故障！"),
                            onTap: () =>
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text("点击了火灾，跳转"),
                                )),
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
          ),
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
    );
  }
}
