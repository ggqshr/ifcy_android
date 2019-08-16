///@author ggq
///@description:
///@date :2019/8/16 14:17
part of 'device_staff_model.dart';

class DeviceStaffAppBarModel {
  ///建筑列表
  List<Build> buildingList;

  ///当前建筑
  Build currentBuilding;
  ///更改建筑的回调
  Function onChangeBuildCall;

  DeviceStaffAppBarModel({this.buildingList, this.currentBuilding,
    this.onChangeBuildCall});

}
