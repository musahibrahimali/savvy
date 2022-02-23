import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:status_saver/index.dart';

class ThemeController extends GetxController {
  static ThemeController instance = Get.find();

  final _isLightTheme = true.obs;

  // change the theme
  toggleTheme() {
    _isLightTheme.value = !_isLightTheme.value;
    _saveThemeStatus();
  }

  // is light theme active
  bool get isLightTheme => _isLightTheme.value;

  // change theme from shared pref
  initTheme() async {
    SharedPreferences prefs = await sharedPreferences;
    _isLightTheme.value = prefs.getBool('theme') ?? true;
  }

  _saveThemeStatus() async {
    SharedPreferences pref = await sharedPreferences;
    pref.setBool('theme', isLightTheme);
  }
}
