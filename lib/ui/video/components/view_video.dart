import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:status_saver/index.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:video_player/video_player.dart';

class ViewVideo extends StatefulWidget {
  final String video;
  const ViewVideo({
    Key? key,
    required this.video,
  }) : super(key: key);

  @override
  _ViewVideoState createState() => _ViewVideoState();
}

class _ViewVideoState extends State<ViewVideo> {
  final FlutterShareMe flutterShareMe = FlutterShareMe();

  late VideoPlayerController _videoPlayerController;

  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;
  final int maxFailedLoadAttempts = 3;

  late BannerAd _bannerAd;

  bool _isPlaying = false;

  _createInterstitialAd() {
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
    _bannerAd = googleAdsController.createBannerAd;
    _videoPlayerController = VideoPlayerController.network(widget.video)
      ..initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    // set the video to loop
    _videoPlayerController.setLooping(true);
    // play the video after it is initialized
    _videoPlayerController.play();
    _isPlaying = true;
    _createInterstitialAd();
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd.dispose();
    _videoPlayerController.dispose();
    _interstitialAd?.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: themeController.isLightTheme ? BrandColors.colorBackground : BrandColors.kDarkGray,
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(
              Icons.close_rounded,
              color: themeController.isLightTheme ? BrandColors.kDarkGray : BrandColors.colorWhiteAccent,
              size: 28.0,
            ),
            onPressed: () {
              // if video is playig then pause it
              if (_videoPlayerController.value.isPlaying) _videoPlayerController.pause();
              // stop video
              _videoPlayerController.seekTo(const Duration(seconds: 0));
              try {
                _showInterstitialAd();
              } catch (error) {
                return;
              }
              Navigator.pop(context);
            },
          ),
          title: buildBannerContainer(_bannerAd, vertical: 5.0),
        ),
        body: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: VideoPlayer(
                  _videoPlayerController,
                ),
              ),
            ),
            // add a play button in the middle of the aspect ratio
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _videoPlayerController.value.isPlaying
                        ? _videoPlayerController.pause()
                        : _videoPlayerController.play();
                    _isPlaying = !_isPlaying;
                  });
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(50.0),
                    border: Border.all(
                      color: themeController.isLightTheme ? BrandColors.kGrayWhite : BrandColors.colorWhiteAccent,
                      width: 2.0,
                    ),
                  ),
                  child: _isPlaying
                      ? Icon(
                          _videoPlayerController.value.isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                        )
                      : Icon(
                          Icons.play_arrow,
                          color: themeController.isLightTheme ? BrandColors.kGrayWhite : BrandColors.colorWhiteAccent,
                        ),
                ),
              ),
            ),
            // add a horizontal white bar
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 60.0,
                width: MediaQuery.of(context).size.width,
                color: Colors.teal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // add repost button
                    Expanded(
                      child: InkWell(
                        child: Icon(
                          Icons.reply_all_rounded,
                          size: 38.0,
                          color: BrandColors.colorWhiteAccent,
                        ),
                        onTap: () async {
                          _launchWhatsapp(widget.video);
                        },
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Icon(
                          Icons.share,
                          size: 38.0,
                          color: BrandColors.colorWhiteAccent,
                        ),
                        onTap: () async => await _onShare(widget.video),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Icon(
                          Icons.file_download,
                          size: 38.0,
                          color: BrandColors.colorWhiteAccent,
                        ),
                        onTap: () async => await _saveVideo(widget.video),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _saveVideo(String video) async {
    // save the video to the gallery
    var savedFile = await GallerySaver.saveVideo(
      video,
      albumName: Constants.albumName,
      toDcim: false,
    );

    // if the file is saved
    if (savedFile != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Video saved to gallery',
            style: GoogleFonts.poppins(
              color: BrandColors.colorWhiteAccent,
            ),
          ),
        ),
      );
    } else {
      // show a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'There was an error  gallery',
            style: GoogleFonts.poppins(),
          ),
        ),
      );
    }
  }

  // share video
  _onShare(video) async {
    // share the final image
    flutterShareMe.shareToWhatsApp(
      msg: 'Check out this video from savvy status saver',
      imagePath: video,
      fileType: FileType.video,
    );
  }

  void _launchWhatsapp(String video) async {
    // create a directory from the string
    Directory whatsAppDir = Directory(Constants.mediaDir);
    Directory whatsAppBusDir = Directory(Constants.businessMediaDir);
    bool _isWhatsApp = await whatsAppDir.exists();
    bool _isWhatsAppBusiness = await whatsAppBusDir.exists();
    // check if the directory exists
    if (_isWhatsApp) {
      flutterShareMe.shareToWhatsApp(
        msg: 'Check out this video from savvy status saver',
        imagePath: video,
        fileType: FileType.video,
      );
    } else if (_isWhatsAppBusiness) {
      flutterShareMe.shareToWhatsApp4Biz(
        msg: 'Check out this video from savvy status saver',
        imagePath: video,
      );
    } else if (_isWhatsApp && _isWhatsAppBusiness) {
      flutterShareMe.shareToWhatsApp(
        msg: 'Check out this video from savvy status saver',
        imagePath: video,
        fileType: FileType.video,
      );
    } else {
      // show a snackbar to install whatsapp
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Install WhatsApp to share',
            style: GoogleFonts.poppins(),
          ),
        ),
      );
    }
  }
}
