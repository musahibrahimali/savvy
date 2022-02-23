import 'package:get/get.dart';
import 'package:status_saver/core/core.dart';

class WhatsAppTypeController extends GetxController {
  static WhatsAppTypeController instance = Get.find();

  final _currentWhatsApp = Constants.mediaDir.obs;

  initWhatsAppType() {
    _currentWhatsApp.value = Constants.mediaDir;
  }

  // Change WhatsApp Type to business
  changeWhatsAppTypeToBusiness() {
    _currentWhatsApp.value = Constants.businessMediaDir;
  }

  // change media type to personal
  changeWhatsAppTypeToPersonal() {
    _currentWhatsApp.value = Constants.mediaDir;
  }

  // get the current media type
  String get currentWhatsAppType => _currentWhatsApp.value;
}
