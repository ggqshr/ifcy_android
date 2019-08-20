///@author ggq
///@description: 发起计划页面的一些thunk
///@date :2019/8/19 18:10

part of 'device_supervisor_thunk.dart';

///获取新增任务页面需要的数据
///1.根据store中的建筑循环获取所有建筑的所有楼层信息
///2.根据项目获取当前的所有人员信息
///3.获取当前所有的检查系统信息
void initAddTaskData(Store<AppState> store) async {
  //跳过所有建筑
  List<Build> allBuilding = store.state.deviceSupervisorModel.buildingList;
  try {
    Dio dio = DioUtils.getInstance().getDio();
    //获取楼层信息
    for (var i in allBuilding.skip(1)) {
      Response res = await dio.get("/building/${i.buildId}");
      i.floors = res.data['data']['floors']
          .map<FloorEntity>((item) => FloorEntity.fromJson(item))
          .toList();
    }
    //获取人员信息
    Response res = await dio.get(
        "/project/${store.state.selectProjectModel.selectedProject.projectId}/users/role/MAINTAIN_WORKER");
    List<PersonnelMessage> personList = res.data['data']
        .map<PersonnelMessage>((item) => PersonnelMessage.fromJson(item))
        .toList();
    Response rse = await dio.get("/patrol/check-systems");
    List<InspectionSystem> inspectionSystems = rse.data['data']
        .map<InspectionSystem>((item) => InspectionSystem.fromJson(item))
        .toList();
    store.dispatch(
        AddTaskPageInitAction(allBuilding, inspectionSystems, personList));
  } catch (e) {
    print(e);
    store.dispatch(DioUtils.getInstance().parseError2action(e));
  }
}
