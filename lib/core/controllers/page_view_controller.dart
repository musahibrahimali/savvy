import 'package:get/get.dart';
import 'package:status_saver/index.dart';

class PageViewController extends GetxController {
  static PageViewController instance = Get.find();

  // curret page index
  final _currentPageIndex = 0.obs;

  // change the current page index
  changeCurrentPage(int index) {
    _currentPageIndex.value = index;
    if (index == 0) {
      whatsAppTypeController.changeWhatsAppTypeToPersonal();
    } else {
      whatsAppTypeController.changeWhatsAppTypeToBusiness();
    }
  }

  // initialize page view controller
  initView() {
    _currentPageIndex.value = 0;
  }

  // get the current page index
  int get currentPageIndex => _currentPageIndex.value;
}
