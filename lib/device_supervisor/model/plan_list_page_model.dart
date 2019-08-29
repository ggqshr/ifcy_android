///@author ggq
///@description: 计划列表分页数据类
///@date :2019/8/21 18:00
part of 'device_supervisor_model.dart';

@JsonSerializable()
class PlanTaskListPageModel {
  ///数据列表
  @JsonKey(name: "content")
  List<TaskPlanEntity> planLists;

  ///当前页数
  @JsonKey(name: "number")
  int currentPageNum;

  ///总页数
  @JsonKey(name: "total_pages")
  int totalPageNum;

  ///总元素个数
  @JsonKey(name: "total_elements")
  int totalElementNum;

  bool get hasReachMax => totalPageNum == currentPageNum;

  PlanTaskListPageModel(
      {this.planLists,
      this.currentPageNum,
      this.totalPageNum,
      this.totalElementNum});

  PlanTaskListPageModel.init()
      : currentPageNum = null,
        totalElementNum = 0,
        totalPageNum = 0,
        planLists = [];

  PlanTaskListPageModel nextPage(PlanTaskListPageModel pageModel) {
    return PlanTaskListPageModel(
      planLists: this.planLists + pageModel.planLists,
      currentPageNum: pageModel.currentPageNum+1,
      totalElementNum: this.totalPageNum,
      totalPageNum: this.totalPageNum,
    );
  }

  factory PlanTaskListPageModel.fromJson(Map<String, dynamic> json) =>
      _$PlanTaskListPageModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlanTaskListPageModelToJson(this);
}
