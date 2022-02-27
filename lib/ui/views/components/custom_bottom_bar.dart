import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:status_saver/index.dart';

class CustomBottomNavBar extends StatelessWidget {
  final void Function(int) onTap;

  const CustomBottomNavBar({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        currentIndex: pageViewController.currentPageIndex,
        backgroundColor: themeController.isLightTheme ? BrandColors.colorBackground : BrandColors.kDarkGray,
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.teal,
        unselectedItemColor: BrandColors.kLightGray,
        unselectedIconTheme: IconThemeData(
          color: BrandColors.kLightGray,
          size: 28.0,
        ),
        selectedFontSize: 20.0,
        showUnselectedLabels: false,
        selectedLabelStyle: GoogleFonts.raleway(
          fontSize: 22.0,
          fontWeight: FontWeight.w700,
          color: Colors.teal,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/whatsapp.png',
              width: 30.0,
              height: 30.0,
            ),
            label: "WhatsApp",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/whatsapp_business.png',
              width: 30.0,
              height: 30.0,
            ),
            label: "Business",
          ),
        ],
        onTap: onTap,
      ),
    );
  }
}
