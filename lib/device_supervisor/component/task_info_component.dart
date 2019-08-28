part of 'device_supervisor_component.dart';

class TaskInfoComponent extends StatelessWidget {
  final List<TaskInfoMessage> msgs;

  TaskInfoComponent(this.msgs);

  @override
  Widget build(BuildContext context) {
    int messageNum = msgs.length;
    List<TaskInfoMessage> completedTask = List.from(msgs.where((item)=>item.status==TaskStatus.completed));
    List<TaskInfoMessage> unCompletedTask = List.from(msgs.where((item)=>item.status==TaskStatus.uncompleted));
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          List<Widget> viewList = <Widget>[];

          //若没有消息应该显示空白以及提示
          if (messageNum == 0) {
            viewList.add(ListTile(
              title: Text("当前无消息"),
            ));
          } else {
            viewList
              ..add(
                TaskTile(
                  completedTask,
                  Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                  ),
                ),
              )
              ..add(
                TaskTile(
                  unCompletedTask,
                  Icon(
                    FontAwesomeIcons.playCircle,
                    color: Colors.yellow.shade700,
                  ),
                ),
              );
          }
          return ExpansionCard(
            title: "今日任务执行情况",
            messageNum: messageNum,
            viewList: viewList,
          );
        },
        childCount: 1,
      ),
    );
  }
}

class TaskTile extends StatelessWidget {
  final Icon showIcon;
  final List<TaskInfoMessage> msgs;

  TaskTile(this.msgs, this.showIcon);

  @override
  Widget build(BuildContext context) {
    String showText = msgs[0].status==TaskStatus.uncompleted?"未完成任务":"已完成任务";
    List<Widget> viewList = [];
    if (msgs.length == 0) {
      viewList.add(
        ListTile(
          title: Text("无消息"),
        ),
      );
    } else {
      viewList = msgs.map<Widget>((i) {
        return ListTile(
          title: Text(i.title),
          //todo 跳转到指定页面
          onTap: () =>
              Scaffold.of(context).showSnackBar(SnackBar(content: Text(i.id))),
        );
      }).toList();
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Card(
        child: ExpansionTile(
          leading: showIcon,
          trailing: Icon(
            Icons.chevron_right,
          ),
          title: Text("$showText ${msgs.length}"),
          children: viewList,
          initiallyExpanded: true,
        ),
        elevation: 10,
      ),
    );
  }
}
