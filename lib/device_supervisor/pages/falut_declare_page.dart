part of "device_supvisor_pages.dart";

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
      body: BlocListener<DeclareMessageBloc, DeclareMessageState>(
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
        child: BlocBuilder<DeclareMessageBloc, DeclareMessageState>(
          // ignore: missing_return
          builder: (context, state) {
            if (state is LoadingDeclareMessageState) {
              return LoadingPage();
            }
            if (state is LoadErrorDeclareMessageState) {
              return LoadErrorPage(() => _bloc.dispatch(FetchDeclareMessage()));
            }
            if (state is LoadedDeclareMessageState) {
              if (state.models.dataList.isEmpty) {
                return Center(
                  child: Text("无申报纪录"),
                );
              }
              return EasyRefresh(
                footer: ClassicalFooter(
                  loadText: "释放加载更多",
                  loadReadyText: "释放加载更多",
                  loadingText: "正在加载",
                  loadedText: "加载成功",
                  loadFailedText: "加载失败",
                  noMoreText: "没有更多数据",
                  infoText: "更新于 %T",
                ),
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
                      child: ExpansionTile(
                        title: Column(
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
                          ],
                        ),
                        children: getDeclareListTile(thisDevice),
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
    );
  }

  List<Widget> getDeclareListTile(DeclareMessage message) {
    return [
      ListTile(
        title: Text("申报设备Code列表"),
      ),
      ...message.deviceList
          .map((item) => ListTile(
                title: Text("设备code"),
                trailing: Text(item['code']),
              ))
          .toList(),
    ];
  }
}
