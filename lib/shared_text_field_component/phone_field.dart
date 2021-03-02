import 'package:flutter/material.dart';


import '../constants/text_formed_field_constants.dart';


class Phone extends StatelessWidget {
  final String label;
  final String hintTxt;
  final IconData icon;

  Phone({this.label, this.hintTxt, this.icon=Icons.phone_android});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 40.0,left: 40.0),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        validator: (value) {
          String errorMsg;
          if (value.isEmpty) {
            errorMsg = 'Your Phone is Empty';
          } else {
            return null;
          }
          return errorMsg;
        },
        //ده علشان اثبت التايتل والهينت في مكانه
        decoration: kTextFieldDecoration.copyWith(
         // floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: label,
          labelStyle: TextStyle(color: kPrimaryColor),
          hintText: hintTxt,
          prefixIcon: Padding(
            child: Icon(
              icon,color: kPrimaryColor,
            ),
            padding: EdgeInsets.fromLTRB(10, 20, 30, 20),

          ),
        ),
      ),);
  }
}
