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
  List<Build> allBuilding =
      store.state.deviceSupervisorModel.buildingList;
  try {
    Dio dio = DioUtils.getInstance().getDio();
    //获取楼层信息
    for (var i in allBuilding.skip(1)) {
      Response res = await dio.get("/building/${i.buildId}");
      i.floors = res.data['data']['floors']
          .map<FloorEntity>((item) => FloorEntity.fromJson(item))
          .toList();
    }
    //todo 获取人员信息
    List<DepartmentMessage> personList = [
      DepartmentMessage(id: '01', title: '技术服务部', personnelList: [
        PersonnelMessage(id: '001', name: '员工1'),
        PersonnelMessage(id: '002', name: '员工2'),
        PersonnelMessage(id: '003', name: '员工3'),
      ]),
      DepartmentMessage(id: '02', title: '设计预算部', personnelList: [
        PersonnelMessage(id: '011', name: '员工1'),
        PersonnelMessage(id: '022', name: '员工2'),
        PersonnelMessage(id: '033', name: '员工3'),
      ]),
      DepartmentMessage(id: '03', title: '总经办', personnelList: [
        PersonnelMessage(id: '021', name: '员工1'),
        PersonnelMessage(id: '022', name: '员工2'),
        PersonnelMessage(id: '023', name: '员工3'),
      ]),
    ];
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
