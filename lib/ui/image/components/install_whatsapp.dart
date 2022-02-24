import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:status_saver/index.dart';

class InstallWhatsApp extends StatelessWidget {
  const InstallWhatsApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        color: themeController.isLightTheme ? BrandColors.colorBackground : BrandColors.kDarkGray,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Install WhatsApp".toUpperCase(),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: GoogleFonts.raleway(
                fontSize: 22.0,
                color: themeController.isLightTheme ? Colors.teal : BrandColors.kHighlightGray,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.4,
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              "Your Friend's Status Will Be Available Here",
              maxLines: 3,
              textAlign: TextAlign.center,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              strutStyle: const StrutStyle(
                forceStrutHeight: true,
                height: 3.0,
              ),
              style: GoogleFonts.poppins(
                fontSize: 44.0,
                color: themeController.isLightTheme ? BrandColors.kLightGray : BrandColors.colorWhiteAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
