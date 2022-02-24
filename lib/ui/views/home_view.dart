import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:status_saver/index.dart';
import 'package:status_saver/ui/views/components/custom_bottom_bar.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // page controller
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: themeController.isLightTheme ? BrandColors.colorBackground : BrandColors.kDarkGray,
        bottomNavigationBar: CustomBottomNavBar(
          onTap: (index) {
            pageViewController.changeCurrentPage(index);
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear,
            );
          },
        ),
        body: PageView(
          controller: _pageController,
          physics: const ClampingScrollPhysics(),
          children: pages,
        ),
      ),
    );
  }
}
