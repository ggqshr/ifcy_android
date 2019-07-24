part of 'device_supervisor_compoent.dart';

class TaskRateComponent extends StatelessWidget {
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
