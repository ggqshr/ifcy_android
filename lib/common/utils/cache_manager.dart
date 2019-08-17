///@author ggq
///@description: 自定义的缓存控制器
///@date :2019/8/12 18:42

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:http/http.dart' as http;

class IfcyCacheManager extends BaseCacheManager {
  static const key = "ifcyCacheKey"; //自定义的缓存Key值,应为唯一值

  static IfcyCacheManager _instance;

  factory IfcyCacheManager() {
    if (_instance == null) {
      _instance = new IfcyCacheManager._();
    }
    return _instance;
  }

  IfcyCacheManager._()
      : super(key,
            maxAgeCacheObject: Duration(days: 30),
            maxNrOfCacheObjects: 500,
            fileFetcher: _customHttpGetter);

  @override
  Future<String> getFilePath() async {
    //获取存储缓存文件的路径，这是存储在外部存储当中
    var dir = await getExternalStorageDirectory();
    return p.join(dir.path, key);
  }

  //自定义的请求类
  static Future<FileFetcherResponse> _customHttpGetter(String url,
      {Map<String, String> headers}) async {
    //todo 应从单例的dio中拿取
    String realUrl = "http://116.56.140.192/getimg" + url;
    //todo 使用dio验证token的合法性，然后加入到header中
    return HttpFileFetcherResponse(await http.get(url, headers: headers));
  }
}
