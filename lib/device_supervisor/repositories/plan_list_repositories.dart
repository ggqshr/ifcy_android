import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/device_supervisor/model/device_supervisor_model.dart';
import 'package:ifcy/device_supervisor/repositories/plan_list_provider.dart';

///@author ggq
///@description:
///@date :2019/8/24 9:49
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
}
