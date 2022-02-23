import 'dart:io';

import 'package:status_saver/index.dart';

class HelperFunctions {
  static String choiceAction(String choice) {
    if (choice == Constants.about) {
      return 'About App';
    } else if (choice == Constants.rate) {
      return 'Rate App';
    } else if (choice == Constants.share) {
      return 'Share with friends';
    }
    return '';
  }

  // get all image files from the directory
  static List<String> getImageFiles(String path) {
    Directory directory = Directory(path);
    List<String> imageList =
        directory.listSync().map((item) => item.path).where((item) => item.endsWith(".jpg")).toList(growable: false);
    return imageList;
  }

  // get all video files from the directory
  static List<String> getVideoFiles(String path) {
    Directory directory = Directory(path);
    List<String> imageList =
        directory.listSync().map((item) => item.path).where((item) => item.endsWith(".mp4")).toList(growable: false);
    return imageList;
  }
}
