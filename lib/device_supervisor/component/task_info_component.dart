part of 'device_supervisor_component.dart';

class TaskInfoComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return StoreConnector<AppState, TaskInfoModel>(
            converter: (Store<AppState> store) {
              DeviceSupervisorModel state = store.state.deviceSupervisorModel;
              return TaskInfoModel(
                messageNum: state.taskInfoMessages.length,
                completedTask: state.taskInfoMessages.where((msg) {
                  return msg.status == TaskStatus.completed;
                }).toList(),
                uncompletedTask: state.taskInfoMessages.where((msg) {
                  return msg.status == TaskStatus.uncompleted;
                }).toList(),
              );
            },
            builder: (BuildContext context, TaskInfoModel vm) {
              List<Widget> viewList = <Widget>[];

              //若没有消息应该显示空白以及提示
              if (vm.messageNum == 0) {
                viewList.add(ListTile(
                  title: Text("当前无消息"),
                ));
              } else {
                viewList
                  ..add(
                    TaskTile(
                      vm.completedTask,
                      Icon(
                        Icons.check_circle_outline,
                        color: Colors.green,
                      ),
                    ),
                  )
                  ..add(
                    TaskTile(
                      vm.uncompletedTask,
                      Icon(
                        FontAwesomeIcons.playCircle,
                        color: Colors.yellow.shade700,
                      ),
                    ),
                  );
              }
              return ExpansionCard(
                title: "今日任务执行情况",
                messageNum: vm.messageNum,
                viewList: viewList,
              );
            },
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
          leading: Icon(
            Icons.check_circle_outline,
            color: Colors.green,
          ),
          trailing: Icon(
            Icons.chevron_right,
          ),
          title: Text("已完成任务 ${msgs.length}"),
          children: viewList,
          initiallyExpanded: true,
        ),
        elevation: 10,
      ),
    );
  }
}
