import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FlayerSkin extends StatelessWidget {
  final String myTitle;
  final Widget myWidget;
  const FlayerSkin({Key? key, required this.myTitle, required this.myWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 14.0, right: 14.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 14.0, bottom: 6.0),
            width: size.width,
            child: Text(
              myTitle,
              style: GoogleFonts.roboto(
                fontSize: size.height * 0.02,
              ),
            ),
          ),
          Container(
            width: size.width,
            padding: const EdgeInsets.only(bottom: 15),
            child: myWidget,
          )
        ],
      ),
    );
  }
}
