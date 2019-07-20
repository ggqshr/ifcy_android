import 'package:ifcy/main_app/model/select_project_model.dart';

part 'login_page_model.dart';

class AppState {
  String userName;
  String alertText;
  Map project2Auth;
  SelectProjectModel selectProjectModel = SelectProjectModel();

  AppState({
    this.userName,
    this.alertText,
    this.project2Auth,
    this.selectProjectModel,
  });

  @override
  String toString() {
    return 'AppState{userName: $userName, alertText: $alertText, project2Auth: $project2Auth, selectProjectModel: $selectProjectModel}';
  }

}
