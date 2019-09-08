///@author lc
///@description: 
///@date :2019/8/21 8:40
///
part of 'building_owner_model.dart';
//业主首页视图模型
class HomePageModel {
  int fireNum;
  int faultNum;
  int taskProgress;
  List<FireAlarmMessage> fireAlarmMessageList;
  List<PersonnelMessage> watchkeeperList;

  HomePageModel(
      {this.fireNum,
      this.faultNum,
      this.taskProgress,
      this.fireAlarmMessageList,
      this.watchkeeperList});
}