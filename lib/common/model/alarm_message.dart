part of "model.dart";

abstract class AlarmMessage {
  String eventId;
  String deviceName;
  DateTime sendTime;
  String deviceCode;
  bool checked;
  String mainEngineCode;
  String id;
  String floorAreaName;
  String floorName;
  String floorId;
}

///火灾消息实体类
@JsonSerializable()
class FireAlarmMessage extends AlarmMessage {
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
  String id;
  @JsonKey(name: "floor_area_name")
  String floorAreaName;
  @JsonKey(name: "floor_name")
  String floorName;
  @JsonKey(name:"floor_id")
  String floorId;

  Map<String, dynamic> toJson() => _$FireAlarmMessageToJson(this);

  factory FireAlarmMessage.fromJson(Map<String, dynamic> map) =>
      _$FireAlarmMessageFromJson(map);


//<editor-fold desc="Data Methods" defaultstate="collapsed">


  FireAlarmMessage({
    @required this.eventId,
    @required this.deviceName,
    @required this.sendTime,
    @required this.deviceCode,
    @required this.checked,
    @required this.mainEngineCode,
    @required this.id,
    @required this.floorAreaName,
    @required this.floorName,
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
              mainEngineCode == other.mainEngineCode &&
              id == other.id &&
              floorAreaName == other.floorAreaName &&
              floorName == other.floorName
          );


  @override
  int get hashCode =>
      eventId.hashCode ^
      deviceName.hashCode ^
      sendTime.hashCode ^
      deviceCode.hashCode ^
      checked.hashCode ^
      mainEngineCode.hashCode ^
      id.hashCode ^
      floorAreaName.hashCode ^
      floorName.hashCode;


  @override
  String toString() {
    return 'FireAlarmMessage{' +
        ' eventId: $eventId,' +
        ' deviceName: $deviceName,' +
        ' sendTime: $sendTime,' +
        ' deviceCode: $deviceCode,' +
        ' checked: $checked,' +
        ' mainEngineCode: $mainEngineCode,' +
        ' id: $id,' +
        ' floorAreaName: $floorAreaName,' +
        ' floorName: $floorName,' +
        '}';
  }


  FireAlarmMessage copyWith({
    String eventId,
    String deviceName,
    DateTime sendTime,
    String deviceCode,
    bool checked,
    String mainEngineCode,
    String id,
    String floorAreaName,
    String floorName,
  }) {
    return FireAlarmMessage(
      eventId: eventId ?? this.eventId,
      deviceName: deviceName ?? this.deviceName,
      sendTime: sendTime ?? this.sendTime,
      deviceCode: deviceCode ?? this.deviceCode,
      checked: checked ?? this.checked,
      mainEngineCode: mainEngineCode ?? this.mainEngineCode,
      id: id ?? this.id,
      floorAreaName: floorAreaName ?? this.floorAreaName,
      floorName: floorName ?? this.floorName,
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'eventId': this.eventId,
      'deviceName': this.deviceName,
      'sendTime': this.sendTime,
      'deviceCode': this.deviceCode,
      'checked': this.checked,
      'mainEngineCode': this.mainEngineCode,
      'id': this.id,
      'floorAreaName': this.floorAreaName,
      'floorName': this.floorName,
    };
  }

  factory FireAlarmMessage.fromMap(Map<String, dynamic> map) {
    return FireAlarmMessage(
      eventId: map['eventId'] as String,
      deviceName: map['deviceName'] as String,
      sendTime: map['sendTime'] as DateTime,
      deviceCode: map['deviceCode'] as String,
      checked: map['checked'] as bool,
      mainEngineCode: map['mainEngineCode'] as String,
      id: map['id'] as String,
      floorAreaName: map['floorAreaName'] as String,
      floorName: map['floorName'] as String,
    );
  }


//</editor-fold>
}

///设备故障报警
@JsonSerializable()
class DeviceFaultAlarmMessage extends AlarmMessage {
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
  String id;
  @JsonKey(name: "floor_area_name")
  String floorAreaName;
  @JsonKey(name: "floor_name")
  String floorName;
  @JsonKey(name:"floor_id")
  String floorId;

  Map<String, dynamic> toJson() => _$DeviceFaultAlarmMessageToJson(this);

  factory DeviceFaultAlarmMessage.fromJson(Map<String, dynamic> map) =>
      _$DeviceFaultAlarmMessageFromJson(map);

//<editor-fold desc="Data Methods" defaultstate="collapsed">


