import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:status_saver/core/controllers/theme_controller.dart';
import 'package:status_saver/index.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  // enable flutter widgets binding (using a plugin before runnig the app)
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // initialize google mobile ads
  MobileAds.instance.initialize();

  // get packages controller
  Get.put(PermissionController());
  Get.put(WhatsAppTypeController());
  Get.put(ThemeController());
  Get.put(PageViewController());
  Get.put(GoogleAdsController());

  // remove the native splash screen when init is done
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
    themeController.initTheme();
    whatsAppTypeController.initWhatsAppType();
    pageViewController.initView();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Savvy',
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      themeMode: themeController.isLightTheme ? ThemeMode.light : ThemeMode.dark,
      home: HomeView(),
    );
  }
}
