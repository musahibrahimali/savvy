import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:status_saver/index.dart';

class PermissionController extends GetxController {
  static PermissionController instance = Get.find();

  final _storagePermissionCheck = 0.obs;
  final _storagePermissionChecker = false.obs;

  _checkStoragePermission() async {
    PermissionStatus result = await Permission.storage.status;
    _storagePermissionCheck.value = 1;
    if (result.isDenied) {
      return 0;
    } else if (result.isGranted) {
      return 1;
    } else {
      return 0;
    }
  }

  requestStoragePermission() async {
    Map<Permission, PermissionStatus> result = await [
      Permission.storage,
      Permission.manageExternalStorage,
    ].request();
    if (result[Permission.storage]!.isDenied && result[Permission.manageExternalStorage]!.isDenied) {
      _storagePermissionChecker.value = false;
      _savePermissionPreference();
      return 1;
    } else if (result[Permission.storage]!.isGranted && result[Permission.manageExternalStorage]!.isGranted) {
      _storagePermissionChecker.value = true;
      _savePermissionPreference();
      return 2;
    } else {
      _storagePermissionChecker.value = true;
      _savePermissionPreference();
      return 1;
    }
  }

  initPermision() async {
    if (!_storagePermissionChecker.value) {
      requestStoragePermission();
    } else {
      int storagePermissionCheckInt;
      bool finalPermission;

      if (_storagePermissionCheck.value == 0) {
        _storagePermissionCheck.value = await _checkStoragePermission();
      } else {
        _storagePermissionCheck.value = 1;
      }
      if (_storagePermissionCheck.value == 1) {
        storagePermissionCheckInt = 1;
      } else {
        storagePermissionCheckInt = 0;
      }

      if (storagePermissionCheckInt == 1) {
        finalPermission = true;
      } else {
        finalPermission = false;
      }
      _storagePermissionChecker.value = finalPermission;
    }

    // save permission preference
    _savePermissionPreference();
  }

  // save permission preference
  _savePermissionPreference() async {
    SharedPreferences _prefs = await sharedPreferences;
    _prefs.setBool('storagePermission', _storagePermissionChecker.value);
  }

  // get storage permission checker
  bool get storagePermissionChecker => _storagePermissionChecker.value;
}