  DeviceFaultAlarmMessage({
    @required this.eventId,
    @required this.deviceName,
    @required this.sendTime,
    @required this.deviceCode,
    @required this.checked,
    @required this.mainEngineCode,
    @required this.id,
    @required this.floorAreaName,
    @required this.floorName,
  });


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is DeviceFaultAlarmMessage &&
              runtimeType == other.runtimeType &&
              eventId == other.eventId &&
              deviceName == other.deviceName &&
              sendTime == other.sendTime &&
              deviceCode == other.deviceCode &&
              checked == other.checked &&
              mainEngineCode == other.mainEngineCode &&
              id == other.id &&
              floorAreaName == other.floorAreaName &&
              floorName == other.floorName
          );


  @override
  int get hashCode =>
      eventId.hashCode ^
      deviceName.hashCode ^
      sendTime.hashCode ^
      deviceCode.hashCode ^
      checked.hashCode ^
      mainEngineCode.hashCode ^
      id.hashCode ^
      floorAreaName.hashCode ^
      floorName.hashCode;


  @override
  String toString() {
    return 'DeviceFaultAlarmMessage{' +
        ' eventId: $eventId,' +
        ' deviceName: $deviceName,' +
        ' sendTime: $sendTime,' +
        ' deviceCode: $deviceCode,' +
        ' checked: $checked,' +
        ' mainEngineCode: $mainEngineCode,' +
        ' id: $id,' +
        ' floorAreaName: $floorAreaName,' +
        ' floorName: $floorName,' +
        '}';
  }


  DeviceFaultAlarmMessage copyWith({
    String eventId,
    String deviceName,
    DateTime sendTime,
    String deviceCode,
    bool checked,
    String mainEngineCode,
    String id,
    String floorAreaName,
    String floorName,
  }) {
    return DeviceFaultAlarmMessage(
      eventId: eventId ?? this.eventId,
      deviceName: deviceName ?? this.deviceName,
      sendTime: sendTime ?? this.sendTime,
      deviceCode: deviceCode ?? this.deviceCode,
      checked: checked ?? this.checked,
      mainEngineCode: mainEngineCode ?? this.mainEngineCode,
      id: id ?? this.id,
      floorAreaName: floorAreaName ?? this.floorAreaName,
      floorName: floorName ?? this.floorName,
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'eventId': this.eventId,
      'deviceName': this.deviceName,
      'sendTime': this.sendTime,
      'deviceCode': this.deviceCode,
      'checked': this.checked,
      'mainEngineCode': this.mainEngineCode,
      'id': this.id,
      'floorAreaName': this.floorAreaName,
      'floorName': this.floorName,
    };
  }

  factory DeviceFaultAlarmMessage.fromMap(Map<String, dynamic> map) {
    return DeviceFaultAlarmMessage(
      eventId: map['eventId'] as String,
      deviceName: map['deviceName'] as String,
      sendTime: map['sendTime'] as DateTime,
      deviceCode: map['deviceCode'] as String,
      checked: map['checked'] as bool,
      mainEngineCode: map['mainEngineCode'] as String,
      id: map['id'] as String,
      floorAreaName: map['floorAreaName'] as String,
      floorName: map['floorName'] as String,
    );
  }


//</editor-fold>
}

abstract class CheckAlarmMessage {
  @JsonKey(name: "event_id")
  String eventId;
  @JsonKey(name: "device_name")
  String deviceName;
  @JsonKey(name: "record_time", toJson: timeToJson, fromJson: timeFromJson)
  DateTime recordTime;
  @JsonKey(name: "device_code")
  String deviceCode;
  bool checked;
  @JsonKey(name: "engine_code")
  String engineCode;
  String id;
  @JsonKey(name: "check_user_id")
  String checkUserId;
  @JsonKey(name: "warning_message_id")
  String warningMessageId;
  @JsonKey(name: "check_time")
  String checkTIme;
  @JsonKey(name: "check_user_real_name")
  String checkUserRealName;
}

