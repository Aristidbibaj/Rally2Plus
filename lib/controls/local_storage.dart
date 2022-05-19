import 'package:shared_preferences/shared_preferences.dart';


class LocalStorage {
  static late final SharedPreferences instance;

  static bool _init = false;
  static Future init() async {
    if (_init) return;
    instance = await SharedPreferences.getInstance();
    _init = true;
    return instance;
  }

  static String getLingua() {
    return instance.getString('lingua') ?? 'it';
  }

  static bool isIta() {
    if (getLingua().compareTo('it') == 0) return true;
    return false;
  }
}