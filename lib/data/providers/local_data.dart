import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalData {
  Future<void> saveToken(String token);
  Future<void> deleteToken();
  String getToken();

  Future<void> saveRefreshToken(String token);
  Future<void> deleteRefreshToken();
  String getRefreshToken();
}

class LocalDataImpl implements LocalData {
  final SharedPreferences sharedPreferences;

  static const String _tokenKey = 'token';
  static const String _refreshToken = 'refresh_token';

  LocalDataImpl({required this.sharedPreferences});

  @override
  Future<void> saveToken(String token) async {
    await sharedPreferences.setString(_tokenKey, token);
  }

  @override
  Future<void> deleteToken() async {
    await sharedPreferences.remove(_tokenKey);
  }

  @override
  String getToken() {
    return sharedPreferences.getString(_tokenKey) ?? '';
  }

  @override
  Future<void> saveRefreshToken(String token) async {
    await sharedPreferences.setString(_refreshToken, token);
  }

  @override
  Future<void> deleteRefreshToken() async {
    await sharedPreferences.remove(_refreshToken);
  }

  @override
  String getRefreshToken() {
    return sharedPreferences.getString(_refreshToken) ?? '';
  }
}