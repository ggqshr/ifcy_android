part of "property_manager_pages.dart";

class FaultDeclarePage extends StatefulWidget {
  @override
  _FaultDeclarePageState createState() => _FaultDeclarePageState();
}

class _FaultDeclarePageState extends State<FaultDeclarePage>
    with SingleTickerProviderStateMixin {
  EasyRefreshController _controller;
  DeclareMessageBloc _bloc;

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    _bloc = BlocProvider.of<DeclareMessageBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("申报情况列表"),
        centerTitle: true,
      ),
      body: BlocProvider<CheckDeclareBloc>(
        builder: (context) {
          return CheckDeclareBloc(CheckDeclareRepositories());
        },
        child: MultiBlocListener(
          listeners: [
            BlocListener<DeclareMessageBloc, DeclareMessageState>(
              listener: (context, state) {
                _controller.resetLoadState();
                if (state is LoadedDeclareMessageState) {
                  if (state.isReachMax) {
                    _controller.finishLoad(success: true, noMore: true);
                  } else {
                    _controller.finishLoad(success: true);
                  }
                }
              },
            ),
            BlocListener<CheckDeclareBloc, CheckDeclareState>(
              listener: (context, state) {
                if (state is CheckStatusDeclareState) {
                  if (state.isChecking) {
                    Scaffold.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('提交中'),
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
                            children: [Text('提交失败，请稍后再试'), Icon(Icons.error)],
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
                    _bloc.dispatch(RefreshDeclareMessage());
                  }
                }
              },
            )
          ],
          child: BlocBuilder<DeclareMessageBloc, DeclareMessageState>(
            // ignore: missing_return
            builder: (context, state) {
              CheckDeclareBloc _checkDeclareBloc =
                  BlocProvider.of<CheckDeclareBloc>(context);
              if (state is LoadingDeclareMessageState) {
                return LoadingPage();
              }
              if (state is LoadErrorDeclareMessageState) {
                return LoadErrorPage(
                    () => _bloc.dispatch(FetchDeclareMessage()));
              }
              if (state is LoadedDeclareMessageState) {
                if (state.models.dataList.isEmpty) {
                  return Center(
                    child: Text("无申报纪录"),
                  );
                }
                return EasyRefresh(
                  footer: getFooter(),
                  header: getHeader(),
                  bottomBouncing: false,
                  enableControlFinishLoad: true,
                  controller: _controller,
                  onRefresh: () async {
                    _bloc.dispatch(RefreshDeclareMessage());
                  },
                  onLoad: () async {
                    _bloc.dispatch(FetchDeclareMessage());
                  },
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      DeclareMessage thisDevice = state.models.dataList[index];
                      return Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                                title: Text("标题"),
                                trailing: Text(thisDevice.title ?? "无"),
                                dense: true),
                            ListTile(
                                title: Text("备注"),
                                trailing: Text(thisDevice.comment ?? "无"),
                                dense: true),
                            ListTile(
                                title: Text("是否已确认"),
                                trailing: Text(thisDevice.checked ? "是" : "否"),
                                dense: true),
                            ListTile(
                                title: Text("发起申报者ID"),
                                trailing: Text(
                                    thisDevice.postUserId.toString() ?? "无"),
                                dense: true),
                            ListTile(
                                title: Text("通过者ID"),
                                trailing: Text(
                                    thisDevice.checkedUserId.toString() ?? "无"),
                                dense: true),
                            ExpansionTile(
                              title: Text("申报设备Code列表"),
                              children: getDeclareListTile(thisDevice),
                            ),
                            if (!thisDevice.checked)
                              ListTile(
                                title: ButtonBar(
                                  children: <Widget>[
                                    RaisedButton(
                                      child: Text("已读"),
                                      onPressed: () {
                                        _checkDeclareBloc.dispatch(
                                            CheckPassDeclareMessageEvent(
                                                thisDevice.id));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                    itemCount: state.models.dataList.length,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  List<Widget> getDeclareListTile(DeclareMessage message) {
    return message.deviceList
        .map((item) => ListTile(
              title: Text("设备code"),
              trailing: Text(item['code']),
            ))
        .toList();
  }
}
