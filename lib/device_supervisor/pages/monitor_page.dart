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
          )
        ],
      ),
    );
  }
}
