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
          selectedProject: store.state.selectProjectModel.selectedProject,
          selectedProjectIndex:
              store.state.selectProjectModel.selectedProjectIndex,
          projectList: store.state.selectProjectModel.projectList,
          onChangeCall: (v) {
            store.dispatch(
              OnChangeProject(
                  v,
                  store.state.selectProjectModel.projectList.indexOf(v),
                  store.state.project2Auth[v]),
            );
          },
          auth: store.state.selectProjectModel.auth,
        );
      },
      builder: (BuildContext context, SelectProjectModel vm) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: DropdownButton(
              items: ["大厦1", "大厦2"].map((i) {
                return DropdownMenuItem<String>(
                  value: i,
                  child: Text(i),
                );
              }).toList(),
              onChanged: (v) {},
              value: "大厦1",
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: DropdownButton(
                  items: vm.projectList.map<DropdownMenuItem<String>>((i) {
                    return DropdownMenuItem<String>(
                      value: i,
                      child: Text(i),
                    );
                  }).toList(),
                  onChanged: (v) => vm.onChangeCall(v),
                  value: vm.selectedProject,
                ),
              )
            ],
          ),
          body: DeviceSupervisor(vm.auth),
        );
      },
    );
  }
}
