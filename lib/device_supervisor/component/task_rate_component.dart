part of 'device_supervisor_component.dart';

class TaskRateComponent extends StatelessWidget {
  final int taskRate;

  TaskRateComponent(this.taskRate);

  @override
  Widget build(BuildContext context) {
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
                  [1, taskRate],
                  [2, 100 - taskRate],
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
          "${taskRate.toString()}%",
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
  }
}
