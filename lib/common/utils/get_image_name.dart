///@author ggq
///@description:
///@date :2019/9/24 16:46
class GetImageName {
  static List<String> deviceTypeCode = [
    "POINT_TYPE_TEMPERATURE_SENSOR", //点型温感
    "SOUNDER", //扬声器
    "POINT_TYPE_SMOKE_SENSOR", //点型烟感
  ];

  static String nullImageName = "NULL";

  static String getFIreFaultSuffix(bool value) {
    return value ? "FIRE" : "FAULT";
  }

  static typeCodeGetImageName(String code, bool isFire) {
    if (deviceTypeCode.contains(code)) {
      return "${code}_${getFIreFaultSuffix(isFire)}.png";
    } else {
      return "${nullImageName}_${getFIreFaultSuffix(isFire)}.png";
    }
  }
}
