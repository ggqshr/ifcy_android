import 'package:flutter/material.dart';
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
    return Container(
      child: Center(
        child: Text("current auth is ${widget.auth}"),
      ),
    );
  }
}
