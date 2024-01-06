import 'package:covid19_app/constants/responsive_widget.dart';
import 'package:covid19_app/widgets/profile_settings_card.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

class Person extends StatefulWidget {
  const Person({super.key});

  @override
  State<Person> createState() => _PersonState();
}

class _PersonState extends State<Person> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05555556),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.04375,
            ),
            Center(
              child: Text(
                'Account Information',
                style: poppinsFont.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.0125,
            ),
            Text(
              'Explore and update information about your account',
              textAlign: TextAlign.center,
              style: poppinsFont.copyWith(
                fontSize: 10,
                color: greyColor,
              ),
            ),
            SizedBox(
              height: height * 0.025,
            ),
            CircleAvatar(
              radius: 65,
              backgroundImage: AssetImage('assets/images/profile.jpg'),
            ),
            SizedBox(height: height * 0.0125,),
            Container(
              height:ResponsiveWidget.isSmallScreen(context) ?  height * 0.041 : width * 0.041,
              width: ResponsiveWidget.isSmallScreen(context) ? height * 0.137 : width * 0.137,
              decoration: BoxDecoration(
                color: orangeColor,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Center(
                child: Text(
                  'Change photo',
                  style: poppinsFont.copyWith(
                    fontSize: 10,
                    color: Colors.white
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.025,
            ),
            ProfileCard(title: 'My account',onTap: (){},),
            SizedBox(height: 8,),
            ProfileCard(title: 'Notifications',onTap: (){},),
            SizedBox(height: 8,),
            ProfileCard(title: 'Settings',onTap: (){},),
            SizedBox(height: 8,),
            ProfileCard(title: 'Help Center',onTap: (){},),
            SizedBox(height: 8,),
            ProfileCard(title: 'Logout',onTap: (){},),
            SizedBox(height: 8,),
          ],
        ),
      ),
    );
  }
}
