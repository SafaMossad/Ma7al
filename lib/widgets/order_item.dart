import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:shop/constants/text_formed_field_constants.dart';
import 'package:shop/screens/order_details_screen.dart';

import '../providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.InitialCartItem order;

  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(OrderDetails.routeName,
            arguments: widget.order.id.toString());
      },
      child: Card(

        margin: EdgeInsets.all(10),shape: Border.all(
        color: kPrimaryColor,
        style: BorderStyle.solid
      ),
        child: Column(
          children: <Widget>[
            ListTile(

              title:  Text(
                DateFormat('h:mm :a').format(widget.order.dateTime),
                style: TextStyle(fontSize: 15.0,color: Colors.black87),
              ),
              subtitle: Center(child: Text(DateFormat('dd/MM/yyyy').format(widget.order.dateTime),)),
              trailing: Text('${widget.order.total} ج.م' ,style: TextStyle(fontSize: 13.0),),
            )
          ],
        ),
      ),
    );
  }
}
