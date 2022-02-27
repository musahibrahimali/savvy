import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GoogleAdsController extends GetxController {
  static GoogleAdsController instance = Get.find();

  // is platform android or ios
  final bool _isAndroid = GetPlatform.isAndroid;

  // banner ad listener
  final BannerAdListener _bannerAdListener = const BannerAdListener();

  // ad request
  final AdRequest _adRequest = const AdRequest();

  // create banner ad
  _createBannerAd() {
    return BannerAd(
      adUnitId: getBannerAdUnitId,
      size: AdSize.banner,
      listener: _bannerAdListener,
      request: _adRequest,
    )..load();
  }

  // get banner ad unit id
  String get getBannerAdUnitId =>
      _isAndroid ? 'ca-app-pub-6362648380607319/7727855746' : 'ca-app-pub-3940256099942544/2934735716';

  // get interstitial ad unit id
  String get getInterstitialAdUnitId =>
      _isAndroid ? 'ca-app-pub-6362648380607319/8005351056' : 'ca-app-pub-3940256099942544/5135589807';

  // get banner ad listener
  BannerAdListener get getBannerAdListener => _bannerAdListener;

  // get banner ad
  BannerAd get createBannerAd => _createBannerAd();

  // get ad request
  AdRequest get getAdRequest => _adRequest;
}
