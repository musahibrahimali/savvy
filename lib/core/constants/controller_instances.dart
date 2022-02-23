import 'package:shared_preferences/shared_preferences.dart';
import 'package:status_saver/core/controllers/theme_controller.dart';
import 'package:status_saver/index.dart';

PermissionController permissionController = PermissionController.instance;
WhatsAppTypeController whatsAppTypeController = WhatsAppTypeController.instance;
ThemeController themeController = ThemeController.instance;
PageViewController pageViewController = PageViewController.instance;

// share preference instance
Future<SharedPreferences> sharedPreferences = SharedPreferences.getInstance();
