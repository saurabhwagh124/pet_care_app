import 'package:get_storage/get_storage.dart';

class UserData {
  static final UserData _instance = UserData._internal();
  late GetStorage _box;
  factory UserData() {
    return _instance;
  }

  UserData._internal() {
    _box = GetStorage();
  }

  void write(String key, dynamic value) {
    _box.write(key, value);
  }

  T? read<T>(String key) {
    return _box.read<T>(key);
  }

  void remove(String key) {
    _box.remove(key);
  }

  void clear() {
    _box.erase();
  }
}
