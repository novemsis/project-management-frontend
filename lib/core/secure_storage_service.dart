import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod/riverpod.dart';

final secureStorageServiceProvider = Provider((ref) {
  final secureStorage = ref.read(_secureStorageProvider);
  return SecureStorageService(secureStorage);
});

final _secureStorageProvider = Provider<FlutterSecureStorage>(
  (ref) => const FlutterSecureStorage(
    aOptions: AndroidOptions(
      storageNamespace: 'vision_flow_settings',
    ),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock_this_device, accountName: 'vision_flow_settings'),
  ),
);

class SecureStorageService {
  static const _iosOptions = IOSOptions(accessibility: KeychainAccessibility.first_unlock_this_device);
  final FlutterSecureStorage _secureStorage;

  SecureStorageService(this._secureStorage);

  Future<void> writeString(String key, String data) async {
    await _secureStorage.write(key: key, value: data, iOptions: _iosOptions);
  }

  Future<bool> exists(String key) async => await _secureStorage.containsKey(key: key, iOptions: _iosOptions);

  Future<String> readString(String key) async {
    final stringFromStorage = await _secureStorage.read(key: key, iOptions: _iosOptions);
    if (stringFromStorage == null) {
      throw Exception("Error on reading key '$key' from storage");
    }

    return stringFromStorage;
  }

  Future<void> delete(String key) async {
    await _secureStorage.delete(key: key, iOptions: _iosOptions);
  }

  Future<void> deleteAll() async {
    await _secureStorage.deleteAll(iOptions: _iosOptions);
  }
}
