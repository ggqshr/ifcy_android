import 'package:fluttertoast/fluttertoast.dart';
import 'package:ifcy/building_owner/building_owner.dart';
import 'package:ifcy/device_staff/device_staff.dart';
import 'package:ifcy/device_supervisor/device_supervisor.dart';
import 'package:ifcy/property_manager/property_manager.dart';
import 'package:ifcy/property_worker/property_worker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

export 'package:fluttertoast/fluttertoast.dart';

///@author ggq
///@description: 整个应用用到的一些工具，比如路由以及sp
///@date :2019/8/1 15:21
class Application {
  ///用来处理没有context时进行路由跳转
  static final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();


  ///全局的SharedPreferences
  static SharedPreferences prefs;

  ///后台的权限和前台的页面映射逻辑
  static Map<String, Widget> auth2view = {
    "MAINTAIN_MANAGER": DeviceSupervisor(), //维保主管
    "MAINTAIN_WORKER": DeviceStaff(), //维保工作人员
    "OWNER": BuildingOwner(), //业主
    "PROPERTY_MANAGER": PropertyManager(), //物业主管
    "PROPERTY_WORKER": PropertyWorker() //物业工作人员
  };

  static Map<String, String> auth2string = {
    "MAINTAIN_MANAGER": "维保主管", //维保主管
    "MAINTAIN_WORKER": "维保工作人员", //维保工作人员
    "OWNER": "业主", //业主
    "PROPERTY_MANAGER": "物业主管", //物业主管
    "PROPERTY_WORKER": "物业工作人员" //物业工作人员
  };

  ///封装的flutterToast的方法，使用方法一致
  static void showToast(
    String msg, {
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
      toastLength: Toast.LENGTH_LONG,
    );
  }
}
