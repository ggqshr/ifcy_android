import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:ifcy/utils/StoreCreater.dart';
import 'model/device_supervisor_model.dart';
import 'device_supervisor_redux.dart';

class DeviceSupervisor extends StatefulWidget {
  @override
  _DeviceSupervisorState createState() => _DeviceSupervisorState();
}

class _DeviceSupervisorState extends State<DeviceSupervisor> {
  Store<DeviceSupervisorModel> _store;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _store = createStoreWithmiddleware(deviceSupervisorMoudle1Reducer,
        DeviceSupervisorModel(), null); //初始化store
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
