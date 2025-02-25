import 'package:get_storage/get_storage.dart';

class UserData {
  // keys to keep in mind;
  //user all user data model stored in String
  //adminEnabled type boolean,  to check if user is accessing admin panel or Not
  //admin type boolean, to check if user is admin or not


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
