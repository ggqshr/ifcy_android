import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ifcy/device_supervisor/device_supervisor.dart';
import 'package:ifcy/main_app/actions/main_app_actions.dart';
import 'package:ifcy/main_app/model/AppState.dart';
import 'package:ifcy/main_app/model/select_project_model.dart';
import 'package:ifcy/main_app/thunk/main_app_thunk.dart';
import 'package:ifcy/utils/loading.dart';
import 'package:redux/redux.dart';

class SelectProjectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SelectProjectModel>(
      converter: (Store<AppState> store) {
        return SelectProjectModel(
          selectedProject:
              store.state.projectList[store.state.currentProjectIndex],
          selectedProjectIndex: store.state.currentProjectIndex,
          projectList: store.state.projectList,
          onChangeCall: (v) {
            store.dispatch(
              OnChangeProject(v, store.state.projectList.indexOf(v),
                  store.state.project2Auth[v]),
            );
          },
          auth: store.state.currentAuth,
        );
      },
      builder: (BuildContext context, SelectProjectModel vm) {
        return Scaffold(
          appBar: AppBar(
            leading: DropdownButton(
              items: vm.projectList.map<DropdownMenuItem<String>>((i) {
                return DropdownMenuItem<String>(
                  value: i,
                  child: Text(i),
                );
              }).toList(),
              onChanged: (v) => vm.onChangeCall(v),
              value: vm.selectedProject,
            ),
          ),
          body: DeviceSupervisor(vm.auth),
        );
      },
    );
  }
}
