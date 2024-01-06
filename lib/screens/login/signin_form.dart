import 'package:covid19_app/constants/constants.dart';
import 'package:covid19_app/screens/home_screen.dart';
import 'package:covid19_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_button.dart';

class SignInForm extends StatefulWidget {
  SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passController = TextEditingController();
  bool isObsecure = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email',
          style:
              poppinsFont.copyWith(fontSize: 12, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: height * 0.01,
        ),
        //Email TextField--------------------------------------------
        CustomTextField(
          hint: 'E-mail / Username',
          controller: emailController,
        ),
        SizedBox(
          height: height * 0.01,
        ),
        Text(
          'Password',
          style:
              poppinsFont.copyWith(fontSize: 12, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: height * 0.01,
        ),
        // Password TextField----------------------------------------
        CustomTextField(
          isObsecure: isObsecure,
          controller: passController,
          hint: 'Password',
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isObsecure = !isObsecure;
                  print(isObsecure);
                });
              },
              icon: isObsecure
                  ? Icon(Icons.visibility_off)
                  : Icon(
                      Icons.visibility,
                      color: greyColor,
                    )),
        ),
        SizedBox(height: height * 0.03,),
        // SignIn Button------------------------------------------------
        CustomButton(
          text: 'Sign in',
          backgroundColor: blueColor,
          tap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
          },
        ),
        SizedBox(height: height * 0.01,),
      ],
    );
  }
}
