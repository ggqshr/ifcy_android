class SelectProjectModel {
  String selectedProject; //当前选中的项目
  int selectedProjectIndex = 0; //当前选中项目的下标 ,默认为0
  List projectList; //所有的项目列表
  Function onChangeCall; //当前选中的项目发生变化时的回调
  String auth; //当前选中项目中的身份

  SelectProjectModel({
    this.selectedProject,
    this.selectedProjectIndex,
    this.projectList,
    this.onChangeCall,
    this.auth,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SelectProjectModel &&
          runtimeType == other.runtimeType &&
          selectedProject == other.selectedProject &&
          selectedProjectIndex == other.selectedProjectIndex &&
          projectList == other.projectList &&
          auth == other.auth;

  @override
  int get hashCode =>
      selectedProject.hashCode ^
      selectedProjectIndex.hashCode ^
      projectList.hashCode ^
      auth.hashCode;

  @override
  String toString() {
    return 'SelectProjectModel{selectedProject: $selectedProject, selectedProjectIndex: $selectedProjectIndex, projectList: $projectList, onChangeCall: $onChangeCall, auth: $auth}';
  }
}
