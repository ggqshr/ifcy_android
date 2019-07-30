
/// 部门实体类
class DepartmentMessage {
  String id;
  String title;
  List<PersonnelMessage> personnelList;

  DepartmentMessage({this.id, this.title, this.personnelList});
}

///人员信息
class PersonnelMessage{
  String name;

  PersonnelMessage({this.name});
}

