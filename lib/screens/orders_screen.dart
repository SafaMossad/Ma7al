import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shop/constants/text_formed_field_constants.dart';
import 'package:shop/widgets/loading.dart';
import 'package:shop/widgets/order_item.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      backgroundColor: kPrimaryLightColor,
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text('طلباتك'),
        ),
        body:
            /*ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
      ),*/
            FutureBuilder(
          future: Provider.of<Orders>(context, listen: false).fetchOrders(),
          builder: (ctx, data) {
            if(data.connectionState == ConnectionState.waiting){
              print("waiting");
              return
                  Center(child: LoadingSpinner());

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
                    itemCount: orderData.initialCart.length,
                    itemBuilder: (ctx, i) => OrderItem(orderData.initialCart[i]),
                  ),
                );
              }
            }
            }

        ));
  }
}
