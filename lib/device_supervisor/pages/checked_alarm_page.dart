///@author ggq
///@description:
///@date :2019/9/3 11:04
part of "device_supvisor_pages.dart";

typedef LoadCall = CheckAlarmListEvent Function(bool isfire);
typedef RefreshCall = CheckAlarmListEvent Function(bool isfire);

dynamic date;

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
        actions:<Widget>[
          Builder(
            builder: (context) {
              return IconButton(
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                icon: Icon(FontAwesomeIcons.filter),
              );
            },
          ),
        ],
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
            }else if(state is FilteringCheckAlarmState){
              PageDataModel model = state.model;
              return model.dataList.isEmpty
                  ? BlankPage(
                showText: "无历史消息",
                onRefreshCall: () =>
                    bloc.add(RefreshCheckAlarmData(widget.isFire)),
              )
                  : EasyRefresh(
                footer: getFooter(),
                header: getHeader(),
                bottomBouncing: false,
                enableControlFinishLoad: true,
                controller: _controller,
                onRefresh: () async {
                  bloc.add(RefreshCheckAlarmData(widget.isFire));
                },
                onLoad: () async {
                  bloc.add(FetchCheckedAlarmData(widget.isFire));
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
      endDrawer:new FilterEndDrawer(),
    );
  }
}


class FilterEndDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    CheckAlarmListBloc bloc1 = BlocProvider.of<CheckAlarmListBloc>(context);

    return Container(
      width: 250,
      child: Drawer(
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).viewPadding.top,
                ),
                Center(
                  child: Container(
                    child: Text("筛选"),
                  ),
                ),
                Divider(
                  color: Colors.black,
                ),
                BlocBuilder<CheckAlarmListBloc, CheckAlarmListState>(
                  // ignore: missing_return
                  builder: (context, state) {
                    if (state is LoadingCheckAlarmState) {
                      return Container(
                        child: Text("加载中"),
                      );
                    }
                    if (state is LoadedCheckAlarmState) {
                      return ListTile(
                        title: Text("发现日期:"),
                        trailing: RaisedButton(
                          child: new Text('选择'),
                          onPressed: () async {
                            // 调用函数打开
                            date = await showDatePicker (
                              context: context,
                              initialDate: new DateTime.now(),
                              firstDate: new DateTime(2000),
                              lastDate: new DateTime(2100),
                            ).catchError((err) {
                              print(err);
                            });
                          },
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
            Positioned(
              child: Container(
                width: 250,
                child: Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        onPressed: () {
                          print(date);
                          bloc1.add(UpdateAlarmByDate(date));
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "应用",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              bottom: 0,
            )
          ],
        ),
      ),
    );
  }
}
