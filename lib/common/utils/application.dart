import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:ifcy/device_staff/device_staff.dart';
import 'package:ifcy/device_supervisor/device_supervisor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

///@author ggq
///@description: 整个应用用到的一些工具，比如路由以及sp
///@date :2019/8/1 15:21
class Application {
  static Router router;
  static SharedPreferences prefs;
  static Map<String, Widget> auth2view = {
    "MAINTAIN_MANAGER": DeviceSupervisor(), //维保主管
    "MAINTAIN_WORKER": DeviceStaff(), //维保工作人员
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
}
