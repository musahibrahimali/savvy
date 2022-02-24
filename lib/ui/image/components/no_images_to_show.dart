import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:status_saver/index.dart';

class NoImagesToshow extends StatelessWidget {
  const NoImagesToshow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(
          () => Container(
            color: themeController.isLightTheme ? BrandColors.colorBackground : BrandColors.kDark,
            padding: const EdgeInsets.all(45.0),
            child: Text(
              "No Images to Display",
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: GoogleFonts.poppins(
                fontSize: 22.0,
                color: BrandColors.colorText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
