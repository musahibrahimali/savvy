import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:status_saver/core/core.dart';

class RequestPermission extends StatelessWidget {
  final void Function() onPressed;

  const RequestPermission({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: themeController.isLightTheme ? BrandColors.colorBackground : BrandColors.kDark,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: themeController.isLightTheme ? BrandGradients.sea : BrandGradients.fireMon,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Storage Permission Required",
                  style: GoogleFonts.raleway(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: themeController.isLightTheme ? Colors.white : BrandColors.colorWhiteAccent,
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: themeController.isLightTheme ? BrandColors.colorBackground : Colors.teal,
                  primary: Colors.teal,
                  onSurface: Colors.white,
                  padding: const EdgeInsets.all(15.0),
                ),
                child: Text(
                  "Allow Storage Permission",
                  style: GoogleFonts.poppins(
                    fontSize: 20.0,
                    color: themeController.isLightTheme ? BrandColors.colorDarkBlue : BrandColors.colorWhiteAccent,
                  ),
                ),
                onPressed: onPressed,
              )
            ],
          ),
        ),
      ),
    );
  }
}
