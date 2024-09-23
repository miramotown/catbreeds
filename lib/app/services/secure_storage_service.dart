import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService{

  static FlutterSecureStorage? _storage;

  static init(){
    _storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
      iOptions: IOSOptions(
        accessibility: KeychainAccessibility.first_unlock
      )
    );
  }

  static Future<void> writeSecureData(String key, String value) async{
    await _storage?.write(key: key, value: value);
  }

  static Future<String> readSecureData(String key) async{
    return await _storage?.read(key: key) ?? '';
  }

  static Future<void> deleteSecureData(String key) async{
    await _storage?.delete(key: key);
  }


}