import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Singleton()
class SecureStorage {
  final FlutterSecureStorage _secureStorage;
  final SharedPreferences _pref;

  SecureStorage(this._secureStorage, this._pref);

  /// Storage Key
  static const String tokenKey = 'token';
  static const String refreshTokenKey = 'refresh_token';
  static const String localeKey = 'locale';

  Future<void> saveString(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<String?> getString(String key) async {
    return await _secureStorage.read(key: key);
  }

  Future<void> remove(String key) async {
    await _secureStorage.delete(key: key);
  }

  Future<void> saveToken(String token) async {
    await saveString(tokenKey, token);
  }

  Future<void> saveRefreshToken(String refreshToken) async {
    await saveString(refreshTokenKey, refreshToken);
  }

  Future<String?> getToken() async {
    return await getString(tokenKey);
  }

  Future<String?> getRefreshToken() async {
    return await getString(refreshTokenKey);
  }

  Future<void> saveLocale(String locale) async {
    await _pref.setString(localeKey, locale);
  }

  String? getLocale() {
    return _pref.getString(localeKey);
  }
}
