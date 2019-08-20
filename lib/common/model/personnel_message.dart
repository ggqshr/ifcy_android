
/// 部门实体类
class DepartmentMessage {
  String id;
  String title;
  List<PersonnelMessage> personnelList;

  DepartmentMessage({this.id, this.title, this.personnelList});
}

///人员信息
class PersonnelMessage{
  int id;
  String name;
  PersonnelMessage({this.id,this.name});

  PersonnelMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['real_name'];
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is PersonnelMessage &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}

