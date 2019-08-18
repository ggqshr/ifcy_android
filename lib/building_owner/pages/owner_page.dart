part of "building_owner_pages.dart";

class OwnerPage extends StatelessWidget {
  final Function drawerCall;
  OwnerPage(this.drawerCall);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
    title:BuildingOwnerAppBarComponent(),
        leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: (){
              drawerCall();
            }
        ),
      ),
      body:RefreshIndicator(
          onRefresh: () async{
            await Future.delayed(Duration(seconds: 2));
          },
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: Card(
                  elevation: 5,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: DataStatisticsComponent(),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            ),
            FireAlarmComponent(),
            DeviceFaultComponent(),
            //TaskInfoComponent(),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
            ),
          ],
        ),
      ) ,
    );
  }
}

///数据统计模块
class DataStatisticsComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState,BuildingOwnerMainViewModel>(
        distinct: true,
      converter: (Store<AppState> store){
         BuildingOwnerModel model=store.state.buildingOwnerModel;
         return BuildingOwnerMainViewModel(
           faultNum: model.deviceFaultMessages.length,
           fireNum: model.fireAlarmMessages.length,
           taskProgress: model.taskProgress,
         );
      },
      builder: (BuildContext context,BuildingOwnerMainViewModel vm){
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              flex: 2,
              child: GestureDetector(
                //todo 跳转页面逻辑
                onTap: () => Scaffold.of(context).showSnackBar(SnackBar(content: Text("test"))),
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 120,
                      child: chart.PieChart(
                        [
                          chart.Series<List,int>(
                            id:'hh',
                            domainFn: (List l, _1) => l[0],
                            measureFn: (List l, _1) => l[1],
                            data: [
                              [1, vm.faultNum],
                              [2, 100 - vm.faultNum],
                            ],
                            areaColorFn: (List l, int i) {
                              return chart.MaterialPalette.yellow.shadeDefault;
                            },
                            colorFn: (List l, __) {
                              if (l[0] == 1) {
                                return chart.MaterialPalette.yellow.shadeDefault;
                              } else {
                                return chart.MaterialPalette.green.shadeDefault;
                              }
                            },
                          ),
                        ],
                        animate: true,
                        defaultRenderer: chart.ArcRendererConfig(arcWidth: 10),
                      ),
                    ),
                    Text(
                      "${vm.faultNum.toString()}",
                      textScaleFactor: 1.5,
                      style: TextStyle(color: Colors.orange),
                    ),
                    Positioned(
                      child: Text(
                        "设备故障数",
                      ),
                      bottom: 0,
                    ),
                  ],
                  alignment: AlignmentDirectional.center,
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: GestureDetector(
                child:Stack(
                  children: <Widget>[
                    Container(
                      height: 120,
                      child: chart.PieChart(
                        [
                          chart.Series<List,int>(
                              id:'hh',
                            domainFn: (List l, _1) => l[0],
                            measureFn: (List l, _1) => l[1],
                            data: [
                              [1, vm.fireNum],
                              [2, 100 - vm.fireNum],
                            ],
                            areaColorFn: (List l, int i) {
                              return chart.MaterialPalette.red.shadeDefault;
                            },
                            colorFn: (List l, __) {
                              if (l[0] == 1) {
                                return chart.MaterialPalette.red.shadeDefault;
                              } else {
                                return chart.MaterialPalette.green.shadeDefault;
                              }
                            },
                          ),
                        ],
                        animate: true,
                        defaultRenderer: chart.ArcRendererConfig(arcWidth: 10),
                      ),
                    ),
                    Text(
                      "${vm.fireNum.toString()}",
                      textScaleFactor: 1.5,
                      style: TextStyle(color: Colors.red),
                    ),
                    Positioned(
                      child: Text(
                        "火警警报数",
                      ),
                      bottom: 0,
                    ),
                  ],
                  alignment: AlignmentDirectional.center,
                ),
                //todo 跳转到任务
                onTap: () =>
                    Scaffold.of(context)
                        .showSnackBar(
                        SnackBar(content: Text("跳转任务"))),
              ),
            ),
            Flexible(
              flex: 2,
              child: GestureDetector(
                child:Stack(
                  children: <Widget>[
                    Container(
                      height: 120,
                      child: chart.PieChart(
                        [
                          chart.Series<List,int>(
                            id:'hh',
                            domainFn: (List l, _1) => l[0],
                            measureFn: (List l, _1) => l[1],
                            data: [
                              [1, vm.taskProgress],
                              [2, 100 - vm.taskProgress],
                            ],
                            areaColorFn: (List l, int i) {
                              return chart.MaterialPalette.blue.shadeDefault;
                            },
                            colorFn: (List l, __) {
                              if (l[0] == 1) {
                                return chart.MaterialPalette.blue.shadeDefault;
                              } else {
                                return chart.MaterialPalette.green.shadeDefault;
                              }
                            },
                          ),
                        ],
                        animate: true,
                        defaultRenderer: chart.ArcRendererConfig(arcWidth: 10),
                      ),
                    ),
                    Text(
                      "${vm.taskProgress.toString()}%",
                      textScaleFactor: 1.5,
                    ),
                    Positioned(
                      child: Text(
                        "巡查进度",
                      ),
                      bottom: 0,
                    ),
                  ],
                  alignment: AlignmentDirectional.center,
                ),
                //todo 跳转到任务
                onTap: () =>
                    Scaffold.of(context)
                        .showSnackBar(
                        SnackBar(content: Text("跳转任务"))),
              ),
            ),
          ],
        );
      }
    );

  }
}
///火警消息模块
class FireAlarmComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return StoreConnector<AppState, BuildingOwnerMainViewModel>(
            converter: (Store<AppState> store) {
              return BuildingOwnerMainViewModel(
                fireNum: store.state.buildingOwnerModel.fireAlarmMessages.length,
                fireAlarmMessageList: store.state.buildingOwnerModel.fireAlarmMessages,
              );
            },
            builder: (BuildContext context, BuildingOwnerMainViewModel vm) {
              List<Widget> viewList = <Widget>[];
              //若没有消息应该显示空白以及提示
              if (vm.fireNum == 0) {
                viewList.add(ListTile(
                  title: Text("当前无火警消息"),
                ));
              } else {
                viewList = vm.fireAlarmMessageList.map<Widget>((FireAlarmMessage meg) {
                  return FireMessageTile(meg);
                }).toList();
              }

              return ExpansionCard(
                title: "今日紧急火警警报",
                messageNum: vm.fireNum,
                viewList: viewList,
              );
            },
          );
        },
        childCount: 1,
      ),
    );
  }
}
class FireMessageTile extends StatelessWidget {
  final FireAlarmMessage meg;
  FireMessageTile(this.meg);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Card(
        child: ListTile(
          leading: Icon(
            FontAwesomeIcons.fireAlt,
            color: Colors.red,
          ),
          trailing: Icon(
            Icons.chevron_right,
          ),
          title: Text(meg.content),
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
///设备故障模块
class DeviceFaultComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return StoreConnector<AppState, BuildingOwnerMainViewModel>(
            converter: (Store<AppState> store) {
              return BuildingOwnerMainViewModel(
                faultNum: store.state.buildingOwnerModel.deviceFaultMessages.length,
                deviceFaultMessageList: store.state.buildingOwnerModel.deviceFaultMessages,
              );
            },
            builder: (BuildContext context, BuildingOwnerMainViewModel vm) {
              List<Widget> viewList = <Widget>[];

              //若没有消息应该显示空白以及提示
              if (vm.faultNum == 0) {
                viewList.add(ListTile(
                  title: Text("当前无消息"),
                ));
              } else {
                viewList = vm. deviceFaultMessageList.map<Widget>((DeviceFaultMessage meg) {
                  return DeviceFaultTile(meg);
                }).toList();
              }

              return ExpansionCard(
                title: "今日设备故障警报",
                messageNum: vm.faultNum,
                viewList: viewList,
              );
            },
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
///巡检和值班人员模块
class StaffComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}




