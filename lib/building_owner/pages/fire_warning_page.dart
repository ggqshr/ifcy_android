part of "building_owner_pages.dart";

class FireWarningPage extends StatelessWidget {

  Function drawerCall;
  FireWarningPage();

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       automaticallyImplyLeading: false,
       title: Text(
         '火警警报记录',
         style: TextStyle(fontSize: 16),
       ),
       centerTitle: true,
     ),
     body: RefreshIndicator(
       child: CustomScrollView(
         slivers: <Widget>[
           SliverPadding(
             padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
           ),
          FireAlarmListComponent(),
//           SliverPadding(
//             padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
//           ),
         ],
       ),
       onRefresh: () async {
         await Future.delayed(Duration(seconds: 2));
       },
     ),
   );
  }
}

class  FireAlarmListComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return StoreConnector <AppState, FireAlarmModel>(
            converter: (Store<AppState> store) {
              BuildingOwnerModel model = store.state.buildingOwnerModel;
              return FireAlarmModel(
               fireAlarmHistoryMessages: model.fireAlarmMessages,
                onRefreshCall: () async {
                  //todo 刷新回调
                  await Future.delayed(Duration(seconds: 2));
                },
              );
            },
            builder: (BuildContext context, FireAlarmModel vm) {
              List<Widget> viewList = <Widget>[];
              if (vm.fireAlarmHistoryMessages.length == 0) {
                viewList.add(ListTile(title: Text("当前无火警警报记录"),
                ));
              } else {
                viewList = vm.fireAlarmHistoryMessages.map<Widget>((FireAlarmMessage msg) {
                  return FireAlarmMessageCard(msg);
                }).toList();
              }
              return Column(
                children: viewList,
              );
            },
          );
        },
        childCount: 1,
      ),
    );
  }
}


class FireAlarmMessageCard extends StatelessWidget {

  final FireAlarmMessage msg;

  FireAlarmMessageCard(this.msg);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Card(
        elevation: 5,
        margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: ExpansionTile(
          key: PageStorageKey("${msg.id}"),
          leading: Icon(
            FontAwesomeIcons.fireAlt,
            color: Colors.grey,
          ),
          title: Text(
            msg.title,
            textAlign: TextAlign.start,
            style: TextStyle(
              color:Colors.grey,
              fontSize: 14,
            ),
          ),
          backgroundColor: Colors.white,
          initiallyExpanded: true,
          //默认是否展开
          children: <Widget>[
            Divider(
              color: Colors.black,
            ),
            ListTile(
              dense: true,
              title: Text(
                  "火警发生时间:   ${DateTime.now()}"),
            ),
            ListTile(
              dense: true,
              title: Text(
                  "具体内容:       ${msg.content}"),
            ),
          ],
        ),
      ),
    );
  }
}
