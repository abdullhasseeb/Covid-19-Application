import 'package:covid19_app/constants/constants.dart';
import 'package:covid19_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_button.dart';

class SignUpForm extends StatefulWidget {
  SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  TextEditingController nameController = TextEditingController();
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
          'Name',
          style:
          poppinsFont.copyWith(fontSize: 12, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: height * 0.01,
        ),
        // Name TextField-------------------------------------------------
        CustomTextField(
          hint: 'Name',
          controller: nameController,
        ),
        SizedBox(
          height: height * 0.01,
        ),
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
          text: 'Sign up',
          backgroundColor: blueColor,
          tap: (){},
        ),
        SizedBox(height: height * 0.01,),

      ],
    );
  }
}
