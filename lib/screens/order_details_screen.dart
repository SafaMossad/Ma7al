import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/orders.dart';
import 'package:shop/widgets/app_drawer.dart';
import 'package:shop/widgets/loading.dart';
import 'package:shop/widgets/orders_details_items.dart';

class OrderDetails extends StatelessWidget {
  static const routeName = '/order-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    //final product = Provider.of<OrderItem>(context).findId(productId);
    return Scaffold(

        appBar: AppBar(
          title: Text('تفاصيل الطلب'),
        ),
        body:
        /*ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
      ),*/
        FutureBuilder(
            future: Provider.of<Orders>(context, listen: false).fetchOrdersDetails(int.parse(productId)),
            builder: (ctx, data) {
              if(data.connectionState == ConnectionState.waiting){
                print("waiting");
                return  Center(child: LoadingSpinner());
              }
              else{

                if (data.hasError) {
                  print("error snap  error ${data.error}");
                  return Center(
                    child: Text('An error occurred!'),
                  );
                } else {
                  print("success ${data}");
                  return Consumer<Orders>(
                    builder: (ctx, orderData, child) => ListView.builder(
                      itemCount: orderData.details.length,
                      itemBuilder: (ctx, i) => OrderDetailsItem(orderData.details[i]),
                    ),
                  );
                }
              }
            }

        ));
  }
}
