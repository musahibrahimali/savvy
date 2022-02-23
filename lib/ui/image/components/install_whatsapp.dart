import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InstallWhatsApp extends StatelessWidget {
  const InstallWhatsApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Install WhatsApp\n",
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.raleway(
            fontSize: 22.0,
            color: Colors.teal,
            fontWeight: FontWeight.w900,
          ),
        ),
        Text(
          "Your Friend's Status Will Be Available Here",
          maxLines: 3,
          textAlign: TextAlign.center,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          strutStyle: const StrutStyle(
            forceStrutHeight: true,
            height: 3.0,
          ),
          style: GoogleFonts.poppins(
            fontSize: 44.0,
          ),
        ),
      ],
    );
  }
}
