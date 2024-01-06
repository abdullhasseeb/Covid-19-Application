import 'package:covid19_app/constants/constants.dart';
import 'package:flutter/material.dart';


class CustomTextField extends StatefulWidget {
  final String hint;
  final IconButton? suffixIcon;
  final TextEditingController controller;
  final bool isObsecure;

  const CustomTextField(
      {super.key,
        required this.controller,
        required this.hint,
        this.isObsecure = false,
        this.suffixIcon});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 1),
                blurRadius: 7,
                spreadRadius: 0,
                color: Colors.black.withOpacity(0.08))
          ]),
      child: TextFormField(
        style: poppinsFont.copyWith(fontSize: 12, color: Colors.grey.shade700),
        obscureText: widget.isObsecure,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 23),
            border: InputBorder.none,
            hintText: widget.hint,
            hintStyle: poppinsFont.copyWith(fontSize: 12, color: greyColor),
            suffixIcon: (widget.suffixIcon != null) ? widget.suffixIcon : null),
      ),
    );
  }
}
