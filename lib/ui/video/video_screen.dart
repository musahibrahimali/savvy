import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:status_saver/index.dart';
import 'package:status_saver/ui/video/components/components.dart';
import 'package:status_saver/ui/video/components/view_video.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late List<String> _files;
  bool _isLoading = true;

  @override
  void initState() {
    _files = HelperFunctions.getVideoFiles(whatsAppTypeController.currentWhatsAppType);
    super.initState();
  }

  // override setState
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: themeController.isLightTheme ? BrandColors.colorBackground : BrandColors.kDark,
        body: RefreshIndicator(
          onRefresh: _onRefresh,
          displacement: 15.0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(),
            padding: const EdgeInsets.symmetric(
              horizontal: 6.0,
              vertical: 12.0,
            ),
            child: _files.isNotEmpty
                ? GridView.builder(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: _files.length,
                    itemBuilder: (BuildContext context, int index) {
                      Future.delayed(
                        const Duration(milliseconds: 300),
                        () => setState(
                          () {
                            _isLoading = false;
                          },
                        ),
                      );
                      return VideoTile(
                        file: _files[index],
                        isLoading: _isLoading,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewVideo(
                                video: _files[index],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(45.0),
                        child: Text(
                          "No Videos to Display",
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: GoogleFonts.poppins(
                            fontSize: 22.0,
                            color: BrandColors.colorText,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    _files = HelperFunctions.getVideoFiles(whatsAppTypeController.currentWhatsAppType);
  }
}
