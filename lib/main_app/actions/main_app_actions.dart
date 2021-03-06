import 'package:dio/dio.dart';
import 'package:ifcy/main_app/model/AppState.dart';

class LoginSuccessAction {
  String userName;
  String companyName;
  int userId;
  List projectList;
  int currentProIndex;
  String auth;

  LoginSuccessAction({
    this.userName,
    this.projectList,
    this.currentProIndex,
    this.userId,
    this.companyName,
    this.auth,
  });
}

class ChangeAlertAction {
  String alertText;

  ChangeAlertAction(this.alertText);
}

class OnChangeProjectAction {
  Projects selectedProject;
  int index;
  String auth;

  OnChangeProjectAction(this.selectedProject, this.index, this.auth);
}

///ifcy项目的所有错误action的基类
abstract class IfcyErrorAction {}

//网络错误的基类
abstract class InternetAction extends IfcyErrorAction {
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

// 未知错误
class UnknownErrorAction extends InternetAction {
  UnknownErrorAction({statusCode, msg, code})
      : super(statusCode: statusCode, msg: msg, code: code);

  UnknownErrorAction.fromResponse(Response res) : super.fromResponse(res);
}

//需要重新登陆的action
class ShouldReLoginAction extends IfcyErrorAction {}

///错误的action
class ErrorAction extends IfcyErrorAction {
  String msg;
  String trace;

  ErrorAction.fromError(Error err)
      : msg = err.toString(),
        trace = err.stackTrace.toString();

  @override
  String toString() {
    return 'ErrorAction{msg: $msg, trace: $trace}';
  }
}

///连接超时的错误action
class ConnectTimeOutErrorAction extends InternetAction {}

///接收超时的错误action
class ReceiveTimeOutErrorAction extends InternetAction {}

///发送超时的错误action
class SendTimeOutErrorAction extends InternetAction {}
