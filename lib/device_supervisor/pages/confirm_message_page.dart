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
    return BlocListener<ConfirmMessageBloc, ConfirmMessageState>(
      listener: (context, state) {
        if (state is ConfirmedState) {
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
                    children: [Text('提交失败'), Icon(Icons.error)],
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
                      Text('提交成功'),
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
            return LoadingPage();
          }
          if (state is LoadedConfirmDataState) {
            return getContent(bloc, state, context);
          }
          if (state is ConfirmedState) {
            return getContent(bloc, state, context);
          }
        },
      ),
    );
  }

  Widget getContent(
    ConfirmMessageBloc bloc,
    state,
    context,
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
          title: Text("查看设备位置"),
          trailing: RaisedButton(
            child: Text("查看"),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return BlocProvider(
                  create: (context) {
                    return FloorDeviceBloc(
                      repositories: FloorMapDataRepositories(),
                      floorId: state.message.floorId,
                      deviceCode: state.message.deviceCode,
                    )..add(LoadFloorDeviceDetailEvent());
                  },
                  child: FloorDevicePage(state.message is FireAlarmMessage),
                );
              }));
            },
          ),
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
                        Text(state.message is FireAlarmMessage ? "真火警" : "处理"),
                    onPressed: () => showDialogToCheck(context,
                        (text) => bloc.add(ConfirmMessage(true, text))),
                  ),
                  RaisedButton(
                    child:
                        Text(state.message is FireAlarmMessage ? "误报火警" : "申报"),
                    onPressed: () => showDialogToCheck(context,
                        (text) => bloc.add(ConfirmMessage(false, text))),
                  ),
                ],
              ),
            ),
          ),
        if (state is ConfirmedState && state.isSuccess)
          ListTile(
            title: Center(
              child: Text(
                  "已确认为${state.result ? state.message is FireAlarmMessage ? "火警" : "已处理" : state.message is FireAlarmMessage ? "假火警" : "未处理"}"),
            ),
          ),
      ],
    );
  }

  Future showDialogToCheck(
    BuildContext context,
    Function onPressCall,
  ) async {
    String commentText;
    bool isCheck = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("填写备注信息"),
            content: Form(
              autovalidate: true,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "提供确认信息",
                ),
                onChanged: (value) {
                  commentText = value;
                },
                autovalidate: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return "请输入确认信息";
                  }
                  return null;
                },
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("取消"),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text("确认"),
                onPressed: () {
                  if (commentText != null) Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });
    if (isCheck) {
      onPressCall(commentText);
    }
  }
}
