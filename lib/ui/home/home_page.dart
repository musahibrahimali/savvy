import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:status_saver/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: BrandColors.colorBackground,
      body: DefaultTabController(
        length: 2,
        child: Obx(
          () => Container(
            child: permissionController.storagePermissionChecker
                ? const WhatsAppScreen()
                : RequestPermission(
                    onPressed: () => permissionController.requestStoragePermission(),
                  ),
          ),
        ),
      ),
    );
  }
}
