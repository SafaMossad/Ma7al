import 'package:flutter/material.dart';
/*import 'package:flutter_svg/svg.dart';
import 'package:shop/components/text_field_container.dart';
import 'package:shop/text_formed_field_constants.dart';*/

import '../constants/text_formed_field_constants.dart';
import '../constants/text_formed_field_constants.dart';
import '../constants/text_formed_field_constants.dart';

class EmailField extends StatelessWidget {
  final String label;
  final String hintTxt;
  final IconData icon;

  EmailField({this.label, this.hintTxt, this.icon=Icons.person});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 40.0,left: 40.0),
      child: TextFormField(
      validator: (String value) {
        String errorMsg;
        if ((value.isEmpty || !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r"*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9]"
        r"(?:[a-z0-9-]*[a-z0-9])?").hasMatch(value))){
          errorMsg = 'Invalid Email or Password';
        } else {
          return null;
        }
        return errorMsg;
      },

      decoration: kTextFieldDecoration.copyWith(

        //ده علشان اثبت التايتل والهينت في مكانه واشوف بقي انا محتاج الشكل بتاعهم هيكون ايه وهل هخلي ال label فوق ولا في نص التيكيست فيلد وكدا
        //floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: label,
        labelStyle: TextStyle(color: kPrimaryColor),
        hintText: hintTxt,
        prefixIcon: Padding(
          child: Icon(
            icon,color: kPrimaryColor,
          ),
          padding: EdgeInsets.fromLTRB(0, 20, 0, 20),

        ),
      ),
    ),);
  }
}
