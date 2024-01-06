import 'package:covid19_app/constants/constants.dart';
import 'package:covid19_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: <Widget>[
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05555556),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: height * 0.04375,),
                Center(
                  child: Text(
                    'Welcome',
                    style: poppinsFont.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.0125,),
                Text(
                  'Hey Joe, we are here to help you out.',
                  textAlign: TextAlign.center,
                  style: poppinsFont.copyWith(
                    fontSize: 10,
                    color: greyColor,
                  ),
                ),
                SizedBox(height: height * 0.025,),
                CustomButton(
                  tap: (){},
                  text: 'Report a case',
                  textColor: blueColor,
                  buttonHeight: 100,
                  firstWidget: Image.asset('assets/images/pcr_test.png',width: 35,height: 34,),
                ),
                SizedBox(height: height * 0.025,),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05555556,vertical: 10),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: width * 0.05555556,
              mainAxisSpacing: width * 0.05555556,
            ),
            delegate: SliverChildListDelegate(
              [
                CustomButton(
                  text: 'Covid-19\nStatistics',
                  tap: (){},
                  textColor: blueColor,
                  firstWidget: Image.asset('assets/images/combo_chart.png',height: 35,width: 35,),
                  isColumn: true,
                ),
                CustomButton(
                  text: 'Covid-19\nPreventions',
                  tap: (){},
                  textColor: blueColor,
                  firstWidget: Image.asset('assets/images/coronavirus.png',height: 35,width: 35),
                  isColumn: true,
                ),
                CustomButton(
                  text: 'Medical Centres',
                  tap: (){},
                  textColor: blueColor,
                  firstWidget: Image.asset('assets/images/hospital_room.png',height: 35,width: 35),
                  isColumn: true,
                ),
                CustomButton(
                  text: 'Covid-19 Symptoms',
                  tap: (){},
                  textColor: blueColor,
                  firstWidget: Image.asset('assets/images/syringe.png',height: 35,width: 35),
                  isColumn: true,
                ),
                CustomButton(
                  text: 'Online Support',
                  tap: (){},
                  textColor: blueColor,
                  firstWidget: Image.asset('assets/images/online_support.png',height: 35,width: 35),
                  isColumn: true,
                ),
                CustomButton(
                  text: 'Account Settings',
                  tap: (){},
                  textColor: blueColor,
                  firstWidget: Image.asset('assets/images/male_user.png',height: 35,width: 35),
                  isColumn: true,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
