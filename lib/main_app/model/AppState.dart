import 'package:ifcy/device_staff/model/device_staff_model.dart';
import 'package:ifcy/device_supervisor/model/device_supervisor_model.dart';
import 'package:ifcy/building_owner/model/buildingOwnerGlobalModel.dart';
import 'package:ifcy/main_app/model/select_project_model.dart';

part 'login_page_model.dart';

class AppState {
  String companyName; //公司名
  String userName; //用户名
  int userId; //用户id
  String alertText;
  Map project2Auth;
  SelectProjectModel selectProjectModel = SelectProjectModel();
  DeviceSupervisorModel deviceSupervisorModel = DeviceSupervisorModel.init();
  DeviceStaffModel deviceStaffModel = DeviceStaffModel.init();
  BuildingOwnerModel buildingOwnerModel = BuildingOwnerModel();

  AppState({
    this.userName,
    this.alertText,
    this.project2Auth,
    this.selectProjectModel,
    this.deviceSupervisorModel,
    this.deviceStaffModel,
    this.buildingOwnerModel,
    this.companyName,
    this.userId,
  });
}

class Projects {
  String projectName;
  String projectId;

  Projects(this.projectName, this.projectId);

  Projects.fromMap(Map map)
      : projectId = map['id'],
        projectName = map['name'];
}
