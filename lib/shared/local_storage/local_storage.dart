import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class Keys {
  static const barberToken = "barberToken";
  static const customerToken = "customerToken";
}

class LocalStorage {
  LocalStorage._privateConstructor();

  static final LocalStorage _instance = LocalStorage._privateConstructor();

  factory LocalStorage() {
    return _instance;
  }

  final storage = const FlutterSecureStorage();

  AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);

  Future<void> writeData(String key, String value) async {
    await storage.write(key: key, value: value, aOptions: _getAndroidOptions());
  }

  Future<String?> readData(String key) async {
    return await storage.read(key: key, aOptions: _getAndroidOptions());
  }

  Future<void> deleteData(String key) async {
    await storage.delete(key: key, aOptions: _getAndroidOptions());
  }

  Future<bool> containsKeyInStorage(String key) async {
    final containsKey =
    await storage.containsKey(key: key, aOptions: _getAndroidOptions());
    return containsKey;
  }
}