import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:status_saver/index.dart';
import 'package:status_saver/ui/video/components/components.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late List<String> _files;
  bool _isLoading = true;
  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;
  final int maxFailedLoadAttempts = 3;

  late BannerAd _bannerAd;

  void _createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: googleAdsController.getInterstitialAdUnitId,
      request: googleAdsController.getAdRequest,
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _numInterstitialLoadAttempts = 0;
          _interstitialAd!.setImmersiveMode(true);
        },
        onAdFailedToLoad: (LoadAdError error) {
          _numInterstitialLoadAttempts += 1;
          _interstitialAd = null;
          if (_numInterstitialLoadAttempts <= maxFailedLoadAttempts) {
            _createInterstitialAd();
          }
        },
      ),
    );
  }

  _showInterstitialAd() {
    if (_interstitialAd == null) {
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) => {},
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  @override
  void initState() {
    super.initState();
    _files = HelperFunctions.getVideoFiles(whatsAppTypeController.currentWhatsAppType);
    _bannerAd = googleAdsController.createBannerAd;
    _createInterstitialAd();
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd.dispose();
    _interstitialAd?.dispose();
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
                buildBannerContainer(_bannerAd),
                BuildVideos(
                  files: _files,
                  isLoading: _isLoading,
                  openAd: _showInterstitialAd,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Future<void> _onRefresh() async {
    _files = HelperFunctions.getVideoFiles(whatsAppTypeController.currentWhatsAppType);
  }
}
