part of "device_supvisor_pages.dart";

class MonitorPage extends StatelessWidget {
  final Function drawerCall;

  MonitorPage(this.drawerCall);

  scan(call) async {
    try {
      ScanResult dd = await BarcodeScanner.scan();
      call(dd);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        call('The user did not grant the camera permission!');
      } else {
        call('Unknown error: $e');
      }
    } on FormatException {
      call(
          'null (User returned using the "back"-button before scanning anything. Re');
    } catch (e) {
      call('Unknown error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    MonitorBloc bloc = BlocProvider.of<MonitorBloc>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text((BlocProvider.of<AuthorizationBloc>(context).state
                as Authenticated)
            .currentBuild
            .buildName),
        leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              drawerCall();
            }),
//        actions: <Widget>[
//          IconButton(
//              icon: Icon(Icons.add),
//              onPressed: () {
//                Auth.getInstance().reset();
//                DioUtils.getInstance().resetDio();
//              })
//        ],
      ),
      body: BlocBuilder<MonitorBloc, MonitorState>(
          // ignore: missing_return
          builder: (context, state) {
        if (state is LoadedErrorMonitorState) {
          return LoadErrorPage(() => bloc.add(FetchMonitorDataEvent()));
        }
        if (state is UnInitializationMonitorState) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircularProgressIndicator(),
                Text("加载中"),
              ],
            ),
          );
        }
        if (state is LoadedMonitorState) {
          return RefreshIndicator(
            onRefresh: () async {
              bloc.add(FetchMonitorDataEvent());
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
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Flexible(
                              flex: 3,
                              child: GestureDetector(
                                child: FaultNumComponent(
                                    state.deviceFaultNum.toString()),
                              ),
                            ),
                            Flexible(
                              flex: 3,
                              child: GestureDetector(
                                child:
                                    TaskRateComponent(state.taskCompleteRate),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                ),
                FireAlarmComponent(state.fireAlarmMsg),
                DeviceFaultComponent(state.deviceFaultMsg),
//                TaskInfoComponent(state.taskInfoMsg),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
