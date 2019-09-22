///@author ggq
///@description:
///@date :2019/9/3 11:04
part of "device_supvisor_pages.dart";

class CheckedAlarmPage extends StatefulWidget {
  final Function resultComponents;
  final bool isFire;

  CheckedAlarmPage(this.resultComponents,this.isFire);

  @override
  _CheckedAlarmPageState createState() => _CheckedAlarmPageState();
}

class _CheckedAlarmPageState extends State<CheckedAlarmPage> {
  EasyRefreshController _controller;
  CheckAlarmListBloc bloc;

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    bloc = BlocProvider.of<CheckAlarmListBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("历史消息"),
        centerTitle: true,
      ),
      body: BlocListener<CheckAlarmListBloc, CheckAlarmListState>(
        listener: (context, state) {
          _controller.resetLoadState();
          if (state is LoadedCheckAlarmState) {
            if (state.isReachMax) {
              _controller.finishLoad(success: true, noMore: true);
            } else {
              _controller.finishLoad(success: true);
            }
          }
        },
        child: BlocBuilder<CheckAlarmListBloc, CheckAlarmListState>(
          builder: (context, state) {
            if (state is LoadErrorCheckAlarmState) {
              return Center(
                child: Text("网络出现错误"),
              );
            } else if (state is LoadingCheckAlarmState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LoadedCheckAlarmState) {
              PageDataModel model = state.model;
              return EasyRefresh(
                footer: getFooter(),
                header: getHeader(),
                bottomBouncing: false,
                enableControlFinishLoad: true,
                controller: _controller,
                onRefresh: () async {
                  bloc.dispatch(RefreshCheckAlarmData(widget.isFire));
                },
                onLoad: () async {
                  bloc.dispatch(FetchCheckedAlarmData(widget.isFire));
                },
                child: model.dataList.isEmpty
                    ? Center(
                        child: Text("无历史消息"),
                      )
                    : ListView.builder(
                        itemCount: model.dataList.length,
                        itemBuilder: (context, index) {
                          var thisTask = model.dataList[index];
                          return CheckAlarmPanelComponent(
                            thisTask,
                            widget.resultComponents(thisTask),
                          );
                        },
                      ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
