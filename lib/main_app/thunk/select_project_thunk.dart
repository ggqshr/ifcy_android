///@author ggq
///@description: 选择项目页面的一些异步action
///@date :2019/8/16 11:29
part of "main_app_thunk.dart";

///更换项目的异步逻辑
///更换项目的逻辑有：
///1.更具项目的id更新当前用户在新的项目中的角色
///2.更新状态中的当前选择项目
///3.更新状态中的当前选择项目的index
ThunkAction<AppState> ChangeProjectThunkAction(int thisProjectIndex) {
  return (Store<AppState> store) async {

  };
}
