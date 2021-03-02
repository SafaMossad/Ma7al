import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);

const kTextFieldDecoration = InputDecoration(

  //default shape mode
  //ده شكل الاطار الخارجي من قبل ما اضغط عليه هيكون عامل ازاي
  enabledBorder: OutlineInputBorder(
    borderSide:BorderSide(color: kPrimaryLightColor) ,
    borderRadius: BorderRadius.all(Radius.circular(25),),
    // borderSide: BorderSide(color: kPrimaryColor),
  ),

  //when click on text formed field
  //ده بقي لما اركز عليه واضغط عليه الشكل هيكون ايه
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(50)),
    borderSide: BorderSide(color: kPrimaryColor),
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(28)),

  ),

);

