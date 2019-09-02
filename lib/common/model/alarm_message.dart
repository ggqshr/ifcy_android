part of "model.dart";

///火灾消息实体类
@JsonSerializable()
class FireAlarmMessage {
  @JsonKey(name: "event_id")
  String eventId;
  @JsonKey(name: "device_name")
  String deviceName;
  @JsonKey(name: "send_time", toJson: timeToJson, fromJson: timeFromJson)
  DateTime sendTime;
  @JsonKey(name: "device_code")
  String deviceCode;
  bool checked;
  @JsonKey(name: "main_engine_code")
  String mainEngineCode;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  FireAlarmMessage({
    @required this.eventId,
    @required this.deviceName,
    @required this.sendTime,
    @required this.deviceCode,
    @required this.checked,
    @required this.mainEngineCode,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FireAlarmMessage &&
          runtimeType == other.runtimeType &&
          eventId == other.eventId &&
          deviceName == other.deviceName &&
          sendTime == other.sendTime &&
          deviceCode == other.deviceCode &&
          checked == other.checked &&
          mainEngineCode == other.mainEngineCode);

  @override
  int get hashCode =>
      eventId.hashCode ^
      deviceName.hashCode ^
      sendTime.hashCode ^
      deviceCode.hashCode ^
      checked.hashCode ^
      mainEngineCode.hashCode;

  @override
  String toString() {
    return 'FireAlarmMessage{' +
        ' eventId: $eventId,' +
        ' deviceName: $deviceName,' +
        ' sendTime: $sendTime,' +
        ' deviceCode: $deviceCode,' +
        ' checked: $checked,' +
        ' mainEngineCode: $mainEngineCode,' +
        '}';
  }

  FireAlarmMessage copyWith({
    String eventId,
    String deviceName,
    DateTime sendTime,
    String deviceCode,
    bool checked,
    String mainEngineCode,
  }) {
    return FireAlarmMessage(
      eventId: eventId ?? this.eventId,
      deviceName: deviceName ?? this.deviceName,
      sendTime: sendTime ?? this.sendTime,
      deviceCode: deviceCode ?? this.deviceCode,
      checked: checked ?? this.checked,
      mainEngineCode: mainEngineCode ?? this.mainEngineCode,
    );
  }

  Map<String, dynamic> toJson() => _$FireAlarmMessageToJson(this);

  factory FireAlarmMessage.fromJson(Map<String, dynamic> map) =>
      _$FireAlarmMessageFromJson(map);

//</editor-fold>
}

///设备故障报警
@JsonSerializable()
class DeviceFaultAlarmMessage {
  @JsonKey(name: "event_id")
  String eventId;
  @JsonKey(name: "device_name")
  String deviceName;
  @JsonKey(name: "send_time", toJson: timeToJson, fromJson: timeFromJson)
  DateTime sendTime;
  @JsonKey(name: "device_code")
  String deviceCode;
  bool checked;
  @JsonKey(name: "main_engine_code")
  String mainEngineCode;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  DeviceFaultAlarmMessage({
    @required this.eventId,
    @required this.deviceName,
    @required this.sendTime,
    @required this.deviceCode,
    @required this.checked,
    @required this.mainEngineCode,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FireAlarmMessage &&
          runtimeType == other.runtimeType &&
          eventId == other.eventId &&
          deviceName == other.deviceName &&
          sendTime == other.sendTime &&
          deviceCode == other.deviceCode &&
          checked == other.checked &&
          mainEngineCode == other.mainEngineCode);

  @override
  int get hashCode =>
      eventId.hashCode ^
      deviceName.hashCode ^
      sendTime.hashCode ^
      deviceCode.hashCode ^
      checked.hashCode ^
      mainEngineCode.hashCode;

  @override
  String toString() {
    return 'DeviceFaultAlarmMessage{' +
        ' eventId: $eventId,' +
        ' deviceName: $deviceName,' +
        ' sendTime: $sendTime,' +
        ' deviceCode: $deviceCode,' +
        ' checked: $checked,' +
        ' mainEngineCode: $mainEngineCode,' +
        '}';
  }

  FireAlarmMessage copyWith({
    String eventId,
    String deviceName,
    DateTime sendTime,
    String deviceCode,
    bool checked,
    String mainEngineCode,
  }) {
    return FireAlarmMessage(
      eventId: eventId ?? this.eventId,
      deviceName: deviceName ?? this.deviceName,
      sendTime: sendTime ?? this.sendTime,
      deviceCode: deviceCode ?? this.deviceCode,
      checked: checked ?? this.checked,
      mainEngineCode: mainEngineCode ?? this.mainEngineCode,
    );
  }

  Map<String, dynamic> toJson() => _$DeviceFaultAlarmMessageToJson(this);

  factory DeviceFaultAlarmMessage.fromJson(Map<String, dynamic> map) =>
      _$DeviceFaultAlarmMessageFromJson(map);

//</editor-fold>
}
