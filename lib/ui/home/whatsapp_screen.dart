import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:status_saver/index.dart';

class WhatsAppScreen extends StatefulWidget {
  const WhatsAppScreen({Key? key}) : super(key: key);

  @override
  _WhatsAppScreenState createState() => _WhatsAppScreenState();
}

class _WhatsAppScreenState extends State<WhatsAppScreen> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // tab controller
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        key: _scaffoldKey,
        backgroundColor: themeController.isLightTheme ? BrandColors.colorBackground : BrandColors.kDark,
        appBar: buildAppBar(_tabController),
        body: TabBarView(
          controller: _tabController,
          physics: const ClampingScrollPhysics(),
          children: tabViews,
        ),
      ),
    );
  }
}
