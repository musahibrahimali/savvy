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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.store_mall_directory_sharp,
            ),
            label: "WhatsApp",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.store_mall_directory_outlined,
            ),
            label: "Business",
          ),
        ],
        onTap: onTap,
      ),
    );
  }
}
