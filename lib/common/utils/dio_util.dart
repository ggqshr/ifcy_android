///@author ggq
///@description: 统一的网络请求类
///@date :2019/8/14 14:39
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ifcy/common/res/res.dart';
import 'package:ifcy/common/utils/utils.dart';
import 'package:ifcy/device_supervisor/model/device_supervisor_model.dart';
import 'package:ifcy/main_app/actions/main_app_actions.dart';
import 'package:ifcy/main_app/blocs/error_process_delegate.dart';

/// 封装的DIO工具类，封装了dio的拦截器，能够在请求失败的情况下自动请求刷新token并将之前的请求结果返回
/// 对于错误处理的逻辑也有封装，如果请求出错，那么使用封装的函数就会返回对应的action
/// 服务器端实现的逻辑为：只有状态吗为200的请求是正确的请求，除了200以外的响应都是问题响应，
/// 而如果响应的状态码不是200，那么就会
class DioUtils {
  static Dio _dio;
  static final String baseUrl =
      "http://116.56.140.193/business/app/api/"; //基础url
  final int connectTimeOut = 200000; //连接超时时间
  final int receiveTimeOut = 100000; //接收超时时间
  String _authTokenHeader; //验证需要的token
  final String getImageUrl = "http://116.56.140.193/business/sys/stand/img/"; //拿去图片的地址

  static DioUtils _dioUtils;

  DioUtils._() {
    _dio = _initDio();
  }

  factory DioUtils.getInstance() {
    if (_dioUtils == null) {
      _dioUtils = DioUtils._();
    }
    return _dioUtils;
  }

  //初始化Dio单例
  Dio _initDio() {
    Dio dio = Dio(
      BaseOptions(
        connectTimeout: connectTimeOut,
        receiveTimeout: receiveTimeOut,
        baseUrl: baseUrl,
        contentType: ContentType.json.value,
      ),
    );
    (dio.transformer as DefaultTransformer).jsonDecodeCallback =
        parseJson; //将解析json的工作放入后台
    // ignore: missing_return
    dio.interceptors.add(InterceptorsWrapper(onError: (error) async {
      if (error.response != null &&
          error.response.statusCode == 400 &&
          (error.response.data['code'] == '100001' ||
              error.response.data['code'] == '100002' ||
              error.response.data['code'] == '100003')) {
        Dio dio = DioUtils.getInstance().getDio();
        dio.lock();
        String token = await _getToken();
        if (token.isNotEmpty) {
          setToken(token); //如果成功，就刷新当前的token
          dio.unlock();
        } else {
          //如果不成功，同样解锁，然后返回一个应该重新登陆的action;
          dio.unlock();
          return DioError(error: ShouldReLoginError());
        }
        var request = error.response.request;
        request.headers['authorization'] = token;
        try {
          var response = await dio.request(
            request.path,
            data: request.data,
            queryParameters: request.queryParameters,
            cancelToken: request.cancelToken,
            options: request,
            onReceiveProgress: request.onReceiveProgress,
          );
          return response;
        } on DioError catch (e) {
          return e;
        }
      }
    }));
//    dio.interceptors
//        .add(LogInterceptor(responseBody: true, requestBody: true)); //开启日志
    return dio;
  }

  //获取单例dio
  Dio getDio() {
    return _dio;
  }

  void resetDio() {
    _dio = _initDio();
  }

  //获取一个新的dio实例
  Dio getNewDIo() {
    return Dio()
      ..options.baseUrl = baseUrl
      ..interceptors.add(LogInterceptor(requestBody: true, responseBody: true))
      ..options.contentType = ContentType.json.value;
  }

  //获取tokenl
  Future<String> getToken() async {
    Response res = await _dio.post("/anonymous/validate-token");
    return _authTokenHeader;
  }

  //设置token
  setToken(String token) {
    _authTokenHeader = token;
    _dio.options.headers['authorization'] = _authTokenHeader;
  }

  // 从服务器获取新的token
  Future<String> _getToken() async {
    String token;
    String userName = await Auth.getInstance().getString(USER_NAME);
    String passWord = await Auth.getInstance().getString(PASS_WORD);
    try {
      Response response = await _login(userName, passWord);
      token = response.headers.value("authorization");
    } on DioError catch (e) {
      if (e.response == null) {
        print("DioError ${e.message}");
      }
    }
    return token ?? "";
  }

  //封装的登陆逻辑
  Future<Response> login(String userName, String passWord) async {
    Response res = await _login(userName, passWord);
    setToken(res.headers.value("authorization"));
    return res;
  }

  //将响应转化为对应的action
  InternetAction parseResponse2action(Response res) {
    print(res);
    if (res.data['code'] == '000000') {
      //成功
      return SuccessAction.fromResponse(res);
    } else if (res.data['code'] == '110001') {
      //用户未登录
      return IncorrectUserErrorAction.fromResponse(res);
    } else if (res.data['code'] == '999999') {
      //服务器内部错误
      return InternalErrorAction.fromResponse(res);
    } else if (res.data['code'] == '110002') {
      //空的用户名密码
      return EmptyUserFieldAction.fromResponse(res);
    }
    return UnknownErrorAction.fromResponse(res);
  }

  //封装的登陆接口
  Future<Response> _login(String userName, String passWord) async {
    return getNewDIo().post("/anonymous/login",
        data: '{"password": "$passWord", "username": "$userName"}');
  }

  ///提交任务的接口封装
  Future<Response> submitTask(AddTaskBlocModel model) {}
}

_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}
