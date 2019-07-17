import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'AsyncModel.dart';

part 'Moudle1Model.g.dart';

@JsonSerializable()
class Moudle1Model {
  int count;
  bool showText;
  String text2show;

  Moudle1Model(this.count, this.showText, this.text2show);

  factory Moudle1Model.fromJson(Map<String, dynamic> json) =>
      _$Moudle1ModelFromJson(json);

  Map<String, dynamic> toJson() => _$Moudle1ModelToJson(this);
}
