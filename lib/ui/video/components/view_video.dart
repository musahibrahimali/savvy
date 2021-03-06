import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:status_saver/index.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:video_player/video_player.dart';

class ViewVideo extends StatefulWidget {
  final String video;
  const ViewVideo({
    Key? key,
    required this.video,
  }) : super(key: key);

  @override
  _ViewVideoState createState() => _ViewVideoState();
}

class _ViewVideoState extends State<ViewVideo> {
  final FlutterShareMe flutterShareMe = FlutterShareMe();

  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.network(widget.video)
      ..initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.white,
            size: 28.0,
          ),
          onPressed: () => {
            // if video is playig then pause it
            if (_videoPlayerController.value.isPlaying) _videoPlayerController.pause(),
            Navigator.pop(context)
          },
        ),
      ),
      body: SizedBox.expand(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: VideoPlayer(
                  _videoPlayerController,
                ),
              ),
            ),
            // add a play button in the middle of the aspect ratio
            Align(
              alignment: Alignment.center,
              child: Container(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _videoPlayerController.value.isPlaying
                          ? _videoPlayerController.pause()
                          : _videoPlayerController.play();
                    });
                  },
                  child: Icon(
                    _videoPlayerController.value.isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // add a horizontal white bar
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 60.0,
                width: MediaQuery.of(context).size.width,
                color: Colors.teal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // add repost button
                    Expanded(
                      child: InkWell(
                        child: Icon(
                          Icons.reply_all_rounded,
                          size: 38.0,
                          color: BrandColors.colorWhiteAccent,
                        ),
                        onTap: () async {
                          _launchWhatsapp(widget.video);
                        },
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Icon(
                          Icons.share,
                          size: 38.0,
                          color: BrandColors.colorWhiteAccent,
                        ),
                        onTap: () async => await _onShare(widget.video),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Icon(
                          Icons.file_download,
                          size: 38.0,
                          color: BrandColors.colorWhiteAccent,
                        ),
                        onTap: () async => await _saveVideo(widget.video),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _saveVideo(String video) async {
    // save the video to the gallery
    var savedFile = await GallerySaver.saveVideo(
      video,
      albumName: Constants.albumName,
      toDcim: false,
    );

    // if the file is saved
    if (savedFile != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Video saved to gallery',
            style: GoogleFonts.poppins(
              color: BrandColors.colorWhiteAccent,
            ),
          ),
        ),
      );
    } else {
      // show a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'There was an error  gallery',
            style: GoogleFonts.poppins(),
          ),
        ),
      );
    }
  }

  // share video
  _onShare(video) async {
    // share the final image
    flutterShareMe.shareToWhatsApp(
      msg: 'Check out this video from savvy status saver',
      imagePath: video,
      fileType: FileType.video,
    );
  }

  void _launchWhatsapp(String video) async {
    // create a directory from the string
    Directory whatsAppDir = Directory(Constants.mediaDir);
    Directory whatsAppBusDir = Directory(Constants.businessMediaDir);
    bool _isWhatsApp = await whatsAppDir.exists();
    bool _isWhatsAppBusiness = await whatsAppBusDir.exists();
    // check if the directory exists
    if (_isWhatsApp) {
      flutterShareMe.shareToWhatsApp(
        msg: 'Check out this video from savvy status saver',
        imagePath: video,
        fileType: FileType.video,
      );
    } else if (_isWhatsAppBusiness) {
      flutterShareMe.shareToWhatsApp4Biz(
        msg: 'Check out this video from savvy status saver',
        imagePath: video,
      );
    } else if (_isWhatsApp && _isWhatsAppBusiness) {
      flutterShareMe.shareToWhatsApp(
        msg: 'Check out this video from savvy status saver',
        imagePath: video,
        fileType: FileType.video,
      );
    } else {
      // show a snackbar to install whatsapp
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Install WhatsApp to share',
            style: GoogleFonts.poppins(),
          ),
        ),
      );
    }
  }
}
