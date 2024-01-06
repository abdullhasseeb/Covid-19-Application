import 'package:covid19_app/constants/constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color backgroundColor;
  final Icon? icon;
  final String text;
  final textFontWeight;
  final firstWidget;
  final Color textColor;
  final tap;
  final double buttonHeight;
  final bool isColumn;
  final double fontSize;
  CustomButton({
    super.key,
    this.backgroundColor = Colors.white,
    this.icon,
    required this.text,
    this.firstWidget,
    this.textColor = Colors.white,
    required this.tap,
    this.buttonHeight = 60,
    this.isColumn = false,
    this.fontSize = 12,
    this.textFontWeight = FontWeight.w600
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: tap,
      child: Ink(
        width: double.infinity,
        height: buttonHeight,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  blurRadius: 7,
                  spreadRadius: 0,
                  offset: Offset(0, 1),
                  color: Colors.black.withOpacity(0.08))
            ]
        ),
        child: isColumn ?
            // this is for icon and text in column-----------------------------
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (icon != null) ?
                Column(
                  children: [
                    icon!,
                    SizedBox(width: 20,)
                  ],
                ) :
                (firstWidget != null) ?
                Column(
                  children: [
                    firstWidget,
                    SizedBox(height: 18,)
                  ],
                ) :
                SizedBox(),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: poppinsFont.copyWith(
                      color: textColor,
                      fontSize: fontSize,
                      fontWeight: textFontWeight
                  ),
                )
              ],
            ) :
            // this is for icon and text in Row---------------------------------
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (icon != null) ?
                Row(
                  children: [
                    icon!,
                    SizedBox(width: 20,)
                  ],
                ) :
            (firstWidget != null) ?
                Row(
                  children: [
                    firstWidget,
                    SizedBox(width: 20,)
                  ],
                ) :
                SizedBox(),
            Text(
              text,
              textAlign: TextAlign.center,
              style: poppinsFont.copyWith(
                  color: textColor,
                  fontSize: fontSize,
                  fontWeight: textFontWeight
              ),
            )
          ],
        ),
      ),
    );
  }
}
