import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:status_saver/index.dart';

class ImageTile extends StatelessWidget {
  final String file;
  final bool isLoading;
  final void Function() onTap;

  const ImageTile({
    Key? key,
    required this.file,
    required this.isLoading,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Shimmer.fromColors(
            baseColor: BrandColors.kWhiteGray,
            highlightColor: BrandColors.kHighlightGray,
            enabled: isLoading,
            child: Container(
              height: 50.0,
              width: 50.0,
              decoration: BoxDecoration(
                color: themeController.isLightTheme ? BrandColors.colorBackground : BrandColors.kDark,
                boxShadow: [
                  BoxShadow(
                    color: themeController.isLightTheme ? BrandColors.kHighlightGray : BrandColors.kLightDark,
                    blurRadius: 2.0,
                    spreadRadius: 1.0,
                  ),
                ],
              ),
            ),
          )
        : InkWell(
            onTap: onTap,
            child: Obx(
              () => Container(
                height: 50.0,
                width: 50.0,
                decoration: BoxDecoration(
                  color: themeController.isLightTheme ? BrandColors.colorBackground : BrandColors.kDark,
                  boxShadow: [
                    BoxShadow(
                      color: themeController.isLightTheme ? BrandColors.kHighlightGray : BrandColors.kLightDark,
                      blurRadius: 2.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                child: Image.file(
                  File(file),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
  }
}
