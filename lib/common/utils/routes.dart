import 'package:fluro/fluro.dart';
import 'package:ifcy/main_app/main_app.dart';
import 'package:ifcy/main_app/pages/select_project_page.dart';

///@author ggq
///@description: 路由
///@date :2019/8/1 15:00
class Routes {
  static String root = "/";
  static String test = "/test/:a"; //支持两种路由参数设置方式
  static String test1 = "/test"; //可以按照网页的参数写 /test?a=1&b=2，在Handler中都能处理
  static String selectPage = "/select";

  static void configureRoutes(Router router) {
    router.define(test, handler: testHandler);
    router.define(selectPage, handler: selectHandler);
  }
}

var testHandler = Handler(
  handlerFunc: (context, Map<String, List<String>> params) {
    print(params.values);
    String a = params["a"].first;
    String b = params["b"].first;
    return TestPage(a, b);
  },
);

var selectHandler =
    Handler(handlerFunc: (context, Map<String, List<String>> params) {
  return SelectProjectPage();
});
