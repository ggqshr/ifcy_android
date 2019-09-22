import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/common/utils/utils.dart';
import 'package:ifcy/device_supervisor/model/device_supervisor_model.dart';

///@author ggq
///@description:
///@date :2019/8/24 9:49
class PlanListDataProvider {
  Future<PlanTaskListPageModel> getPlanList(
      {int listRow = 1, int page = 1}) async {
    Dio dio = DioUtils.getInstance().getDio();
    Response res = await dio.get("/patrol/plans",
        queryParameters: {"page": page, "list_rows": listRow});
    return PlanTaskListPageModel.fromJson(res.data['data']);
  }

  Future changePlan(TaskPlanEntity model) async {
    Map map = model.toJson();
    map.remove("id");
    map.remove("start_time");
    map.remove("end_time");
    await DioUtils.getInstance()
        .getDio()
        .put("/patrol/plan/${model.id}", data: jsonEncode(map));
  }
}

class PlanListRepositories {
  final PlanListDataProvider dataProvider;

  PlanListRepositories() : dataProvider = PlanListDataProvider();

  Future<PlanTaskListPageModel> getFirstPage() async {
    PlanTaskListPageModel model = await dataProvider.getPlanList();
    model.currentPageNum = 1;
    return model;
  }

  Future<PlanTaskListPageModel> getNextPage(int pageNum) async {
    PlanTaskListPageModel model = await dataProvider.getPlanList(page: pageNum);
    return model;
  }

  Future changePlan(TaskPlanEntity model) async {
    await dataProvider.changePlan(model);
  }
}
