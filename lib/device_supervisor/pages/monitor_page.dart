part of "device_supvisor_pages.dart";

class MonitorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: StoreConnector<AppState, MonitorPageAppBarModel>(
          converter: (Store<AppState> store) {
            return MonitorPageAppBarModel(
              buildingList: store.state.deviceSupervisorModel.buildingList,
              currentBuild: store.state.deviceSupervisorModel.currentBuilding,
              onChangeCall: (v) {
                store.dispatch(OnChangeBuilding(v));
              },
            );
          },
          builder: (BuildContext context, MonitorPageAppBarModel vm) {
            return DropdownButton(
              items: vm.buildingList.map((i) {
                return DropdownMenuItem<String>(
                  value: i,
                  child: Text(i),
                );
              }).toList(),
              onChanged: (v) => vm.onChangeCall(v),
              value: vm.currentBuild,
            );
          },
          distinct: true,
        ),
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
                        child: Container(
                          constraints: BoxConstraints.expand(height: 120),
                          child: Stack(
                            children: <Widget>[
                              GestureDetector(
                                //todo 跳转页面逻辑
                                onTap: () => Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text("test"))),
                                child: Text(
                                  StoreProvider.of<AppState>(context)
                                      .state
                                      .deviceSupervisorModel
                                      .faultNum
                                      .toString(),
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                  textScaleFactor: 3.5,
                                ),
                              ),
                              Positioned(
                                child: Text("设备故障数"),
                                bottom: 0,
                              )
                            ],
                            alignment: AlignmentDirectional.center,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: GestureDetector(
                          child: TaskRate(),
                          //todo 跳转到任务
                          onTap: () => Scaffold.of(context)
                              .showSnackBar(SnackBar(content: Text("跳转任务"))),
                          behavior: HitTestBehavior.translucent,
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

class TaskRate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, int>(
      distinct: true,
      converter: (Store<AppState> store) {
        return store.state.deviceSupervisorModel.taskRate;
      },
      builder: (BuildContext context, int vm) {
        return Stack(
          children: <Widget>[
            Container(
              height: 120,
              child: chart.PieChart(
                [
                  chart.Series<List, int>(
                    id: "test",
                    domainFn: (List l, _1) => l[0],
                    measureFn: (List l, _1) => l[1],
                    data: [
                      [1, vm],
                      [2, 100 - vm],
                    ],
                    areaColorFn: (List l, int i) {
                      return chart.MaterialPalette.blue.shadeDefault;
                    },
                    colorFn: (List l, __) {
                      if (l[0] == 1) {
                        return chart.MaterialPalette.blue.shadeDefault;
                      } else {
                        return chart.MaterialPalette.gray.shadeDefault;
                      }
                    },
                  ),
                ],
                animate: true,
                defaultRenderer: chart.ArcRendererConfig(arcWidth: 10),
              ),
            ),
            Text(
              "${vm.toString()}%",
              style: TextStyle(decoration: TextDecoration.underline),
              textScaleFactor: 1.5,
            ),
            Positioned(
              child: Text(
                "巡查进度",
              ),
              bottom: 0,
            ),
          ],
          alignment: AlignmentDirectional.center,
        );
      },
    );
  }
}
