///@author ggq
///@description: 和建筑相关的实体类
///@date :2019/8/16 14:18
part of "model.dart";
///建筑的实体类
class Build {
  String buildId; //建筑id
  String buildName; //建筑名称
  ///建筑对应的楼层
  List<FloorEntity> floors;

  Build({this.buildId, this.buildName, this.floors});

  Build.fromMap(Map map)
      : buildId = map['id'],
        buildName = map['name'];


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Build &&
              runtimeType == other.runtimeType &&
              buildId == other.buildId &&
              buildName == other.buildName;

  @override
  int get hashCode =>
      buildId.hashCode ^
      buildName.hashCode;

  @override
  String toString() {
    return 'Build{buildId: $buildId, buildName: $buildName, floors: $floors}';
  }


}

///楼层的实体类
@JsonSerializable()
class FloorEntity {
  ///楼层数
  @JsonKey(ignore: true)
  int number;

  /// 楼层编码
  String code;

  ///楼层名称
  String name;

  ///楼层id
  String id;

  FloorEntity({this.number, this.code, this.name, this.id});


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is FloorEntity &&
              runtimeType == other.runtimeType &&
              number == other.number &&
              code == other.code &&
              name == other.name &&
              id == other.id;

  @override
  int get hashCode =>
      number.hashCode ^
      code.hashCode ^
      name.hashCode ^
      id.hashCode;

  factory FloorEntity.fromJson(Map<String, dynamic> json) =>
      _$FloorEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FloorEntityToJson(this);
}
