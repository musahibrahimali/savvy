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
    Directory _directory = Directory(path);
    List<String> _imageList =
        _directory.listSync().map((item) => item.path).where((item) => item.endsWith(".jpg")).toList(growable: false);
    return _imageList;
  }

  // get all video files from the directory
  static List<String> getVideoFiles(String path) {
    Directory _directory = Directory(path);
    List<String> _videoList =
        _directory.listSync().map((item) => item.path).where((item) => item.endsWith(".mp4")).toList(growable: false);
    return _videoList;
  }

  // get the file date
  static String getFileDate(String path) {
    File file = File(path);
    DateTime dateTime = file.statSync().modified;
    return dateTime.toString();
  }
}
