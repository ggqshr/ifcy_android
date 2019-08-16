part of "main_app_thunk.dart";

///登陆的逻辑，先根据用户名密码登陆，获取token，然后根据token获取用户参与的项目
///以及每个项目用户的角色，
ThunkAction<AppState> loginSubmitAction(
    String userName, String passWord, Function navigatorCall) {
  return (Store<AppState> store) async {
    Dio dio = DioUtils.getInstance().getDio(); //获取实例
    InternetAction res =
        await DioUtils.getInstance().login(userName, passWord); //获取登陆结果
    if (res is SuccessAction) {
      //如果登陆成功
      await Auth.getInstance().save(userName, passWord); //将内容缓存起来
      try {
        Response userInfo = await dio.get("/user"); //获取用户信息
        Response projects = await dio.get("/user/projects"); //获取用户参与的所有项目
        Response auth = await dio
            .get("/user/projects/role/${projects.data['data'][0]['id']}");
        store.dispatch(
          LoginSuccessAction(
            userId: int.parse(userInfo.data['data']['id']),
            userName: userInfo.data['data']['username'],
            companyName: userInfo.data['data']['company_name'],
            projectList: projects.data['data']
                .map((item) => Projects.fromMap(item))
                .toList(),
            currentProIndex: 0,
            auth: auth.data['data']['role_type'],
          ),
        );
        loadingDialogAction.cancleLoadingDialog();
        navigatorCall(); //跳转路由
      } on DioError catch (e) {
        if (e.response != null) {
          store.dispatch(
              DioUtils.getInstance().parseResponse2action(e.response));
          loadingDialogAction.cancleLoadingDialog();
        }
      }
    } else {
      store.dispatch(res);
      loadingDialogAction.cancleLoadingDialog();
    }
    store.dispatch(InitDeviceSupervisorStateAction.init());
    store.dispatch(InitDeviceStaffStateAction.init());
  };
}
