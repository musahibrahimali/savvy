import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:status_saver/index.dart';
import 'package:status_saver/ui/image/components/components.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({Key? key}) : super(key: key);

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  late List<String> _files;
  bool _isLoading = true;

  @override
  void initState() {
    _files = HelperFunctions.getImageFiles(whatsAppTypeController.currentWhatsAppType);
    super.initState();
  }

  // override setState
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!Directory(whatsAppTypeController.currentWhatsAppType).existsSync()) {
      return const InstallWhatsApp();
    } else {
      return Obx(
        () => Scaffold(
          backgroundColor: themeController.isLightTheme ? BrandColors.colorBackground : BrandColors.kDark,
          body: RefreshIndicator(
            onRefresh: _onRefresh,
            displacement: 15.0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(),
              padding: const EdgeInsets.symmetric(
                horizontal: 6.0,
                vertical: 12.0,
              ),
              child: _files.isNotEmpty
                  ? GridView.builder(
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 3 / 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: _files.length,
                      itemBuilder: (BuildContext context, int index) {
                        Future.delayed(
                          const Duration(milliseconds: 300),
                          () => setState(() {
                            _isLoading = false;
                          }),
                        );
                        return ImageTile(
                          file: _files[index],
                          isLoading: _isLoading,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewImage(
                                  image: _files[index],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    )
                  : Column(
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
                    ),
            ),
          ),
        ),
      );
    }
  }

  Future<void> _onRefresh() async {
    _files = HelperFunctions.getImageFiles(whatsAppTypeController.currentWhatsAppType);
  }
}
