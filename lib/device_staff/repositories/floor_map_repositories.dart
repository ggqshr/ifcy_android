import 'package:dio/dio.dart';
import 'package:ifcy/common/model/model.dart';
import 'package:ifcy/common/utils/dio_util.dart';

///@author ggq
///@description:
///@date :2019/9/22 16:03
class FloorMapDataProvider {
  final Dio dio;

  FloorMapDataProvider([dio]) : dio = dio ?? DioUtils.getInstance().getDio();

  Future<FloorEntity> getFloorDetail(String floorId) async {
    Dio dio = DioUtils.getInstance().getDio();
    Response res = await dio.get("/building/floor/$floorId");
    FloorEntity floor = FloorEntity.fromJson(res.data['data']);
    return floor;
  }
}

class FloorMapDataRepositories {
  final FloorMapDataProvider provider;

  FloorMapDataRepositories([provider])
      : provider = provider ?? FloorMapDataProvider();

  Future<FloorEntity> getFloorDetail(String floorId) async {
    return await provider.getFloorDetail(floorId);
  }
}
