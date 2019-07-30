part of "device_supvisor_pages.dart";

class TaskPage extends StatelessWidget {
  final Function drawerCall;
  TaskPage(this.drawerCall);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '任务安排列表',
      home: TaskListComponent(),
    );
  }
}
