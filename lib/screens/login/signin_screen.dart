import 'package:covid19_app/constants/constants.dart';
import 'package:covid19_app/constants/responsive_widget.dart';
import 'package:covid19_app/screens/login/signin_form.dart';
import 'package:covid19_app/screens/login/signup_screen.dart';
import 'package:covid19_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_animation_icon.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController =
      AnimationController(vsync: this, duration: Duration(seconds: 20))
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    print(width);
    return Scaffold(
      body: Row(
        children: [
          ResponsiveWidget.isSmallScreen(context)
              ? SizedBox()
              : Expanded(
                  child: Container(
                  child: CustomAnimatedIcon(
                    animationController: animationController,
                  ),
                  decoration: BoxDecoration(color: orangeColor),
                )),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top:  height * 0.08),
                    child: Center(
                      child: Text('Login',
                          style: poppinsFont.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  // Facebook Button---------------------------------
                  Padding(
                    padding: getPadding(),
                    child: CustomButton(
                      backgroundColor: orangeColor,
                      text: 'Continue with Facebook',
                      icon: Icon(
                        Icons.facebook,
                        size: 28,
                        color: Colors.white,
                      ),
                      tap: (){},
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  //Google Button-------------------------------------------
                  Padding(
                    padding: getPadding(),
                    child: CustomButton(
                      text: 'Continue with Google',
                      textColor: blackColor,
                      firstWidget: Image.asset(
                        'assets/images/google.png',
                        height: 24,
                        width: 24,
                      ),
                      tap:(){}
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Text(
                    'OR',
                    style: poppinsFont.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: greyColor),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  //------------------------------------------------------
                  Padding(
                    padding: getPadding(),
                    child: SignInForm(),
                  ),
                  // Forgot Button-----------------------------------------
                  Padding(
                    padding: getPadding(),
                    child: CustomButton(
                      text: 'Forgot password',
                      textColor: blackColor,
                      tap: (){},
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  // Sign up Text-----------------------------------------
                  Padding(
                    padding: EdgeInsets.only(bottom: height * 0.03),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Didn't have account? ",
                            style: poppinsFont.copyWith(
                              fontSize: 12,
                              color: greyColor
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              animationController.stop();
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpScreen(),));
                            },
                            child: Text(
                              'Sign up',
                              style: poppinsFont.copyWith(
                                fontSize: 12,
                                color: blueColor,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          )
                        ],
                      )
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  EdgeInsets getPadding(){
    // give separate padding wrna shadow sahi se show nhi hota..
    // left or right se line ki tarah ajata
    double height = MediaQuery.of(context).size.height;
    return EdgeInsets.symmetric(horizontal: ResponsiveWidget.isSmallScreen(context) ? 20 : height * 0.1,);
  }
}
