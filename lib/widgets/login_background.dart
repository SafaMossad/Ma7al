import 'package:flutter/material.dart';

import '../constants/text_formed_field_constants.dart';
/*import 'package:shop/constants/color_palette.dart';

import '../../../text_formed_field_constants.dart';*/

class Background extends StatelessWidget {
  final Widget child;
  Background({@required this.child,});

  //final colorPalette = ColorPalette();

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Container(

      //color: colorPalette.leftBarColor,
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[

          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/images/main_top.png",
              width: size.width * 0.35,
            ),
          ),

          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "assets/images/login_bottom.png",
              width: size.width * 0.4,
            ),
          ),

          SizedBox(height: 50.0),
          child,
        ],
      ),
    );
  }
}
