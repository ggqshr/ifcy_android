///@author ggq
///@description:
///@date :2020/9/1 15:45
part of "model.dart";

@JsonSerializable()
class LoginUserInfo {
  String username;
  String password;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  LoginUserInfo({
    @required this.username,
    @required this.password,
  });

  LoginUserInfo copyWith({
    String username,
    String password,
  }) {
    return new LoginUserInfo(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  String toString() {
    return 'LoginUserInfo{username: $username, password: $password}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LoginUserInfo &&
          runtimeType == other.runtimeType &&
          username == other.username &&
          password == other.password);

  @override
  int get hashCode => username.hashCode ^ password.hashCode;

  factory LoginUserInfo.fromMap(Map<String, dynamic> map) {
    return new LoginUserInfo(
      username: map['username'] as String,
      password: map['password'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'username': this.username,
      'password': this.password,
    } as Map<String, dynamic>;
  }

  factory LoginUserInfo.fromJson(Map<String, dynamic> json) =>
      _$LoginUserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$LoginUserInfoToJson(this);
//</editor-fold>

}
