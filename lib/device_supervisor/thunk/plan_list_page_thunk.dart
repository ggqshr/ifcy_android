///@author ggq
///@description: 计划列表页面的thunk
///@date :2019/8/21 19:00
part of 'device_supervisor_thunk.dart';

///初始化计划列表页面的异步action
///1.拉取当前项目所有的计划
///2.更新store中的数据
void initPlanListThunkAction(Store<AppState> store) async {
  Dio dio = DioUtils.getInstance().getDio();
  try {
    Response res = await dio.get(
        "/patrol/plan/project/${store.state.selectProjectModel.selectedProject.projectId}",
        queryParameters: {"list_rows": 1});
    PlanListPageModel model = PlanListPageModel.fromJson(res.data['data']);
    model.currentPageNum += 1; //第一页返回的num是0,所以需要加1
//    for (var build in model.planLists) {
//      build.currentBuild = store.state.deviceSupervisorModel.buildingList
//          .singleWhere((item) => item.buildId == build.currentBuild.buildId);
//    }
    store.dispatch(InitPlanListPageAction(model));
  } catch (e) {
    store.dispatch(DioUtils.getInstance().parseError2action(e));
  }
}

///加载下一页数据的异步函数
ThunkAction<AppState> planLoadMoreDataThunkAction(
    EasyRefreshController controller) {
  return (Store<AppState> store) async {
    controller.resetLoadState();
    Dio dio = DioUtils.getInstance().getDio();
    var model = store.state.deviceSupervisorModel.planPageModel;
    try {
      print(model.currentPageNum);
      if (model.currentPageNum != model.totalPageNum) {
        Response res = await dio.get(
            "/patrol/plan/project/${store.state.selectProjectModel.selectedProject.projectId}",
            queryParameters: {"page": model.currentPageNum + 1,"list_rows":1});
        PlanListPageModel mm = PlanListPageModel.fromJson(res.data['data']);
        store.dispatch(DeviceSuperVisorNextPageAction(mm));
        controller.finishLoad(success: true);
      } else {
        controller.finishLoad(success: true, noMore: true);
      }
    } catch (e) {
      controller.finishLoad(success: false);
      store.dispatch(DioUtils.getInstance().parseError2action(e));
    }
  };
}
