import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shop/constants/text_formed_field_constants.dart';
import 'package:shop/providers/cart.dart';

class CartItem extends StatefulWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartItem(
    this.id,
    this.productId,
    this.price,
    this.quantity,
    this.title,
  );

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final cart = Provider.of<Cart>(context);
    return Dismissible(
        key: ValueKey(widget.id),
        background: Container(
          color: kPrimaryLightColor,
          child: Icon(
            Icons.delete,
            color: Colors.redAccent,
            size: 40,
          ),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20),
          margin: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 4,
          ),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          Provider.of<Cart>(context, listen: false)
              .removeItem(widget.productId);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 8.0,right: 10.0),
          child: Container(
            height: 120.0,
            width: screenSize.width,
            child: Row(
              children: [
                //container Holding Image
                Container(
                  height: 120.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: kPrimaryColor, width: 1)),
                  width: screenSize.width / 4 + 30,
                  child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: Image(
                              image: NetworkImage(
                                  "http://www.pngall.com/wp-content/uploads/2016/04/Tomato-Download-PNG.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                          Positioned(
                            top: 2.0,
                            right: 2.0,
                            child: Container(
                              color: kPrimaryColor,
                              child: Padding(
                                padding: const EdgeInsets.all(3),
                                child: Text(
                                  'ج.م ${widget.price}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10.0),
                                  textDirection: TextDirection.rtl,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),

                //Column Holding Product Details
                Container(
                  alignment: Alignment.topRight,
                  width: screenSize.width * 0.55,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Column(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 15.0, color: kPrimaryColor,fontFamily: "arab"),
                        ),
                        SizedBox(
                          height: 5.5,
                        ),
                   Row(
                   mainAxisAlignment: MainAxisAlignment.end,children: [

                     Text(
                         ' ${(widget.price * widget.quantity).toStringAsFixed(2)}'),
                     Text(
                         ' : الكلي', textAlign: TextAlign.right,
                       style: TextStyle(fontSize: 15.0, color: kPrimaryColor,fontFamily: "arab"),),
                   ],),
                        SizedBox(
                          height: 10.5,
                        ),
                        //container for counting
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border:
                                  Border.all(color: kPrimaryColor, width: 1),
                          color: kPrimaryLightColor),
                          height: 40.0,
                          width: 140,
                          // color: kPrimaryLightColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  color: Colors.green,
                                  icon: Icon(
                                    Icons.add,
                                    size: 20.0,
                                  ),
                                  onPressed: () {
                                    cart.addItem(widget.productId, widget.price,
                                        widget.quantity.toString());
                                  }),
                              Text(
                                "${widget.quantity}",
                                style: TextStyle(color: kPrimaryColor),
                              ),
                              IconButton(
                                  color: Colors.red,
                                  icon: Icon(
                                    Icons.remove,
                                    size: 20.0,
                                  ),
                                  onPressed: () {
                                    cart.removeSingleItem(widget.productId);
                                  }),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
