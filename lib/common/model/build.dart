///@author ggq
///@description: 和建筑相关的实体类
///@date :2019/8/16 14:18
part of "model.dart";
///建筑的实体类
@JsonSerializable()
class Build {
  @JsonKey(ignore: true)
  String buildId;
  @JsonKey(name:"name")
  String buildName; //建筑名称
  ///建筑对应的楼层
  @JsonKey(name:"floors")
  List<FloorEntity> floors;
  @JsonKey(name: "above_floor_num")
  String aboveFloorNum;
  @JsonKey(name:"acreage")
  String acreage;
  @JsonKey(name:"address_detail")
  String addressDetail;

  @JsonKey(name:"area")
  String area;
  @JsonKey(name:"build_date")
  String buildDate;
  @JsonKey(name:"city")
  String city;
  @JsonKey(name:"danger")
  String danger;
  @JsonKey(name:"description")
  String description;
  @JsonKey(name:"latitude")
  String latitude;
  @JsonKey(name:"longitude")
  String longitude;

  @JsonKey(name:"main_engine_code")
  String mainEngineCode;
  @JsonKey(name:"nature")
  String nature;
  @JsonKey(name:"province")
  String province;
  @JsonKey(name:"refractory")
  String refractory;
  @JsonKey(name:"type")
  String type;
  @JsonKey(name:"under_floor_num")
  String underFloorNum;



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
    return 'Build{buildId: $buildId, buildName: $buildName, floors: $floors, aboveFloorNum: $aboveFloorNum, acreage: $acreage, addressDetail: $addressDetail, area: $area, buildDate: $buildDate, city: $city, danger: $danger, description: $description, latitude: $latitude, longitude: $longitude, mainEngineCode: $mainEngineCode, nature: $nature, province: $province, refractory: $refractory, type: $type, underFloorNum: $underFloorNum}';
  }

  factory Build.fromJson(Map<String, dynamic> json) =>
      _$BuildFromJson(json);

  Map<String, dynamic> toJson() => _$BuildToJson(this);
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

  @override
  String toString() {
    return 'FloorEntity{number: $number, code: $code, name: $name, id: $id}';
  }

  factory FloorEntity.fromJson(Map<String, dynamic> json) =>
      _$FloorEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FloorEntityToJson(this);
}
