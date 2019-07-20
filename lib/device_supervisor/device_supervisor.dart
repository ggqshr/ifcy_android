import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:redux/redux.dart';
import 'package:ifcy/utils/StoreCreater.dart';
import 'model/device_supervisor_model.dart';
import 'device_supervisor_redux.dart';

class DeviceSupervisor extends StatefulWidget {
  String auth;

  DeviceSupervisor(this.auth);

  @override
  _DeviceSupervisorState createState() => _DeviceSupervisorState();
}

class _DeviceSupervisorState extends State<DeviceSupervisor> {
//  Store<DeviceSupervisorModel> _store;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text("建筑"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.warning),
            title: Text("故障"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            title: Text("任务"),
          ),
          BottomNavigationBarItem(
            icon: Badge(child: Icon(Icons.person_outline),badgeContent: Text("2"),),
            title: Text("我的"),
          ),
        ],
      ),
      body: Container(
        child: Center(
          child: Text("current auth is ${widget.auth}"),
        ),
      ),
    );
  }
}
