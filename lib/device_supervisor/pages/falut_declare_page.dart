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
              return LoadErrorPage(() => _bloc.add(FetchDeclareMessage()));
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
                  _bloc.add(RefreshDeclareMessage());
                },
                onLoad: () async {
                  _bloc.add(FetchDeclareMessage());
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
                              trailing:
                                  Text(thisDevice.postUserId.toString() ?? "无"),
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
