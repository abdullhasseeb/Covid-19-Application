import 'package:covid19_app/constants/constants.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String title;
  final onTap;
  ProfileCard({
    super.key,
    required this.title,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Ink(
        padding: EdgeInsets.symmetric(horizontal: 21,vertical: 21),
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  blurRadius: 7,
                  spreadRadius: 0,
                  offset: Offset(0, 1),
                  color: Colors.black.withOpacity(0.08))
            ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: poppinsFont.copyWith(
                  fontSize: 12,
                  color: blueColor
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_sharp,
              color: blueColor,
              size: 17,
            )
          ],
        ),
      ),
    );
  }
}
