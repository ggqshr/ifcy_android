import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:ifcy/common/utils/utils.dart';
import 'package:ifcy/main_app/blocs/authorization/authorization_bloc.dart';
import 'package:ifcy/main_app/blocs/authorization/authorization_event.dart';
import 'package:ifcy/main_app/blocs/authorization/authorization_state.dart';
import 'package:install_plugin/install_plugin.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class SelectProjectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthorizationBloc, AuthorizationState>(
      // ignore: missing_return
      builder: (context, state) {
        if (state is Authenticated) {
          return Scaffold(
            body: Application.auth2view[state.userEntity.roleType],
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.all(0),
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(192, 47, 47,1),
                    ),
                    currentAccountPicture: CircleAvatar(
                      child: Text(state.userEntity.realName[0]),
                      backgroundColor: Colors.white,
                    ),
                    accountName: Text(state.userEntity.realName),
                    accountEmail: Text(
                        "当前身份为${Application.auth2string[state.userEntity.roleType]}"),
                  ),
                  ListTile(
                    title: Text("注销"),
                    onTap: () {
                      BlocProvider.of<AuthorizationBloc>(context)
                          .add(LoginOut());
                    },
                  ),
                  Divider(color:Colors.black),
                  ListTile(
                    title: Text("升级app"),
                    onTap: () async {
                      PermissionStatus permission = await PermissionHandler()
                          .checkPermissionStatus(
                              PermissionGroup.storage); //请求权限
                      if (permission == PermissionStatus.denied) {
                        Map<PermissionGroup, PermissionStatus> permissions =
                            await PermissionHandler()
                                .requestPermissions([PermissionGroup.storage]);
                      }
                      Directory appDocDir =
                          await getExternalStorageDirectory(); //获取app数据存储地址
                      final taskId = await FlutterDownloader.enqueue(
                        //下载app
                        url: 'http://47.107.231.51/ifcy.apk',
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
                                  appDocDir.path + "/ifcy.apk",
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
