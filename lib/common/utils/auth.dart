import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ifcy/common/res/res.dart';

///@author ggq
///@description:在请求之后存储用户的一些信息
///@date :2019/8/15 15:58
class Auth {
  FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage();
  static Auth _auth;

  Auth._() {
    _flutterSecureStorage = FlutterSecureStorage();
  }

  factory Auth.getInstance() {
    if (_auth == null) {
      _auth = Auth._();
    }
    return _auth;
  }

  //存储用户名和密码
  Future save(String userName, String passWord) async {
    await _flutterSecureStorage.write(key: USER_NAME, value: userName);
    await _flutterSecureStorage.write(key: PASS_WORD, value: passWord);
  }

  //注销时删除信息
  Future reset() async {
    await _flutterSecureStorage.delete(key: USER_NAME);
    await _flutterSecureStorage.delete(key: PASS_WORD);
  }

  Future getString(String key)async{
    return await _flutterSecureStorage.read(key: key);
  }
}
