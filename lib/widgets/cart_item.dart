import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

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
    final cart = Provider.of<Cart>(context);
    return Dismissible(
        key: ValueKey(widget.id),
        background: Container(
          color: Theme.of(context).errorColor,
          child: Icon(
            Icons.delete,
            color: Colors.white,
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
          Provider.of<Cart>(context, listen: false).removeItem(widget.productId);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Container(
            height: 120.0,
            child: Row(
              children: [
                Container(
                  width: 130,
                  child: Image(
                    image: NetworkImage(
                        "https://www.kclu.org/sites/kclu2/files/201808/STRAWBERRIEDS.jpg"),
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Column(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 18.0, color: Colors.red),
                      ),
                      SizedBox(
                        height: 5.5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '\$${widget.price}',
                            style: TextStyle(color: Colors.green),
                          ),
                          SizedBox(
                            width: 50.5,
                          ),
                          Text('الحساب الكلي: ${(widget.price * widget.quantity)}'),
                          SizedBox(
                            height: 6.5,
                          ),
                        ],
                      ),
                      Container(
                        height: 40.0,
                        width: 140,
                        color: Colors.grey.shade200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.add,
                                  size: 18.0,
                                ),
                                onPressed: () {
                                  cart.addItem(widget.productId, widget.price, widget.quantity.toString());
                                }),

                            Text("${widget.quantity}",style: TextStyle(color: Colors.red),),

                            IconButton(
                                icon: Icon(
                                  Icons.remove,
                                  size: 18.0,
                                ),
                                onPressed: () {

                                 cart.removeSingleItem(widget.productId);
                                }),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )

        );
  }
}
