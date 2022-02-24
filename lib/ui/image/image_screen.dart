import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:status_saver/index.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({Key? key}) : super(key: key);

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  late List<String> _files;
  bool _isLoading = true;

  late BannerAd _bannerAd;

  @override
  void initState() {
    _files = HelperFunctions.getImageFiles(whatsAppTypeController.currentWhatsAppType);
    _bannerAd = googleAdsController.getBannerAd;
    super.initState();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!Directory(whatsAppTypeController.currentWhatsAppType).existsSync()) {
      return const InstallWhatsApp();
    } else {
      // delay 1 second to show loading
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() {
          _isLoading = false;
        });
      });

      return Obx(
        () => Scaffold(
          backgroundColor: themeController.isLightTheme ? BrandColors.colorBackground : BrandColors.kDarkGray,
          body: RefreshIndicator(
            onRefresh: _onRefresh,
            displacement: 15.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // show the banner ad
                buildContainer(_bannerAd),
                BuildImages(
                  files: _files,
                  isLoading: _isLoading,
                ),
              ],
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
