import 'package:dio/dio.dart';

class LoginSuccessAction {
  String userName;
  List projectList;
  Map project2Auth;
  int currentProIndex;

  LoginSuccessAction(
    this.userName,
    this.projectList,
    this.project2Auth,
    this.currentProIndex,
  );
}

class ChangeAlertAction {
  String alertText;

  ChangeAlertAction(this.alertText);
}

class OnChangeProject {
  String selectedProject;
  int index;
  String auth;

  OnChangeProject(this.selectedProject, this.index, this.auth);
}

//网络错误的基类
class InternetAction {
  final int statusCode; //状态码
  final String msg; //服务器返回的msg
  final String code; //服务器返回的code

  InternetAction({this.statusCode, this.msg, this.code}); //服务器返回的code

  InternetAction.fromResponse(Response res)
      : statusCode = res.statusCode,
        code = res.data['code'],
        msg = res.data['msg'];
}

//请求成功，携带数据
class SuccessAction<T> extends InternetAction {
  final T data;

  SuccessAction({this.data, statusCode, msg, code})
      : super(statusCode: statusCode, msg: msg, code: code);

  SuccessAction.fromResponse(Response res)
      : data = res.data,
        super.fromResponse(res);
}

//服务器内部错误error
class InternalErrorAction extends InternetAction {
  InternalErrorAction({statusCode, msg, code})
      : super(statusCode: statusCode, msg: msg, code: code);

  InternalErrorAction.fromResponse(Response res) : super.fromResponse(res);
}

//不正确的用户名或密码
class IncorrectUserErrorAction extends InternetAction {
  IncorrectUserErrorAction({statusCode, msg, code})
      : super(statusCode: statusCode, msg: msg, code: code);

  IncorrectUserErrorAction.fromResponse(Response res) : super.fromResponse(res);
}

// 用户名和密码为空
class EmptyUserFieldAction extends InternetAction {
  EmptyUserFieldAction({statusCode, msg, code})
      : super(statusCode: statusCode, msg: msg, code: code);

  EmptyUserFieldAction.fromResponse(Response res) : super.fromResponse(res);
}

//需要重新登陆的action
class ShouldReLoginAction {

}
