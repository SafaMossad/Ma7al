import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shop/constants/text_formed_field_constants.dart';

import '../constants/color_palette.dart';
import '../providers/products.dart';

class ProductDetails extends StatelessWidget {
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    final productId = ModalRoute.of(context).settings.arguments as String;
    final product = Provider.of<Products>(context).findId(productId);
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.only(bottom: 15.0),
            child: Text(
              "التفاصيل",
              style: TextStyle(fontFamily: ("arab"), fontSize: 35.0),
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Stack(children: [
              Container(
                  height: (screenHeight / 2) - 50,
                  width: screenWidth,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50.0),
                        bottomLeft: Radius.circular(50.0),
                      ),
                      color: kPrimaryLightColor)),
//for backGround Photo
/*      Container(
          height: (screenHeight / 4 + 25.0),
          width: screenWidth,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
              ),
              image: DecorationImage(
                  image: AssetImage('assets/doodle.png'), fit: BoxFit.none))),
          Container(
              height: (screenHeight / 4 + 25.0),
              width: screenWidth,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                  ),
                  color: Colors.green)),*/
              Container(
                  height: (screenHeight / 4),
                  width: screenWidth,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0),
                      ),
                      color: kPrimaryColor.withOpacity(0.2)),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Hero(
                        tag: NetworkImage(
                            "http://www.pngall.com/wp-content/uploads/2016/04/Tomato-Download-PNG.png"),
                        child: Image(
                          image: NetworkImage(
                              "http://www.pngall.com/wp-content/uploads/2016/04/Tomato-Download-PNG.png"),
                          height: 100.0,
                          width: 175.0,
                        )),
                  )),

//for center photo
/*      Positioned(
          top: (screenHeight / 4 - 100.0),
          left: screenWidth / 4,
          child: Hero(
              tag:  NetworkImage(
                  "http://www.pngall.com/wp-content/uploads/2016/04/Tomato-Download-PNG.png"),
              child: Image(
                  image: NetworkImage("http://www.pngall.com/wp-content/uploads/2016/04/Tomato-Download-PNG.png"),
                  height: 175.0,
                  width: 175.0,
                  fit: BoxFit.cover))),*/

              Positioned(
                  top: (screenHeight / 4) + 20,
                  left: screenWidth / 7,
                  child: Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        Text(
                          product.title,
                          style: TextStyle(
                              fontFamily: ("arab"),
                              color: Colors.black,
                              fontSize: 30.0),
                        ),
                        SizedBox(height: 15.0),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Feather.user),
                              SizedBox(width: 10.0),
                              Text(
                                '5.5k',
                                style: GoogleFonts.bigShouldersText(
                                    color: kPrimaryColor,
                                    fontSize: 20.0),
                              ),
                              SizedBox(width: 15.0),
                              Container(
                                  width: 1.0, height: 20.0, color: Colors.grey),
                              SizedBox(width: 15.0),
                              //Repeat the same block as above
                              Icon(Feather.star),
                              SizedBox(width: 15.0),
                              Text(
                                '4.0',
                                style: GoogleFonts.bigShouldersText(
                                    color: kPrimaryColor,
                                    fontSize: 20.0),
                              ),
                              SizedBox(width: 15.0),
                              Container(
                                width: 1.0,
                                height: 20.0,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 15.0),
                              Icon(Icons.attach_money),
                              SizedBox(width: 4.0),
                              Text(
                                product.price.toString(),
                                style: GoogleFonts.bigShouldersText(
                                    color: kPrimaryColor,
                                    fontSize: 20.0),
                              ),
                            ])
                      ]))),
            ]),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(children: [
                Container(
                  alignment: Alignment.topRight,
                  child: Text(
                    'ملاحظات',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontFamily: ("arab"), fontSize: 35.0),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  width: screenWidth - 40.0,
                  child: Text(
                    'يصلح للتخزين ويحفظ في درجة حرارة اقل من "18" ويجب ان يجفف قبل التخزين',
                    style: GoogleFonts.italianno(
                        color: kPrimaryColor.withOpacity(0.6), fontSize: 22.0),
                    textDirection: TextDirection.rtl,
                  ),
                ),
                SizedBox(height: 30.0),
//for adding suggestion items
/*                    Container(
                          height: 150.0,
                          width: screenWidth,
                          child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                buildOneItem('\$65'),
                                SizedBox(width: 20.0),
                                buildOneItem('\$120.0'),
                                SizedBox(width: 20.0)
                              ])),*/
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          height: 50.0,
                          width: 225.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: kPrimaryColor),
                          child: Center(
                            child: FlatButton(
                                onPressed: () => {print("hahha")},
                                child: Text(
                                  'أضف الي العربة',
                                  style: GoogleFonts.bigShouldersText(
                                      color: Colors.white, fontSize: 20.0),
                                )),
                          )),
                      SizedBox(width: 25.0),
                      Container(
                          height: 50.0,
                          width: 50.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border:
                                  Border.all(color: kPrimaryColor, width: 2.0)),
                          child: Center(
                              child: Icon(Icons.favorite_border, size: 20.0)))
                    ])
              ]),
            ),
          ],
        ));
  }

//for adding suggestion items
/*  buildOneItem(price) {
    return Stack(children: [
      Container(height: 125.0, width: 200.0, color: Colors.transparent),
      Positioned(
          top: 50.0,
          child: Container(
            height: 75.0,
            width: 200.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 4.0,
                      spreadRadius: 2.0,
                      color: Colors.grey.withOpacity(0.2))
                ],
                color: Colors.white),
          )),
      Positioned(
          right: 5.0,
          child: Container(
              height: 100.0,
              width: 100.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(title,), fit: BoxFit.cover)))),
      Positioned(
          left: 10.0,
          top: 60.0,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              price,
              style: GoogleFonts.bigShouldersText(
                  color: ColorPalette().firstSlice, fontSize: 25.0),
            ),
            Text(
              'COLD BREW KIT',
              style: GoogleFonts.bigShouldersText(
                  color: Color(0xFF23163D), fontSize: 20.0),
            )
          ]))
    ]);
  }*/
}
