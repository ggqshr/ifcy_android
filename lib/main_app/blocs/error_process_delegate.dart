import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ifcy/common/utils/utils.dart';
import 'package:ifcy/main_app/blocs/authorization/authorization_bloc.dart';
import 'package:ifcy/main_app/blocs/authorization/authorization_event.dart';

///@author ggq
///@description:
///@date :2019/8/25 19:23
class ErrorProcessDelegate extends BlocDelegate {
  AuthorizationBloc bloc;

  ErrorProcessDelegate(this.bloc);

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    if (error is DioError) {
      if (error.error is ShouldReLoginError) {
        Application.showWarnToast("重新登陆");
//        Application.navigatorKey.currentState.pushAndRemoveUntil(
//            MaterialPageRoute(builder: (context) => LoginPage()),
//            ModalRoute.withName("/ll"));
        this.bloc.add(ShouldReLogin());
        return;
      }
      switch (error.type) {
        case DioErrorType.CONNECT_TIMEOUT:
          Application.showWarnToast("连接超时！！请检查网络");
          break;
        case DioErrorType.SEND_TIMEOUT:
          Application.showWarnToast(
            "发送超时！！请稍候重试",
          );
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          Application.showWarnToast(
            "接收超时！！请稍候重试",
          );
          break;
        case DioErrorType.RESPONSE:
          try{
            var res = error.response;
            var code = res.data['code'];
            var msg = res.data['msg'];
            var statusCode = res.statusCode;
            if (code == '110001') {
              //用户未登录
              Application.showWarnToast("用户名密码不正确 $code $msg $statusCode");
            } else if (code == '999999') {
              //服务器内部错误
              Application.showWarnToast("服务器内部错误 $code $msg $statusCode");
            } else if (code == '110002') {
              //空的用户名密码
              Application.showWarnToast("空的用户名或者密码 $code $msg $statusCode");
            }
          }catch(e){
            Application.showWarnToast("未知错误!!");
          }
          break;
        default:
          print("Unknown Error $error");
          break;
      }
    } else {
      print(error);
      print(stacktrace);
      Application.showWarnToast("错误${error.toString()}");
    }
    super.onError(bloc, error, stacktrace);
  }

  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

class ShouldReLoginError extends Error {}
