import 'package:dio/dio.dart';
import 'package:ifcy/common/utils/dio_util.dart';
import 'package:ifcy/device_supervisor/model/device_supervisor_model.dart';

///@author ggq
///@description:
///@date :2019/8/24 9:50
class PlanListDataProvider {
  Future<PlanListPageModel> getPlanListByProjectId(
      {int listRow = 1, int page = 1}) async {
    Dio dio = DioUtils.getInstance().getDio();
    Response res = await dio.get("/patrol/plans",
        queryParameters: {"page": page, "list_rows": listRow});
    return PlanListPageModel.fromJson(res.data['data']);
  }
}
