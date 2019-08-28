part of "device_supervisor_component.dart";

class DeviceFaultComponent extends StatelessWidget {
  final List<DeviceFaultMessage> msgs;

  DeviceFaultComponent(this.msgs);

  @override
  Widget build(BuildContext context) {
    int messageNum = msgs.length;
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
            viewList = msgs.map<Widget>((DeviceFaultMessage meg) {
              return DeviceFaultTile(meg);
            }).toList();
          }

          return ExpansionCard(
            title: "今日设备故障",
            messageNum: messageNum,
            viewList: viewList,
          );
        },
        childCount: 1,
      ),
    );
  }
}

class DeviceFaultTile extends StatelessWidget {
  final DeviceFaultMessage meg;

  DeviceFaultTile(this.meg);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          title: Text(meg.title),
          subtitle: Text(meg.content),
          onTap: () => Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("跳转${meg.id}"),
              )),
        ),
        elevation: 10,
      ),
    );
  }
}
