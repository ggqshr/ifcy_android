import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ifcy/common/utils/utils.dart';
import 'package:ifcy/device_staff/device_staff.dart';
import 'package:ifcy/device_supervisor/device_supervisor.dart';
import 'package:ifcy/main_app/actions/main_app_actions.dart';
import 'package:ifcy/main_app/blocs/authorization/authorization_bloc.dart';
import 'package:ifcy/main_app/blocs/authorization/authorization_event.dart';
import 'package:ifcy/main_app/blocs/authorization/authorization_state.dart';
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
    return BlocBuilder<AuthorizationBloc,AuthorizationState>(
      // ignore: missing_return
      builder: (context, state) {
        if(state is Authenticated){
          return Scaffold(
            body: Application.auth2view[state.userEntity.roleType],
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
                          state.userEntity.realName[0]),
                    ),
                    accountName:
                    Text( state.userEntity.realName),
                    accountEmail: Text(""),
                  ),
                  ListTile(
                    title: Text("注销"),
                    onTap: (){
                      BlocProvider.of<AuthorizationBloc>(context).dispatch(LoginOut());
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
        }
      },
    );
  }
}
