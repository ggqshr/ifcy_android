part of "device_supervisor_component.dart";

//任务执行统计部分
class TaskExcuteChartComponent extends StatelessWidget {

  final TaskExecuteModel taskExecuteModel;
  final TaskDetailModel taskDetailModel;

  TaskExcuteChartComponent(this.taskExecuteModel, this.taskDetailModel);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.all(20.0),
        child: new Card(
            elevation: 3.0,
            child: Column(children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child:
                          Text('任务总数:${taskExecuteModel.taskNum.toString()}'),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                          '已完成任务数:${taskExecuteModel.taskCompletedNum.toString()}'),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                          '进行中任务数:${taskExecuteModel.taskUnCompletedNum.toString()}'),
                    ),
                  ),
                ],
              ),
              TaskBarChart(taskDetailModel:taskDetailModel,),
            ])));
  }
}

//任务执统计柱状图
class TaskBarChart extends StatefulWidget {

  final TaskDetailModel taskDetailModel;
  TaskBarChart({this.taskDetailModel});

  @override
  _TaskBarChartState createState() => _TaskBarChartState();
}

class _TaskBarChartState extends State<TaskBarChart> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 200.0,
            child: chart.BarChart(
              //通过下面获取数据传入
              ChartFlutterBean.createSampleData(),
            ),
          ),
        ],
      ),
    );
  }
}

class ChartFlutterBean {
  static List<chart.Series<TaskExcute, String>> createSampleData() {
    final data = [
      new TaskExcute('xxx', 50),
      new TaskExcute('zzz', 30),
      new TaskExcute('www', 20),
      new TaskExcute('lll', 75),
    ];

    return [
      new chart.Series<TaskExcute, String>(
        displayName: '任务执行情况',
        colorFn: (_, __) => chart.MaterialPalette.green.shadeDefault,
        domainFn: (TaskExcute task, _) => task.excutor,
        measureFn: (TaskExcute task, _) => task.progress,
        data: data,
      )
    ];
  }
}


class TaskExcute {
  final String excutor;
  final double progress;

  TaskExcute(this.excutor, this.progress);
}
