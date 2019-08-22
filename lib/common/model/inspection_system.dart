///@author ggq
///@description: 检查系统实体类
///@date :2019/8/19 17:47
part of "model.dart";
///检查系统实体类
class InspectionSystem {
  ///id
  String id;

  ///名称
  String name;

  ///系统对应的检查项
  List<InspectionItem> inspectionItem;

  InspectionSystem({this.id, this.name, this.inspectionItem});

  InspectionSystem.copyNullItemList(InspectionSystem data)
      : id = data.id,
        name = data.name,inspectionItem=[];

  InspectionSystem.copyFull(InspectionSystem data)
      : id = data.id,
        name = data.name,inspectionItem=List.from(data.inspectionItem);

//  InspectionSystem.generate(this.id)
//      : name = "系统$id",
//        inspectionItem =
//            List.generate(15, (index) => InspectionItem.generate("系统$id", id));


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is InspectionSystem &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name &&
              inspectionItem == other.inspectionItem;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      inspectionItem.hashCode;

  factory InspectionSystem.fromJson(Map<String, dynamic> json) {
    return InspectionSystem(
      name: json['name'],
      id: json['id'],
      inspectionItem: json['check_item_list']
          .map<InspectionItem>((item) => InspectionItem.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['check_item_list'] =
        inspectionItem.map((item) => item.toJson()).toList();
    return data;
  }
}

///检查项目
class InspectionItem {
  ///id
  String id;

  ///名称
  String name;

  ///检查内容
  String content;

  InspectionItem({this.id, this.name, this.content});

  InspectionItem.generate(sysName, this.id) : name = "$sysName项目$id]";

  factory InspectionItem.fromJson(Map<String, dynamic> json) {
    return InspectionItem(
      name: json['name'],
      id: json['id'],
      content: json['content'],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is InspectionItem &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name &&
              content == other.content;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      content.hashCode;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['content'] = this.content;
    return data;
  }
}
