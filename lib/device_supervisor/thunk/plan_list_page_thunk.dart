///@author ggq
///@description: 计划列表页面的thunk
///@date :2019/8/21 19:00
part of 'device_supervisor_thunk.dart';

///初始化计划列表页面的异步action
///1.拉取当前项目所有的计划
///2.更新store中的数据
void initPlanListThunkAction(Store<AppState> store) async {
    Dio dio = DioUtils.getInstance().getDio();

}
