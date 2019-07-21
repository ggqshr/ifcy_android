part of "device_supvisor_pages.dart";

class MonitorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: DropdownButton(
          items: ["大厦1", "大厦2"].map((i) {
            return DropdownMenuItem<String>(
              value: i,
              child: Text(i),
            );
          }).toList(),
          onChanged: (v) {},
          value: "大厦1",
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: Card(
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Flexible(
                        flex: 3,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: 120,
                              child: PieChart(
                                [
                                  Series<List, int>(
                                    id: "test",
                                    domainFn: (List l, _1) => l[0],
                                    measureFn: (List l, _1) => l[1],
                                    data: [
                                      [1, 200],
                                      [2, 300],
                                      [3, 400],
                                    ],
                                  ),
                                ],
//                          animate: true,
                                defaultRenderer:
                                    ArcRendererConfig(arcWidth: 12),
                              ),
                            ),
                            Text("你好"),
                            Positioned(
                              child: Text("设备故障"),
                              bottom: 0,
                            )
                          ],
                          alignment: AlignmentDirectional.center,
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: 120,
                              child: PieChart(
                                [
                                  Series<List, int>(
                                    id: "test",
                                    domainFn: (List l, _1) => l[0],
                                    measureFn: (List l, _1) => l[1],
                                    data: [
                                      [1, 200],
                                      [2, 300],
                                      [3, 400],
                                    ],
                                  ),
                                ],
//                          animate: true,
                                defaultRenderer:
                                ArcRendererConfig(arcWidth: 12),
                              ),
                            ),
                            Text("你好"),
                            Positioned(
                              child: Text("巡查进度"),
                              bottom: 0,
                            ),
                          ],
                          alignment: AlignmentDirectional.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
