import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../constants/responsive_widget.dart';

class DataCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final double cardWidth;
  final double cardHeight;
  final Color textColor;
  final double titleSize;
  final double valueSize;
  DataCard({
    super.key,
    required this.title,
    required this.value,
    this.color = Colors.white,
    required this.cardWidth,
    required this.cardHeight,
    this.textColor = Colors.white,
    this.titleSize = 15,
    this.valueSize = 20
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      height: cardHeight,
      width: cardWidth,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                blurRadius: 7,
                spreadRadius: 0,
                offset: Offset(0, 1),
                color: Colors.black.withOpacity(0.08))
          ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: poppinsFont.copyWith(
                fontSize: titleSize, fontWeight: FontWeight.bold, color: textColor),
          ),
          Text(
            value,
            style: poppinsFont.copyWith(fontSize: valueSize, color: textColor),
          )
        ],
      ),
    );
  }
}
