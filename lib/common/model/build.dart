///@author ggq
///@description: 建筑的实体类
///@date :2019/8/16 14:18
class Build {
  String buildId; //建筑id
  String buildName; //建筑名称

  Build({this.buildId, this.buildName});

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


}
