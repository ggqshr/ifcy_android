part of "device_supvisor_pages.dart";

class MonitorPage extends StatelessWidget {
  final Function drawerCall;

  MonitorPage(this.drawerCall);

  scan(call) async {
    try {
      String dd = await BarcodeScanner.scan();
      call(dd);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
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
  return Scaffold(
    appBar: AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: AppBarComponent(),
      leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            drawerCall();
          }),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () =>
              scan((data) =>
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text(data)))),
        )
      ],
    ),
    body: RefreshIndicator(
      //todo 刷新回调
      onRefresh: () async {
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
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Flexible(
                        flex: 3,
                        child: GestureDetector(
                          //todo 跳转页面逻辑
                          onTap: () =>
                              Scaffold.of(context)
                                  .showSnackBar(
                                  SnackBar(content: Text("test"))),
                          child: FaultNumComponent(),
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: GestureDetector(
                          child: TaskRateComponent(),
                          //todo 跳转到任务
                          onTap: () =>
                              Scaffold.of(context)
                                  .showSnackBar(
                                  SnackBar(content: Text("跳转任务"))),
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
          FireAlarmComponent(),
          DeviceFaultComponent(),
          TaskInfoComponent(),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
          ),
        ],
      ),
    ),
  );
}}
