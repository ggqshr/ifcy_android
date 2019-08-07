
class SupervisorMessageModel {
  String name;
  String id;
  SupervisorMessageModel({this.name,this.id});

  SupervisorMessageModel.generste(
      id,
      ):name="主管$id";

  @override
  String toString() {
    return 'SupervisorMessageModel{name: $name, id: $id}';
  }

}



