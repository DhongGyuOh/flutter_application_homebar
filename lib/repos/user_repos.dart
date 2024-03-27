import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  //key로 사용할 값들 변수로 지정
  static const String _email = "email";
  static const String _password = "password";

  //SharedPreferences를 생성할때 인자로 받음
  //(UserRepository를 생성하려면 SharedPreferences가 필요)
  final SharedPreferences _preferences;
  UserRepository(this._preferences);

  //초기화
  Future<void> initUser() async {
    _preferences.setString(_email, '');
    _preferences.setString(_password, '');
  }

  //조회
  String getEmail() {
    String email = _preferences.getString(_email) ?? '';
    return email;
  }

  String getPassword() {
    String password = _preferences.getString(_password) ?? '';
    return password;
  }

  //삽입
  Future<void> setUser(String email, String password) async {
    _preferences.setString(_email, email);
    _preferences.setString(_password, password);
  }

  //삭제
  Future<void> deleteUser() async {
    await _preferences.remove(_email);
    await _preferences.remove(_password);
  }
}
