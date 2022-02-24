import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:status_saver/core/core.dart';

class NoVideosToShow extends StatelessWidget {
  const NoVideosToShow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
