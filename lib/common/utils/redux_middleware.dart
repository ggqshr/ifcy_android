///@author ggq
///@description: redux的中间件，用来处理错误和其他问题
///@date :2019/8/18 16:04

import 'package:ifcy/main_app/actions/main_app_actions.dart';
import 'package:ifcy/main_app/pages/login_page.dart';
import 'utils.dart';
import 'package:redux/redux.dart';
import 'package:flutter/material.dart';

class ErrorMiddleware<State> extends MiddlewareClass<State> {
  @override
  void call(Store<State> store, dynamic action, NextDispatcher next) {
    //如果是错误类型的action
    if (action is IfcyErrorAction) {
      //如果是网络类型的错误
      if (action is InternetAction) {
        reactToInternetErrorReducer(null, action);
        //网络错误类的都需要继续传递
        next(action);
      } else if (action is ErrorAction) {
        print(action);
        Application.showWarnToast("错误${action.msg}");
      } else if (action is ShouldReLoginAction) {
        //跳转登陆页面
        Application.showWarnToast("重新登陆");
        Application.navigatorKey.currentState.pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginPage()),
            ModalRoute.withName("/ll"));
      }
    } else {
      next(action);
    }
  }

  ErrorMiddleware();
}

///用来显示出错时提示的函数
Reducer<void> reactToInternetErrorReducer = combineReducers([
  TypedReducer<void, InternalErrorAction>(
    (_, action) => Application.showWarnToast(
        "服务器内部错误 ${action.code} ${action.msg} ${action.statusCode}"),
  ),
  TypedReducer<void, EmptyUserFieldAction>(
    (_, action) => Application.showWarnToast(
        "空的用户名或者密码 ${action.code} ${action.msg} ${action.statusCode}"),
  ),
  TypedReducer<void, IncorrectUserErrorAction>(
    (_, action) => Application.showWarnToast(
        "用户名密码不正确 ${action.code} ${action.msg} ${action.statusCode}"),
  ),
  TypedReducer<void, UnknownErrorAction>(
    (_, action) => Application.showWarnToast(
      "未知错误 ${action.code} ${action.msg} ${action.statusCode}",
    ),
  ),
  TypedReducer<void, ConnectTimeOutErrorAction>(
    (_, action) => Application.showWarnToast(
      "连接超时！！请检查网络",
    ),
  ),
  TypedReducer<void, ReceiveTimeOutErrorAction>(
    (_, action) => Application.showWarnToast(
      "接收超时！！请稍候重试",
    ),
  ),
  TypedReducer<void, SendTimeOutErrorAction>(
    (_, action) => Application.showWarnToast(
      "发送超时！！请稍候重试",
    ),
  ),
]);
