import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:status_saver/index.dart';

// pages
final List<Widget> pages = [
  HomePage(),
  HomePageBusiness(),
];

// tabviews
final List<Widget> tabViews = [
  const ImageScreen(),
  const VideoScreen(),
];

// tabs
final List<Widget> tabs = [
  Obx(
    () => Container(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        'IMAGES',
        style: GoogleFonts.raleway(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: themeController.isLightTheme ? Colors.teal : BrandColors.colorWhiteAccent,
        ),
      ),
    ),
  ),
  Obx(
    () => Container(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        'VIDEOS',
        style: GoogleFonts.raleway(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: themeController.isLightTheme ? Colors.teal : BrandColors.colorWhiteAccent,
        ),
      ),
    ),
  ),
];

AppBar buildAppBar(TabController _tabController) {
  // app bar
  AppBar appBar = AppBar(
    backgroundColor: themeController.isLightTheme ? BrandColors.colorBackground : BrandColors.kDarkGray,
    title: Text(
      'Savvy',
      style: GoogleFonts.pacifico(
        fontSize: 28.0,
        fontWeight: FontWeight.w600,
        color: themeController.isLightTheme ? Colors.teal : BrandColors.colorWhiteAccent,
      ),
    ),
    actions: <Widget>[
      ObxValue(
        (data) => IconButton(
          icon: Icon(
            themeController.isLightTheme ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
            color: themeController.isLightTheme ? Colors.teal : BrandColors.colorWhiteAccent,
          ),
          onPressed: () {
            themeController.toggleTheme();
            Get.changeThemeMode(
              themeController.isLightTheme ? ThemeMode.light : ThemeMode.dark,
            );
          },
        ),
        false.obs,
      ),
      PopupMenuButton<String>(
        color: themeController.isLightTheme ? BrandColors.colorBackground : BrandColors.kDarkGray,
        icon: Icon(
          Icons.more_vert_outlined,
          color: themeController.isLightTheme ? Colors.teal : BrandColors.colorWhiteAccent,
        ),
        onSelected: HelperFunctions.choiceAction,
        itemBuilder: (BuildContext context) {
          return Constants.choices.map(
            (String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(
                  choice,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    color: themeController.isLightTheme ? Colors.teal : BrandColors.colorWhiteAccent,
                  ),
                ),
              );
            },
          ).toList();
        },
      )
    ],
    bottom: TabBar(
      controller: _tabController,
      indicatorColor: themeController.isLightTheme ? Colors.teal : BrandColors.colorWhiteAccent,
      physics: const ClampingScrollPhysics(),
      onTap: (index) {
        _tabController.animateTo(index);
      },
      tabs: tabs,
    ),
  );

  // return app bar
  return appBar;
}

Container buildBannerContainer(_bannerAd, {double vertical = 10.0, double horizontal = 0.0}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
    height: 60.0,
    width: double.infinity,
    child: AdWidget(ad: _bannerAd!),
  );
}
