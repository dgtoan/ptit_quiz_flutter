import 'package:flutter/material.dart';

class PtitLogo extends StatelessWidget {
  final double width;
  final double height;
  
  const PtitLogo({super.key, this.width = 160, this.height = 160});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/ptit_logo.png',
      width: width,
      height: height,
    );
  }
}