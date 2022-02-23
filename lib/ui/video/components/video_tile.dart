import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:status_saver/core/core.dart';
import 'package:video_player/video_player.dart';

class VideoTile extends StatefulWidget {
  final String file;
  final bool isLoading;
  final void Function() onTap;

  const VideoTile({
    Key? key,
    required this.file,
    required this.isLoading,
    required this.onTap,
  }) : super(key: key);

  @override
  State<VideoTile> createState() => _VideoTileState();
}

class _VideoTileState extends State<VideoTile> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.network(widget.file)
      ..initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    // dispose the video controller
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: InkWell(
        onTap: widget.onTap,
        child: AspectRatio(
          aspectRatio: _videoPlayerController.value.aspectRatio,
          child: Center(
            child: _videoPlayerController.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _videoPlayerController.value.aspectRatio,
                    child: VideoPlayer(_videoPlayerController),
                  )
                : Shimmer.fromColors(
                    baseColor: BrandColors.kWhiteGray,
                    highlightColor: BrandColors.kHighlightGray,
                    enabled: widget.isLoading,
                    child: Obx(
                      () => Container(
                        height: double.infinity,
                        width: double.infinity,
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
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
