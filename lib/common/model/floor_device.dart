part of models;

@JsonSerializable()
class FloorDeviceModel {
  String id;
  String name;
  String code;
  @JsonKey(name: "category_name")
  String categoryName;
  @JsonKey(name: "category_code")
  String categoryCode;
  String xposition;
  String yposition;
  String position;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  FloorDeviceModel({
    @required this.id,
    @required this.name,
    @required this.code,
    @required this.categoryName,
    @required this.categoryCode,
    @required this.xposition,
    @required this.yposition,
    @required this.position,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FloorDeviceModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          code == other.code &&
          categoryName == other.categoryName &&
          categoryCode == other.categoryCode &&
          xposition == other.xposition &&
          yposition == other.yposition &&
          position == other.position);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      code.hashCode ^
      categoryName.hashCode ^
      categoryCode.hashCode ^
      xposition.hashCode ^
      yposition.hashCode ^
      position.hashCode;

  @override
  String toString() {
    return 'FloorDeviceModel{' +
        ' id: $id,' +
        ' name: $name,' +
        ' code: $code,' +
        ' categoryName: $categoryName,' +
        ' categoryCode: $categoryCode,' +
        ' xposition: $xposition,' +
        ' yposition: $yposition,' +
        ' position: $position,' +
        '}';
  }

  FloorDeviceModel copyWith({
    String id,
    String name,
    String code,
    String categoryName,
    String categoryCode,
    String xposition,
    String yposition,
    String position,
  }) {
    return new FloorDeviceModel(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      categoryName: categoryName ?? this.categoryName,
      categoryCode: categoryCode ?? this.categoryCode,
      xposition: xposition ?? this.xposition,
      yposition: yposition ?? this.yposition,
      position: position ?? this.position,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'code': this.code,
      'categoryName': this.categoryName,
      'categoryCode': this.categoryCode,
      'xposition': this.xposition,
      'yposition': this.yposition,
      'position': this.position,
    };
  }

  factory FloorDeviceModel.fromMap(Map<String, dynamic> map) {
    return new FloorDeviceModel(
      id: map['id'] as String,
      name: map['name'] as String,
      code: map['code'] as String,
      categoryName: map['categoryName'] as String,
      categoryCode: map['categoryCode'] as String,
      xposition: map['xposition'] as String,
      yposition: map['yposition'] as String,
      position: map['position'] as String,
    );
  }

  factory FloorDeviceModel.fromJson(Map<String, dynamic> json) =>
      _$FloorDeviceModelFromJson(json);

  Map<String, dynamic> toJson() => _$FloorDeviceModelToJson(this);

//</editor-fold>
}
