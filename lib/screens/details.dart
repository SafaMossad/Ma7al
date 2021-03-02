import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../constants/color_palette.dart';

class ProductDetails extends StatelessWidget {
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    final productId = ModalRoute.of(context).settings.arguments as String;
    final product = Provider.of<Products>(context).findId(productId);
    return Scaffold(
        body: Stack(children: [
      Container(
          height: screenHeight, width: screenWidth, color: Colors.transparent),
      Container(
          height: screenHeight,
          width: screenWidth,
          color: ColorPalette().leftBarColor),
      Container(
          height: screenHeight / 2,
          width: screenWidth,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
              ),
              color: Colors.white)),
      Container(
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
              color: Colors.white.withOpacity(0.6))),
      Container(
          height: (screenHeight / 4 + 25.0),
          width: screenWidth,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
              ),
              color: Colors.lightGreen.withOpacity(0.9))),
      Positioned(
          top: 25.0,
          left: 20.0,
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Feather.arrow_left_circle,
              size: 40.0,
            ),
            color: Colors.white,
          )),
      Positioned(
          top: 25.0,
          right: 20.0,
          child: Icon(
            Feather.shopping_cart,
            size: 40.0,
            color: Colors.white,
          )),
      Positioned(
          top: (screenHeight / 4 - 100.0),
          left: screenWidth / 4,
       /*   child: Hero(
              tag: product.image,
              child: Image(
                  image: NetworkImage(product.image),
                  height: 175.0,
                  width: 175.0,
                  fit: BoxFit.cover))*/),
      Positioned(
          top: (screenHeight / 4) + 85.0,
          left: screenWidth / 7,
          child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Text(
                  product.title,
                  style: GoogleFonts.bigShouldersText(
                      color: Color(0xFF23163D), fontSize: 24.0),
                ),
                SizedBox(height: 10.0),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(Feather.user),
                  SizedBox(width: 10.0),
                  Text(
                    '1.5k',
                    style: GoogleFonts.bigShouldersText(
                        color: ColorPalette().firstSlice, fontSize: 20.0),
                  ),
                  SizedBox(width: 15.0),
                  Container(width: 1.0, height: 20.0, color: Colors.grey),
                  SizedBox(width: 15.0),
                  //Repeat the same block as above
                  Icon(Feather.star),
                  SizedBox(width: 15.0),
                  Text(
                    '4.0',
                    style: GoogleFonts.bigShouldersText(
                        color: ColorPalette().firstSlice, fontSize: 20.0),
                  ),
                  SizedBox(width: 15.0),
                  Container(
                    width: 1.0,
                    height: 20.0,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 15.0),
                  Icon(Feather.anchor),
                  SizedBox(width: 15.0),
                  Text(
                    'No. 1',
                    style: GoogleFonts.bigShouldersText(
                        color: ColorPalette().firstSlice, fontSize: 20.0),
                  ),
                ])
              ]))),
      Positioned(
          top: screenHeight / 2 + 10.0,
          left: 25.0,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'About Us',
              style: GoogleFonts.bigShouldersText(
                  color: Color(0xFF23163D), fontSize: 30.0),
            ),
            SizedBox(height: 10.0),
            Container(
              width: screenWidth - 40.0,
              child: Text(
                'Cold brewed with chicory and a unique blend of spices for 20 hours, our concentrate is velvety-smooth and packed with flavor.',
                style: GoogleFonts.bigShouldersText(
                    color: Color(0xFFB5ABB8), fontSize: 15.0),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
                height: 150.0,
                width: screenWidth,
                child: ListView(scrollDirection: Axis.horizontal, children: [
                  buildOneItem('\$65'),
                  SizedBox(width: 20.0),
                  buildOneItem('\$120.0'),
                  SizedBox(width: 20.0)
                ])),
            Row(children: [
              Container(
                  height: 50.0,
                  width: 225.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: ColorPalette().buttonColor),
                  child: Center(
                    child: FlatButton(
                        onPressed: () => {print("hahha")},
                        child: Text(
                          'BUY NOW',
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
                      border: Border.all(
                          color: ColorPalette().buttonColor, width: 2.0)),
                  child: Center(child: Icon(Feather.bookmark, size: 17.0)))
            ])
          ]))
    ]));
  }

  buildOneItem(price) {
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
/*      Positioned(
          right: 5.0,
          child: Container(
              height: 100.0,
              width: 100.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(title,), fit: BoxFit.cover)))),*/
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
  }
}