import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:ifcy/device_staff/device_staff.dart';
import 'package:ifcy/device_supervisor/device_supervisor.dart';
import 'package:ifcy/building_owner/building_owner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
export 'package:fluttertoast/fluttertoast.dart';

///@author ggq
///@description: 整个应用用到的一些工具，比如路由以及sp
///@date :2019/8/1 15:21
class Application {
  ///用来处理没有context时进行路由跳转
  static final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  ///路由跳转
  static Router router;
  ///全局的SharedPreferences
  static SharedPreferences prefs;
  ///后台的权限和前台的页面映射逻辑
  static Map<String, Widget> auth2view = {
    "MAINTAIN_MANAGER": BuildingOwner(), //维保主管
    // "MAINTAIN_MANAGER": DeviceSupervisor(), //维保主管
    "MAINTAIN_WORKER": DeviceStaff(), //维保工作人员
   // "OWNER":BuildingOwner(),//业主
  };

  ///封装的flutterToast的方法，使用方法一致
  static void showToast(String msg, {
    Toast toastLength,
    int timeInSecForIos = 1,
    double fontSize = 16.0,
    ToastGravity gravity,
    Color backgroundColor,
    Color textColor,
  }) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: toastLength,
        timeInSecForIos: timeInSecForIos,
        fontSize: fontSize,
        gravity: gravity,
        backgroundColor: backgroundColor,
        textColor: textColor);
  }

  //用来显示警示用的toast
  static void showWarnToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_LONG,);
  }
}
