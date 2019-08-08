import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ifcy/main_app/model/AppState.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/services.dart';
import 'package:ifcy/common/components/components.dart';

class PersonPage extends StatelessWidget {
  final Function drawerCall;

  PersonPage(this.drawerCall);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:PersonelInfoComponent(),
        leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              drawerCall();
            }),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.navigate_next, color: Colors.grey),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PersonInfoPage()));
            },
          )
        ],
      ),
      body: Container(
        color: Colors.white70,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Divider(
              color: Colors.black87,
            ),
            Padding(
              child: ListTile(
                leading: Icon(
                  Icons.assignment_returned,
                  color: Colors.lightGreen,
//                  size: 20.0,
                ),
                title: Text('申报'),
                trailing: IconButton(
                    icon: Icon(Icons.navigate_next), onPressed: null),
              ),
              padding: EdgeInsets.fromLTRB(5.0, 1.0, 1.0, 1.0),
            ),
            Divider(
              color: Colors.black87,
            ),
            Padding(
              child: ListTile(
                leading: Icon(
                  Icons.assignment,
                  color: Colors.lightGreen,
//                  size: 20.0,
                ),
                title: Text('工作'),
                trailing: IconButton(
                    icon: Icon(Icons.navigate_next), onPressed: null),
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
//                  size: 20.0,
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
      child:  Row(
        children: <Widget>[
          SizedBox(
            child: CircleAvatar(
              child: IconButton(
                icon: Icon(
                  Icons.account_circle,
                  color: Colors.lightGreen,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PersonInfoPage()));
                },
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          SizedBox(
            child: Text(
              '哈哈哈哈哈',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
      margin:EdgeInsets.all(5.0),
    );
  }
}

