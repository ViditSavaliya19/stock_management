import 'package:flutter/material.dart';

class ResponsiveText extends StatelessWidget {
  final String text;
  final double mobileFontSize;
  final double webFontSize;

  ResponsiveText(this.text,{
    this.mobileFontSize = 16,
    this.webFontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Text(
      text,
      style: TextStyle(
        fontSize: screenWidth < 600 ? mobileFontSize : webFontSize,
      ),
    );
  }
}
