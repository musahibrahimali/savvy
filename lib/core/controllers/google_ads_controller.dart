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
      _isAndroid ? 'ca-app-pub-3940256099942544/6300978111' : 'ca-app-pub-3940256099942544/2934735716';

  // get interstitial ad unit id
  String get getInterstitialAdUnitId =>
      _isAndroid ? 'ca-app-pub-3940256099942544/1033173712' : 'ca-app-pub-3940256099942544/4411468910';

  // get reward ad unit id
  String get getRewardAdUnitId =>
      _isAndroid ? 'ca-app-pub-3940256099942544/5224354917' : 'ca-app-pub-3940256099942544/1712485313';

  // get banner ad listener
  BannerAdListener get getBannerAdListener => _bannerAdListener;

  // get banner ad
  BannerAd get getBannerAd => _createBannerAd();
}
