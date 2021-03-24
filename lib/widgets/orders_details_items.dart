import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/screens/order_details_screen.dart';

import '../providers/orders.dart' as ord;

class OrderDetailsItem extends StatefulWidget {
  final ord.Details order;

  OrderDetailsItem(this.order);

  @override
  _OrderDetailsItemState createState() => _OrderDetailsItemState();
}

class _OrderDetailsItemState extends State<OrderDetailsItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    //final cart = Provider.of<CartItem>(context);

    print(('${widget.order.price}'));
    return GestureDetector(
      onTap: () {


      /*  Navigator.of(context).pushNamed(OrderDetails.routeName,
            arguments: widget.order.id.toString());*/
      },

      child: Card(
        margin: EdgeInsets.all(10),
        child: Column(

          children: <Widget>[

            ListTile(
              title: Text('id:${widget.order.id}   ج.م  +${widget.order.price}'),
              subtitle: Text('item ID:${widget.order.itemId} + Quantity:${widget.order.qty}'),
              trailing: Text('  ${widget.order.title}'),
            )
          ],
        ),
      ),
    );
  }
}
