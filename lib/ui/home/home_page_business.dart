import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:status_saver/index.dart';

class HomePageBusiness extends StatelessWidget {
  HomePageBusiness({Key? key}) : super(key: key);

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
                ? const WhatsAppBusinessScreen()
                : RequestPermission(
                    onPressed: () => permissionController.requestStoragePermission(),
                  ),
          ),
        ),
      ),
    );
  }
}
