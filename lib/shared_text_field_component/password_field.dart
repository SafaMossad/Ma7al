import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


import '../constants/text_formed_field_constants.dart';


class PasswordField extends StatefulWidget {
  final String label;
  final String hintTxt;
  final IconData icon;

  PasswordField({this.label, this.hintTxt, this.icon=Icons.lock});

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  String errorMsg(String str) {
    switch (widget.hintTxt) {
      case 'Enter Your Password':
        return 'Invalid Email or Password';
    }
    return null;
  }
  bool isVisible = false;

  @override
  void initState() {
    isVisible = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 40.0,left: 40.0),
       child:  TextFormField(
         validator: (value) {
           if (value.isEmpty || value.length < 6) {
             return errorMsg(widget.hintTxt);
           } else {
             return null;
           }
         },
         obscureText: isVisible && widget.hintTxt == 'Enter Your Password' ? true : false,
         decoration: kTextFieldDecoration.copyWith(
         //  floatingLabelBehavior: FloatingLabelBehavior.always,
           labelText: widget.label,
           labelStyle: TextStyle(color: kPrimaryColor),
           hintText: widget.hintTxt,
           prefixIcon: Padding(
             padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
             child: Icon(
               widget.icon,color: kPrimaryColor,
             ),
           ),
           suffixIcon: isVisible && widget.hintTxt == 'Enter Your Password'
               ? IconButton(
             icon: Icon(Icons.visibility_off),
             color: Colors.black,
             onPressed: () {
               setState(() {
                 isVisible = false;
               });
             },
           )
               : IconButton(
               icon: Icon(Icons.visibility),
               color: Colors.black,
               onPressed: () {
                 setState(() {
                   isVisible = true;
                 });
               }),
         ),
       ),
    );
  }
}
