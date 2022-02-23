import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:status_saver/index.dart';
import 'package:flutter_share_me/flutter_share_me.dart';

class ViewImage extends StatefulWidget {
  final String image;
  const ViewImage({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  _ViewImageState createState() => _ViewImageState();
}

class _ViewImageState extends State<ViewImage> {
  final FlutterShareMe flutterShareMe = FlutterShareMe();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          color: Colors.indigo,
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SizedBox.expand(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Hero(
                tag: widget.image,
                child: Image.file(
                  File(widget.image),
                  fit: BoxFit.cover,
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
                          _launchWhatsapp(widget.image);
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
                        onTap: () async => await _onShare(widget.image),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Icon(
                          Icons.file_download,
                          size: 38.0,
                          color: BrandColors.colorWhiteAccent,
                        ),
                        onTap: () async => await _saveImage(widget.image),
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

  _saveImage(String image) async {
    final result = await GallerySaver.saveImage(
      image,
      albumName: Constants.albumName,
      toDcim: false,
    );
    // if the file is saved
    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Image saved to gallery',
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

  // share image
  _onShare(image) async {
    // share the final image
    flutterShareMe.shareToWhatsApp(
      msg: 'Check out this image from savvy status saver',
      imagePath: image,
      fileType: FileType.image,
    );
  }

  void _launchWhatsapp(String image) async {
    // create a directory
    Directory whatsAppDir = Directory(Constants.mediaDir);
    Directory whatsAppBusDir = Directory(Constants.businessMediaDir);
    bool _isWhatsApp = await whatsAppDir.exists();
    bool _isWhatsAppBusiness = await whatsAppBusDir.exists();
    // check if the directory exists
    if (_isWhatsApp) {
      flutterShareMe.shareToWhatsApp(
        msg: 'Check out this image from savvy status saver',
        imagePath: image,
        fileType: FileType.image,
      );
    } else if (_isWhatsAppBusiness) {
      flutterShareMe.shareToWhatsApp4Biz(
        msg: 'Check out this image from savvy status saver',
        imagePath: image,
      );
    } else if (_isWhatsApp && _isWhatsAppBusiness) {
      flutterShareMe.shareToWhatsApp(
        msg: 'Check out this image from savvy status saver',
        imagePath: image,
        fileType: FileType.image,
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
