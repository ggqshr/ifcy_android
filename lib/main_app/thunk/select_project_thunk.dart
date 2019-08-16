///@author ggq
///@description: 选择项目页面的一些异步action
///@date :2019/8/16 11:29
part of "main_app_thunk.dart";

///更换项目的异步逻辑
///更换项目的逻辑有：
///1.更具项目的id更新当前用户在新的项目中的角色
///2.更新状态中的当前选择项目
///3.更新状态中的当前选择项目的index
///[thisProjectIndex]：要更改的项目的下标
ThunkAction<AppState> ChangeProjectThunkAction(int thisProjectIndex) {
  return (Store<AppState> store) async {
    Projects currentProject = store
        .state.selectProjectModel.projectList[thisProjectIndex]; //获取当前的下标对应的项目
    Dio dio = DioUtils.getInstance().getDio();
    dio.get("/user/projects/role/${currentProject.projectId}").then((res) {
      String thisAuth = res.data['data']['role_type'];
      store.dispatch(
          OnChangeProjectAction(currentProject, thisProjectIndex, thisAuth));
    }).catchError((err) {
      if (err.response != null) {
        store.dispatch(
            DioUtils.getInstance().parseResponse2action(err.response));
      }
    }).whenComplete(() {
      loadingDialogAction.cancleLoadingDialog(); //在结束时取消加载框
    });
  };
}