@JsonSerializable()
class FireCheckAlarmMessage extends CheckAlarmMessage {
  @JsonKey(name: "event_id")
  String eventId;
  @JsonKey(name: "device_name")
  String deviceName;
  @JsonKey(name: "record_time", toJson: timeToJson, fromJson: timeFromJson)
  DateTime recordTime;
  @JsonKey(name: "device_code")
  String deviceCode;
  bool checked;
  @JsonKey(name: "engine_code")
  String engineCode;
  String id;
  @JsonKey(name: "check_user_id")
  String checkUserId;
  @JsonKey(name: "warning_message_id")
  String warningMessageId;
  @JsonKey(name: "fire_type")
  String fireType;
  @JsonKey(name: "check_time")
  String checkTIme;
  @JsonKey(name: "check_user_real_name")
  String checkUserRealName;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  FireCheckAlarmMessage({
    @required this.eventId,
    @required this.deviceName,
    @required this.recordTime,
    @required this.deviceCode,
    @required this.checked,
    @required this.engineCode,
    @required this.id,
    @required this.checkUserId,
    @required this.warningMessageId,
    @required this.fireType,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FireCheckAlarmMessage &&
          runtimeType == other.runtimeType &&
          eventId == other.eventId &&
          deviceName == other.deviceName &&
          recordTime == other.recordTime &&
          deviceCode == other.deviceCode &&
          checked == other.checked &&
          engineCode == other.engineCode &&
          id == other.id &&
          checkUserId == other.checkUserId &&
          warningMessageId == other.warningMessageId &&
          fireType == other.fireType);

  @override
  int get hashCode =>
      eventId.hashCode ^
      deviceName.hashCode ^
      recordTime.hashCode ^
      deviceCode.hashCode ^
      checked.hashCode ^
      engineCode.hashCode ^
      id.hashCode ^
      checkUserId.hashCode ^
      warningMessageId.hashCode ^
      fireType.hashCode;

  @override
  String toString() {
    return 'FireCheckAlarmMessage{' +
        ' eventId: $eventId,' +
        ' deviceName: $deviceName,' +
        ' recordTime: $recordTime,' +
        ' deviceCode: $deviceCode,' +
        ' checked: $checked,' +
        ' engineCode: $engineCode,' +
        ' id: $id,' +
        ' checkUserId: $checkUserId,' +
        ' warningMessageId: $warningMessageId,' +
        ' fireType: $fireType,' +
        '}';
  }

  FireCheckAlarmMessage copyWith({
    String eventId,
    String deviceName,
    DateTime recordTime,
    String deviceCode,
    bool checked,
    String engineCode,
    String id,
    String checkUserId,
    String warningMessageId,
    String fireType,
  }) {
    return FireCheckAlarmMessage(
      eventId: eventId ?? this.eventId,
      deviceName: deviceName ?? this.deviceName,
      recordTime: recordTime ?? this.recordTime,
      deviceCode: deviceCode ?? this.deviceCode,
      checked: checked ?? this.checked,
      engineCode: engineCode ?? this.engineCode,
      id: id ?? this.id,
      checkUserId: checkUserId ?? this.checkUserId,
      warningMessageId: warningMessageId ?? this.warningMessageId,
      fireType: fireType ?? this.fireType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'eventId': this.eventId,
      'deviceName': this.deviceName,
      'recordTime': this.recordTime,
      'deviceCode': this.deviceCode,
      'checked': this.checked,
      'engineCode': this.engineCode,
      'id': this.id,
      'checkUserId': this.checkUserId,
      'warningMessageId': this.warningMessageId,
      'fireType': this.fireType,
    };
  }

  factory FireCheckAlarmMessage.fromMap(Map<String, dynamic> map) {
    return FireCheckAlarmMessage(
      eventId: map['eventId'] as String,
      deviceName: map['deviceName'] as String,
      recordTime: map['recordTime'] as DateTime,
      deviceCode: map['deviceCode'] as String,
      checked: map['checked'] as bool,
      engineCode: map['engineCode'] as String,
      id: map['id'] as String,
      checkUserId: map['checkUserId'] as String,
      warningMessageId: map['warningMessageId'] as String,
      fireType: map['fireType'] as String,
    );
  }

  Map<String, dynamic> toJson() => _$FireCheckAlarmMessageToJson(this);

  factory FireCheckAlarmMessage.fromJson(Map<String, dynamic> map) =>
      _$FireCheckAlarmMessageFromJson(map);

//</editor-fold>
}

@JsonSerializable()
class DeviceCheckedAlarmMessage extends CheckAlarmMessage {
  @JsonKey(name: "event_id")
  String eventId;
  @JsonKey(name: "device_name")
  String deviceName;
  @JsonKey(name: "record_time", toJson: timeToJson, fromJson: timeFromJson)
  DateTime recordTime;
  @JsonKey(name: "device_code")
  String deviceCode;
  bool checked;
  @JsonKey(name: "engine_code")
  String engineCode;
  String id;
  @JsonKey(name: "check_user_id")
  String checkUserId;
  @JsonKey(name: "warning_message_id")
  String warningMessageId;
  @JsonKey(name: "fault_type")
  String faultType;
  @JsonKey(name: "check_time")
  String checkTIme;
  @JsonKey(name: "check_user_real_name")
  String checkUserRealName;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  DeviceCheckedAlarmMessage({
    @required this.eventId,
    @required this.deviceName,
    @required this.recordTime,
    @required this.deviceCode,
    @required this.checked,
    @required this.engineCode,
    @required this.id,
    @required this.checkUserId,
    @required this.warningMessageId,
    @required this.faultType,
    @required this.checkTIme,
    @required this.checkUserRealName,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DeviceCheckedAlarmMessage &&
          runtimeType == other.runtimeType &&
          eventId == other.eventId &&
          deviceName == other.deviceName &&
          recordTime == other.recordTime &&
          deviceCode == other.deviceCode &&
          checked == other.checked &&
          engineCode == other.engineCode &&
          id == other.id &&
          checkUserId == other.checkUserId &&
          warningMessageId == other.warningMessageId &&
          faultType == other.faultType &&
          checkTIme == other.checkTIme &&
          checkUserRealName == other.checkUserRealName);

  @override
  int get hashCode =>
      eventId.hashCode ^
      deviceName.hashCode ^
      recordTime.hashCode ^
      deviceCode.hashCode ^
      checked.hashCode ^
      engineCode.hashCode ^
      id.hashCode ^
      checkUserId.hashCode ^
      warningMessageId.hashCode ^
      faultType.hashCode ^
      checkTIme.hashCode ^
      checkUserRealName.hashCode;

  @override
  String toString() {
    return 'DeviceCheckedAlarmMessage{' +
        ' eventId: $eventId,' +
        ' deviceName: $deviceName,' +
        ' recordTime: $recordTime,' +
        ' deviceCode: $deviceCode,' +
        ' checked: $checked,' +
        ' engineCode: $engineCode,' +
        ' id: $id,' +
        ' checkUserId: $checkUserId,' +
        ' warningMessageId: $warningMessageId,' +
        ' faultType: $faultType,' +
        ' checkTIme: $checkTIme,' +
        ' checkUserRealName: $checkUserRealName,' +
        '}';
  }

  DeviceCheckedAlarmMessage copyWith({
    String eventId,
    String deviceName,
    DateTime recordTime,
    String deviceCode,
    bool checked,
    String engineCode,
    String id,
    String checkUserId,
    String warningMessageId,
    String faultType,
    String checkTIme,
    String checkUserRealName,
  }) {
    return DeviceCheckedAlarmMessage(
      eventId: eventId ?? this.eventId,
      deviceName: deviceName ?? this.deviceName,
      recordTime: recordTime ?? this.recordTime,
      deviceCode: deviceCode ?? this.deviceCode,
      checked: checked ?? this.checked,
      engineCode: engineCode ?? this.engineCode,
      id: id ?? this.id,
      checkUserId: checkUserId ?? this.checkUserId,
      warningMessageId: warningMessageId ?? this.warningMessageId,
      faultType: faultType ?? this.faultType,
      checkTIme: checkTIme ?? this.checkTIme,
      checkUserRealName: checkUserRealName ?? this.checkUserRealName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'eventId': this.eventId,
      'deviceName': this.deviceName,
      'recordTime': this.recordTime,
      'deviceCode': this.deviceCode,
      'checked': this.checked,
      'engineCode': this.engineCode,
      'id': this.id,
      'checkUserId': this.checkUserId,
      'warningMessageId': this.warningMessageId,
      'faultType': this.faultType,
      'checkTIme': this.checkTIme,
      'checkUserRealName': this.checkUserRealName,
    };
  }

  factory DeviceCheckedAlarmMessage.fromMap(Map<String, dynamic> map) {
    return DeviceCheckedAlarmMessage(
      eventId: map['eventId'] as String,
      deviceName: map['deviceName'] as String,
      recordTime: map['recordTime'] as DateTime,
      deviceCode: map['deviceCode'] as String,
      checked: map['checked'] as bool,
      engineCode: map['engineCode'] as String,
      id: map['id'] as String,
      checkUserId: map['checkUserId'] as String,
      warningMessageId: map['warningMessageId'] as String,
      faultType: map['faultType'] as String,
      checkTIme: map['checkTIme'] as String,
      checkUserRealName: map['checkUserRealName'] as String,
    );
  }

  Map<String, dynamic> toJson() => _$DeviceCheckedAlarmMessageToJson(this);

  factory DeviceCheckedAlarmMessage.fromJson(Map<String, dynamic> map) =>
      _$DeviceCheckedAlarmMessageFromJson(map);

//</editor-fold>
}
