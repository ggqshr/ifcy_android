import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ifcy/main_app/model/AppState.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/services.dart';
import 'package:ifcy/common/components/components.dart';
import 'package:fluro/fluro.dart';
import 'package:ifcy/common/utils/application.dart';
import 'package:ifcy/common/utils/routes.dart';
import 'package:ifcy/device_supervisor/pages/device_supvisor_pages.dart';

class PersonPage extends StatelessWidget {
  final Function drawerCall;

  PersonPage(this.drawerCall);



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
//        leading: IconButton(
//            icon: Icon(Icons.menu),
//            onPressed: () {
//              drawerCall();
//            }),
//        actions: <Widget>[
//          IconButton(
//      icon: Icon(Icons.navigate_next, color: Colors.grey),
//      onPressed: () {
//        Navigator.push(context,
//            MaterialPageRoute(builder: (context) => PersonInfoPage()));
//      },
//    )
//        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Theme(
            data: Theme.of(context).copyWith(accentColor: Colors.white),
            child: Container(
              margin: EdgeInsets.fromLTRB(15.0, 5, 0, 25),
              height: 48.0,
              alignment: Alignment.center,
              child: PersonelInfoComponent(),
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.white70,
        child: Column(
          children: <Widget>[
            Padding(
              child: ListTile(
                leading: Icon(
                  Icons.assignment_returned,
                  color: Colors.lightGreen,
                ),
                title: Text('申报'),
                trailing: IconButton(
                    icon: Icon(Icons.navigate_next),
                  onPressed:(){
                    Navigator.push(context, new MaterialPageRoute(builder: (context)=>new FaultDeclarePage(this.drawerCall)),);
                  },
                ),
                onTap: (){
                  Navigator.push(context, new MaterialPageRoute(builder: (context)=>new FaultDeclarePage(this.drawerCall)),);
                },
              ),
              padding: EdgeInsets.fromLTRB(5.0, 8.0, 1.0, 1.0),
            ),
            Divider(
              color: Colors.black87,
            ),
            Padding(
              child: ListTile(
                leading: Icon(
                  Icons.assignment,
                  color: Colors.lightGreen,
                ),
                title: Text('工作'),
                trailing: IconButton(
                    icon: Icon(Icons.navigate_next),
                ),
              ),
              padding: EdgeInsets.fromLTRB(5.0, 1.0, 1.0, 1.0),
            ),
            Divider(
              color: Colors.black87,
            ),
            Padding(
              child: ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Colors.lightGreen,
                ),
                title: Text('设置'),
                trailing: IconButton(
                    icon: Icon(Icons.navigate_next), onPressed: null),
              ),
              padding: EdgeInsets.fromLTRB(5.0, 1.0, 1.0, 1.0),
            ),
            Divider(
              color: Colors.black87,
            ),
          ],
        ),
      ),
    );
  }
}

class PersonelInfoComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: CircleAvatar(
          child: IconButton(
            icon: Icon(
              Icons.account_circle,
              color: Colors.blue,
            ),
          ),
        ),
        title: Text(
          '哈哈哈哈哈',
          style: TextStyle(fontSize: 16.0),
        ),
        trailing: IconButton(
          icon: Icon(Icons.navigate_next, color: Colors.grey),
          onPressed: () {
            Application.router.navigateTo(
                context, '/personalInfo/:id',//跳转路径
                transition: TransitionType.inFromRight//过场效果
            );
          },
        ),
        onTap: () {
          Application.router.navigateTo(
              context, '/personalInfo/:id',//跳转路径
              transition: TransitionType.inFromRight//过场效果
          );
        },
      ),
    );
  }
}
