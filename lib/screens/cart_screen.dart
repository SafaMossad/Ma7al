import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart' show Cart;
import '../providers/orders.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (ctx, i) => Column(
                      textDirection: TextDirection.ltr,
                      children: [
                        CartItem(
                          cart.items.values.toList()[i].id.toString(),
                          cart.items.keys.toList()[i],
                          cart.items.values.toList()[i].price,
                          cart.items.values.toList()[i].quantity,
                          cart.items.values.toList()[i].title,
                        ),
                        Divider(
                          color: Theme.of(context).primaryColor,
                        )
                      ],
                    )),
          ),

          Container(
            color: Colors.grey.shade200,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 12.0, right: 12.0),
                  child: Row(
                    children: [
                      Text('${cart.totalAmount.toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 20.0)),
                      Spacer(),
                      Text(
                        "الحساب الكلي:",
                        style: TextStyle(fontSize: 20.0),
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ),
                Card(
                  // color: Theme.of(context).primaryColor,
                  /*  child: InkWell(
                       // splashColor: Colors.blueGrey,
                        onTap: (cart.totalAmount <= 0 || _isLoading)
                            ? null
                            : () async {

                                await Provider.of<Orders>(context,
                                        listen: false)
                                    .addOrder(
                                  cart.items.values.toList(),
                                  cart.totalAmount,
                                );

                                Navigator.of(context).pushReplacementNamed('/');
                                cart.clear();
                              },
                        child: Container(
                          width: MediaQuery.of(context).size.width /2,
                          child: _isLoading
                              ? CircularProgressIndicator()
                              : Text(
                                  "أطلب الأن",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500),
                                ),
                        ),
                      ),*/
                  child: OrderButton(
                    cart: cart,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      splashColor: Theme.of(context).primaryColor,
      child: _isLoading
          ? CircularProgressIndicator()
          : Container(
              width: MediaQuery.of(context).size.width / 3,
              color: Colors.green,
              child: Text(
                'أطلب الأن',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<Orders>(context, listen: false).addOrder(
                widget.cart.items.values.toList(),
                widget.cart.totalAmount,
              );
              setState(() {
                _isLoading = false;
              });
              Navigator.of(context).pushReplacementNamed('/');
              widget.cart.clear();
            },
      textColor: Theme.of(context).primaryColor,
    );
  }
}
