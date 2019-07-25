import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ifcy/device_supervisor/device_supervisor.dart';
import 'package:ifcy/main_app/actions/main_app_actions.dart';
import 'package:ifcy/main_app/model/AppState.dart';
import 'package:ifcy/main_app/model/select_project_model.dart';
import 'package:ifcy/main_app/thunk/main_app_thunk.dart';
import 'package:ifcy/common//utils/loading.dart';
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
          body: DeviceSupervisor(vm.auth),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.all(0),
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                  ),
                  child: Center(
                    child: SizedBox(
                      child: CircleAvatar(
                        child: Text("G"),
                      ),
                    ),
                  ),
                ),
                ListTile(
                  leading: Tooltip(
                    child: Icon(Icons.change_history),
                    message: "切换项目",
                  ),
                  title: Text("切换项目"),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        String groupValue = vm.selectedProject;
                        return AlertDialog(
                          title: Text("切换项目"),
                          content: StatefulBuilder(
                            builder: (context, state) {
                              return Column(
                                children:
                                    vm.projectList.map<RadioListTile>((i) {
                                  return RadioListTile<String>(
                                    title: Text(i.toString()),
                                    value: i.toString(),
                                    onChanged: (v) {
                                      state(() => groupValue = v);
                                    },
                                    groupValue: groupValue,
                                  );
                                }).toList(),
                                mainAxisSize: MainAxisSize.min,
                              );
                            },
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("返回"),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            FlatButton(
                              child: Text("切换"),
                              onPressed: () {
                                if (vm.selectedProject != groupValue){
                                  vm.onChangeCall(groupValue);
                                }
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                if (vm.selectedProject != groupValue){
                                  loadingDialogAction.showLoadingDialog("切换项目中..");
                                }
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
//                ListTile(
//                  title: Text("升级app"),
//                  onTap: ()async {
//                    bool res = await SimplePermissions.checkPermission(Permission.WriteExternalStorage);
//                    if(!res){
//                      await SimplePermissions.requestPermission(Permission.WriteExternalStorage);
//                      await SimplePermissions.requestPermission(Permission.Camera);
//                    }
//                  },
//                )
              ],
            ),
          ),
        );
      },
    );
  }
}
