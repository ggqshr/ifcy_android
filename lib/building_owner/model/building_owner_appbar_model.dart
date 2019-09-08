///@author lc
///@description: 
///@date :2019/8/17 15:18

part of 'building_owner_model.dart';

class BuildingOwnerAppBarModel {
  ///建筑列表
  List<Build> buildingList;
  ///当前建筑
  Build currentBuilding;
  ///更改建筑的回调
  Function onChangeBuildCall;

  BuildingOwnerAppBarModel({this.buildingList, this.currentBuilding, this.onChangeBuildCall});

}
