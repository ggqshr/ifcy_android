///@author ggq
///@description:
///@date :2019/9/2 15:58
part of "device_supvisor_pages.dart";

class ConfirmMessagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("确认状态"),
      ),
      body: BodyContext(),
    );
  }
}

class BodyContext extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ConfirmMessageBloc bloc = BlocProvider.of<ConfirmMessageBloc>(context);
    return BlocListener<ConfirmMessageBloc,ConfirmMessageState>(
      listener: (context,state){
        if(state is ConfirmedState){
          if (state.isConfirming) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('确认中...'),
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              );
          }
          if (state.isFault) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('修改失败'), Icon(Icons.error)],
                  ),
                  backgroundColor: Colors.red,
                ),
              );
          }
          if (state.isSuccess) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('修改成功'),
                      Icon(Icons.check),
                    ],
                  ),
                ),
              );
          }
        }
      },
      child: BlocBuilder<ConfirmMessageBloc, ConfirmMessageState>(
        // ignore: missing_return
        builder: (context, state) {
          if (state is LoadingConfirmDataState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is LoadedConfirmDataState) {
            return getContent(bloc, state);
          }
          if (state is ConfirmedState) {
            return getContent(bloc, state);
          }
        },
      ),
    );
  }

  Widget getContent(
    ConfirmMessageBloc bloc,
    state,
  ) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text("设备名称"),
          trailing: Text(state.message.deviceName),
        ),
        ListTile(
          title: Text("设备编码"),
          trailing: Text(state.message.deviceCode),
        ),
        ListTile(
          title: Text("主机标识"),
          trailing: Text(state.message.mainEngineCode),
        ),
        ListTile(
          title: Text("警报发生时间"),
          trailing: Text(state.message.sendTime.toString().substring(0, 10)),
        ),
        if (state is LoadedConfirmDataState)
          ListTile(
            title: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  RaisedButton(
                    child:
                        Text(state.message is FireAlarmMessage ? "真火警" : "已处理"),
                    onPressed: () => bloc.dispatch(ConfirmMessage(true)),
                  ),
                  RaisedButton(
                    child:
                        Text(state.message is FireAlarmMessage ? "设备故障" : "未处理"),
                    onPressed: () => bloc.dispatch(ConfirmMessage(false)),
                  ),
                ],
              ),
            ),
          ),
        if (state is ConfirmedState&&state.isSuccess)
          ListTile(
            title: Center(
              child: Text(
                  "已确认为${state.result ? state.message is FireAlarmMessage ? "火警" : "已处理" : state.message is FireAlarmMessage ? "假火警" : "未处理"}"),
            ),
          ),
      ],
    );
  }
}
