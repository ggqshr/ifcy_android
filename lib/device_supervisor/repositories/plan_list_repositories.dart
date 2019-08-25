import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/device_supervisor/model/device_supervisor_model.dart';
import 'package:ifcy/device_supervisor/repositories/plan_list_provider.dart';

///@author ggq
///@description:
///@date :2019/8/24 9:49
class PlanListRepositories {
  final PlanListDataProvider dataProvider;
  final List<Build> buildList;
  final String projectId;

  PlanListRepositories(this.buildList, this.projectId)
      : dataProvider = PlanListDataProvider();

  Future<PlanListPageModel> getFirstPage() async {
    PlanListPageModel model =
        await dataProvider.getPlanListByProjectId(projectId);
    model.currentPageNum = 1;
    for (var p in model.planLists) {
      p.currentBuild = buildList
          .singleWhere((item) => item.buildId == p.currentBuild.buildId);
    }
    return model;
  }

  Future<PlanListPageModel> getNextPage(int pageNum) async {
    PlanListPageModel model =
        await dataProvider.getPlanListByProjectId(projectId, page: pageNum);
    for (var p in model.planLists) {
      p.currentBuild = buildList
          .singleWhere((item) => item.buildId == p.currentBuild.buildId);
    }
    return model;
  }
}
