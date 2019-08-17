import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ifcy/common/utils/utils.dart';
import 'package:ifcy/device_staff/device_staff.dart';
import 'package:ifcy/device_supervisor/device_supervisor.dart';
import 'package:ifcy/main_app/actions/main_app_actions.dart';
import 'package:ifcy/main_app/model/AppState.dart';
import 'package:ifcy/main_app/model/select_project_model.dart';
import 'package:ifcy/main_app/thunk/main_app_thunk.dart';
import 'package:ifcy/common/utils/loading.dart';
import 'package:install_plugin/install_plugin.dart';
import 'package:path_provider/path_provider.dart';
import 'package:redux/redux.dart';
import 'package:permission_handler/permission_handler.dart';

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
            int thieIndex = store.state.selectProjectModel.projectList
                .indexWhere((item) => item.projectName == v);
            store.dispatch(
              ChangeProjectThunkAction(thieIndex),
            );
          },
          auth: store.state.selectProjectModel.auth,
        );
      },
      builder: (BuildContext context, SelectProjectModel vm) {
        return Scaffold(
          body: Application.auth2view[vm.auth],
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.all(0),
              children: <Widget>[
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.green[300],
                  ),
                  currentAccountPicture: CircleAvatar(
                    child: Text(
                        StoreProvider.of<AppState>(context).state.userName[0]),
                  ),
                  accountName:
                      Text(StoreProvider.of<AppState>(context).state.userName),
                  accountEmail: Text(""),
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
                        String groupValue = vm.selectedProject.projectName;
                        return AlertDialog(
                          title: Text("切换项目"),
                          content: StatefulBuilder(
                            builder: (context, state) {
                              return Column(
                                children:
                                    vm.projectList.map<RadioListTile>((i) {
                                  return RadioListTile<String>(
                                    title: Text(i.projectName),
                                    value: i.projectName,
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
                                if (vm.selectedProject != groupValue) {
                                  vm.onChangeCall(groupValue);
                                }
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                if (vm.selectedProject != groupValue) {
                                  loadingDialogAction
                                      .showLoadingDialog("切换项目中..");
                                }
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                ListTile(
                  title: Text("升级app"),
                  onTap: () async {
                    PermissionStatus permission = await PermissionHandler()
                        .checkPermissionStatus(PermissionGroup.storage); //请求权限
                    if (permission == PermissionStatus.denied) {
                      Map<PermissionGroup, PermissionStatus> permissions =
                          await PermissionHandler()
                              .requestPermissions([PermissionGroup.storage]);
                    }
                    Directory appDocDir =
                        await getExternalStorageDirectory(); //获取app数据存储地址
                    final taskId = await FlutterDownloader.enqueue(
                      //下载app
                      url: 'http://116.56.140.194/2.apk',
                      savedDir: appDocDir.path,
                      showNotification: true,
                      // show download progress in status bar (for Android)
                      openFileFromNotification:
                          true, // click on notification to open downloaded file (for Android)
                    );
                    FlutterDownloader.registerCallback(//设置回调
                        (taskId, status, progress) async {
                      if (status == DownloadTaskStatus.complete) {
                        InstallPlugin.installApk(
                                //下载完成后，启动更新
                                appDocDir.path + "/2.apk",
                                "com.example.ifcy")
                            .then((e) {
                          print("install $e");
                        });
                      }
                    });
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
