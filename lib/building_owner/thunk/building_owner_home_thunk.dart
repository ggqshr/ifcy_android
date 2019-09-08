///@author lc
///@description: 业主主页面的thunkaction文件
///@date :2019/8/17 14:54
///
part of "building_owner_thunk.dart";

///初始化建筑物列表的异步action
///1.根据当前所选的项目，拿取建筑列表
///2.根据获取的建筑列表，统计一个所有建筑，然后将建筑列表放入到状态
///3.初始化时默认的建筑为所有建筑
void initOwnerBuildList(Store<AppState> store) async {
  Projects thisProject = store.state.selectProjectModel.selectedProject;
  Dio dio = DioUtils.getInstance().getDio();
  dio.get("/building/project/${thisProject.projectId}").then((res) {
    List<Build> buildList = [Build(buildId: null, buildName: "所有建筑")]
      ..addAll(res.data['data'].map<Build>((item) => Build.fromMap(item)));

    print(buildList);

    store.dispatch(InitOwnerPageAppBarBuildingList (
        buildingList: buildList, currentBuilding: buildList[0]));
    //todo 拉取首页消息
    store.dispatch(InitOwnerPageStateAction.init());

  }).catchError((err) {
    if (err is! DioError) {
      store.dispatch(ErrorAction.fromError(err));
    }
    if (err.response != null) {
      store.dispatch(err.response);
    }
  }).whenComplete(() {});
}

///切换建筑的异步action
///1.根据变更的建筑，body部分更新和建筑相关的数据
///2.变更当前状态中的选中建筑
ThunkAction<AppState> onChangeOwnerBuildingThunkAction(Build checkedBuilding) {
  return (Store<AppState> store) async {
    store.dispatch(
        BuildingOwnerChangeBuildAction(changedBuilding: checkedBuilding));
  };
}