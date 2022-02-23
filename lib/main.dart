import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:status_saver/core/controllers/theme_controller.dart';
import 'package:status_saver/index.dart';

void main() {
  // enable flutter widgets binding
  WidgetsFlutterBinding.ensureInitialized();

  // initialize google admob
  MobileAds.instance.initialize();

  // get packages controller
  Get.put(PermissionController());
  Get.put(WhatsAppTypeController());
  Get.put(ThemeController());
  Get.put(PageViewController());
  runApp(Savvy());

  // handle display orientation on various devices
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [],
  );
}

class Savvy extends StatelessWidget {
  Savvy({Key? key}) : super(key: key) {
    permissionController.initPermision();
    whatsAppTypeController.initWhatsAppType();
    themeController.initTheme();
    pageViewController.initView();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Savvy',
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      themeMode: themeController.isLightTheme ? ThemeMode.light : ThemeMode.dark,
      home: const HomeView(),
    );
  }
}
