import 'package:flutter/material.dart';
import 'package:status_saver/ui/video/components/components.dart';

class BuildVideos extends StatelessWidget {
  final List<String> files;
  final bool isLoading;
  final void Function() openAd;

  const BuildVideos({
    Key? key,
    required this.files,
    required this.isLoading,
    required this.openAd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(),
        padding: const EdgeInsets.symmetric(
          horizontal: 6.0,
          vertical: 12.0,
        ),
        child: files.isNotEmpty
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: files.length,
                itemBuilder: (BuildContext context, int index) {
                  return VideoTile(
                    file: files[index],
                    isLoading: isLoading,
                    onTap: () {
                      try {
                        openAd();
                      } catch (error) {
                        return;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewVideo(
                            video: files[index],
                          ),
                        ),
                      );
                    },
                  );
                },
              )
            : const NoVideosToShow(),
      ),
    );
  }
}
