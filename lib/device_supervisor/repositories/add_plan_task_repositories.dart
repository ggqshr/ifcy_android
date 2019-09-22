import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/common/utils/dio_util.dart';
import 'package:ifcy/device_supervisor/model/device_supervisor_model.dart';

///@author ggq
///@description:
///@date :2019/8/26 13:18
class AddTaskPlanDataProvider {
  final Dio _dio;

  AddTaskPlanDataProvider() : _dio = DioUtils.getInstance().getDio();

  Future<List<InspectionSystem>> getCheckSystem() async {
    Response res = await _dio.get("/patrol/check-systems");
    List<InspectionSystem> systems = res.data['data']
        .map<InspectionSystem>((item) => InspectionSystem.fromJson(item))
        .toList();
    return systems;
  }

  List<TaskCycleModel> getTaskCycleModel() {
    return [
      TaskCycleModel(cycleId: '1', item: '周检'),
      TaskCycleModel(cycleId: '2', item: '日检'),
      TaskCycleModel(cycleId: '3', item: '月检'),
      TaskCycleModel(cycleId: '4', item: '季度检'),
      TaskCycleModel(cycleId: '5', item: '半年检'),
      TaskCycleModel(cycleId: '6', item: '年检'),
    ];
  }

  Future<List<PersonnelMessage>> getPersonnelMessage() async {
    Response res = await _dio.get("/sys-user/users/MAINTAIN_WORKER");
    return res.data['data'].map<PersonnelMessage>((item)=>PersonnelMessage.fromJson(item)).toList();
  }

  Future<Response> submitPlan(TaskPlanEntity entity) async {
    Map map = entity.toJson();
    map.remove("start_time");
    map.remove("end_time");
    map.remove("id");
    return await _dio.post("/patrol/plan", data: jsonEncode(map));
  }

  Future<Response> submitTask(TaskPlanEntity entity) async {
    Map map = entity.toJson();
    map.remove("start_deploy_time");
    map.remove("task_execute_time");
    map.remove("cycle");
    map.remove("id");
    return await _dio.post("/patrol/task", data: jsonEncode(map));
  }
}

class AddTaskPlanRepositories {
  final AddTaskPlanDataProvider addTaskPlanDataProvider;

  AddTaskPlanRepositories({dataProvider})
      : addTaskPlanDataProvider = dataProvider ?? AddTaskPlanDataProvider();

  Future<List<InspectionSystem>> getSystem() async {
    return await addTaskPlanDataProvider.getCheckSystem();
  }

  List<TaskCycleModel> getTaskCycleModel() {
    return addTaskPlanDataProvider.getTaskCycleModel();
  }

  Future<List<PersonnelMessage>> getPersonnelMessage() async {
    return await addTaskPlanDataProvider.getPersonnelMessage();
  }

  Future<bool> submitting(TaskPlanEntity entity) async {
    Response res;
    if (entity.inspectionType == NewInspectionType.plan) {
      res = await addTaskPlanDataProvider.submitPlan(entity);
    }else if(entity.inspectionType== NewInspectionType.task){
      res = await addTaskPlanDataProvider.submitTask(entity);
    }
    return res.data['msg']=="成功";
  }
}
