///@author ggq
///@description: 
///@date :2019/9/7 9:26
part of "model.dart";

@JsonSerializable()
class DeviceMessage {
  String area;
  String category;
  String code;
  String floor;
  String id;
  String name;
  bool online;
  String position;
  String status;


//<editor-fold desc="Data Methods" defaultstate="collapsed">


  DeviceMessage({
    @required this.area,
    @required this.category,
    @required this.code,
    @required this.floor,
    @required this.id,
    @required this.name,
    @required this.online,
    @required this.position,
    @required this.status,
  });


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is DeviceMessage &&
              runtimeType == other.runtimeType &&
              area == other.area &&
              category == other.category &&
              code == other.code &&
              floor == other.floor &&
              id == other.id &&
              name == other.name &&
              online == other.online &&
              position == other.position &&
              status == other.status
          );


  @override
  int get hashCode =>
      area.hashCode ^
      category.hashCode ^
      code.hashCode ^
      floor.hashCode ^
      id.hashCode ^
      name.hashCode ^
      online.hashCode ^
      position.hashCode ^
      status.hashCode;


  @override
  String toString() {
    return 'DeviceMessage{' +
        ' area: $area,' +
        ' category: $category,' +
        ' code: $code,' +
        ' floor: $floor,' +
        ' id: $id,' +
        ' name: $name,' +
        ' online: $online,' +
        ' position: $position,' +
        ' status: $status,' +
        '}';
  }


  DeviceMessage copyWith({
    String area,
    String category,
    String code,
    String floor,
    String id,
    String name,
    bool online,
    String position,
    String status,
  }) {
    return DeviceMessage(
      area: area ?? this.area,
      category: category ?? this.category,
      code: code ?? this.code,
      floor: floor ?? this.floor,
      id: id ?? this.id,
      name: name ?? this.name,
      online: online ?? this.online,
      position: position ?? this.position,
      status: status ?? this.status,
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'area': this.area,
      'category': this.category,
      'code': this.code,
      'floor': this.floor,
      'id': this.id,
      'name': this.name,
      'online': this.online,
      'position': this.position,
      'status': this.status,
    };
  }

  factory DeviceMessage.fromMap(Map<String, dynamic> map) {
    return DeviceMessage(
      area: map['area'] as String,
      category: map['category'] as String,
      code: map['code'] as String,
      floor: map['floor'] as String,
      id: map['id'] as String,
      name: map['name'] as String,
      online: map['online'] as bool,
      position: map['position'] as String,
      status: map['status'] as String,
    );
  }
  Map<String, dynamic> toJson() => _$DeviceMessageToJson(this);

  factory DeviceMessage.fromJson(Map<String, dynamic> map) =>
      _$DeviceMessageFromJson(map);

//</editor-fold>
}