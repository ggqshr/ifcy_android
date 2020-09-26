///@author ggq
///@description:
///@date :2019/9/3 11:04
part of "device_supvisor_pages.dart";

typedef LoadCall = CheckAlarmListEvent Function(bool isfire);
typedef RefreshCall = CheckAlarmListEvent Function(bool isfire);

class CheckedAlarmPage extends StatefulWidget {
  final String titleString;
  final Function resultComponents;
  final bool isFire;
  final RefreshCall refreshCall;
  final LoadCall loadCall;

  CheckedAlarmPage(
      this.resultComponents, this.isFire, this.refreshCall, this.loadCall,
      {this.titleString = "历史消息"});

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
        title: Text(widget.titleString),
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
              return model.dataList.isEmpty
                  ? BlankPage(
                      showText: "无历史消息",
                      onRefreshCall: () =>
                          bloc.add(widget.refreshCall(widget.isFire)),
                    )
                  : EasyRefresh(
                      footer: getFooter(),
                      header: getHeader(),
                      bottomBouncing: false,
                      enableControlFinishLoad: true,
                      controller: _controller,
                      onRefresh: () async {
                        bloc.add(widget.refreshCall(widget.isFire));
                      },
                      onLoad: () async {
                        bloc.add(widget.loadCall(widget.isFire));
                      },
                      child: ListView.builder(
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
