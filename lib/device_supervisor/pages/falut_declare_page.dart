part of "device_supvisor_pages.dart";

class FaultDeclarePage extends StatefulWidget {
  @override
  _FaultDeclarePageState createState() => _FaultDeclarePageState();
}

class _FaultDeclarePageState extends State<FaultDeclarePage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    DeclareMessageBloc _bloc = BlocProvider.of<DeclareMessageBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("申报情况列表"),
        centerTitle: true,
      ),
      body: BlocBuilder<DeclareMessageBloc, DeclareMessageState>(
        // ignore: missing_return
        builder: (context, state) {
          if (state is LoadingReportDevicesState) {
            return LoadingPage();
          }
          if (state is LoadErrorDeviceMessageState) {
            return LoadErrorPage(() => _bloc.dispatch(FetchDeclareMessage()));
          }
          if (state is LoadedDeclareMessageState) {
            if (state.models.dataList.isEmpty) {
              return Center(
                child: Text("无申报纪录"),
              );
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                DeclareMessage thisDevice = state.models.dataList[index];
                return Card(
                  child: ExpansionTile(
                    title: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                            title: Text("标题"),
                            trailing: Text(thisDevice.title??"无"),
                            dense: true),
                        ListTile(
                            title: Text("备注"),
                            trailing: Text(thisDevice.comment??"无"),
                            dense: true),
                        ListTile(
                            title: Text("是否已确认"),
                            trailing: Text(thisDevice.checked ? "是" : "否"),
                            dense: true),
                        ListTile(
                            title: Text("发起申报者ID"),
                            trailing: Text(thisDevice.postUserId??"无"),
                            dense: true),
                        ListTile(
                            title: Text("通过者ID"),
                            trailing: Text(thisDevice.checkedUserId??"无"),
                            dense: true),
                      ],
                    ),
                    children: getDeclareListTile(thisDevice),
                  ),
                );
              },
              itemCount: state.models.dataList.length,
            );
          }
        },
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
