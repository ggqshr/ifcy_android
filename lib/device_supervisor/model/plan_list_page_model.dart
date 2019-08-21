///@author ggq
///@description: 计划列表分页数据类
///@date :2019/8/21 18:00
part of 'device_supervisor_model.dart';
@JsonSerializable()
class PlanListPageModel {
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

  PlanListPageModel(
      {this.planLists,
      this.currentPageNum,
      this.totalPageNum,
      this.totalElementNum});

  PlanListPageModel.init()
      : currentPageNum = 0,
        totalElementNum = 0,
        totalPageNum = 0,
        planLists = [];

  factory PlanListPageModel.fromJson(Map<String, dynamic> json) =>
      _$PlanListPageModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlanListPageModelToJson(this);

}
