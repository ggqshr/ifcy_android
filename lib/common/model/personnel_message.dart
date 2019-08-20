
/// 部门实体类
class DepartmentMessage {
  String id;
  String title;
  List<PersonnelMessage> personnelList;
  DepartmentMessage({this.id, this.title, this.personnelList});
}

///人员信息
class PersonnelMessage{
  String id;
  String name;
  String post;//职位
  String contact;//联系方式
  String companyName; //所属公司

  PersonnelMessage({this.id, this.name, this.post, this.contact,this.companyName});

  PersonnelMessage.generate(id):
  name="某某$id",
  post="职位$id",
  contact="1573623623$id",
  companyName="公司$id";

  @override
  String toString() {
    return 'PersonnelMessage{id: $id, name: $name, post: $post, contact: $contact, companyName: $companyName}';
  }

}

