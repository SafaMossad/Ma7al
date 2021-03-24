import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;
import 'package:shop/providers/cart.dart';

class OrderItem {
  final String id;
  final double total;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.total,
    @required this.products,
    @required this.dateTime,
  });
}

class InitialCartItem {
  final String id;
  final String description;
  final double total;
  final DateTime dateTime;

  InitialCartItem({
    @required this.id,
    @required this.description,
    @required this.total,
    @required this.dateTime,
  });
}




class Details {
  final String id;
  final int qty;
  final int itemId;
  final String title;
  final double price;

  Details({
    @required this.id,
    @required this.qty,
    @required this.itemId,
    @required this.title,
    @required this.price,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<InitialCartItem> _initialCart = [];
  List<Details> _details = [];


  final String authToken;
  final String userId;
  Orders(this.authToken, this.userId, this._orders);


  List<OrderItem> get orders {
    return [..._orders];
  }

  List<InitialCartItem> get initialCart {
    return [..._initialCart];
  }

  List<Details> get details {
    return [..._details];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final urlCart = 'https://alma7al.herokuapp.com/api/v1/users/$userId/orders';
    print(authToken);
    final timestamp = DateTime.now();
    try {
      final cartResponse = await http.post(urlCart,
          body: json.encode(
              {"describtion": "Fixed I will change it", "total": total}),
          headers: {
            'Accept': '*/*',
            'Accept-Encoding': 'gzip, deflate, br',
            'Connection': 'keep-alive',
            'Content-Type': 'application/json',
            'Authorization': '$authToken'
          });

      print(json.encode(cartResponse.body));
      var data = json.decode(cartResponse.body);
      var cartId = (data["id"].toString());
      print("Cart Id=$cartId");

      final urlOrder =
          'https://alma7al.herokuapp.com/api/v1/users/1/orders/$cartId/carts';
      final orderResponse = await http.post(urlOrder,
          body: json.encode({
            "cart": cartProducts
                .map((cp) => {
                      'item_id': cp.id,
                      'qty': cp.quantity,
                    })
                .toList(),
          }),
          headers: {
            'Accept': '*/*',
            'Accept-Encoding': 'gzip, deflate, br',
            'Connection': 'keep-alive',
            'Content-Type': 'application/json',
            'Authorization': '$authToken'
          });

      print(json.encode(orderResponse.body));

      _orders.insert(
        0,
        OrderItem(
          id: json.decode(cartResponse.body)['id'].toString(),
          total: total,
          dateTime: timestamp,
          products: cartProducts,
        ),
      );
      notifyListeners();
    } catch (error) {
      print(" Caught error=> $error");
      throw error;
    }
  }

  Future<void> fetchOrders() async {
    String url = "https://alma7al.herokuapp.com/api/v1/users/3/orders";
    print(authToken);

    final response = await http.get(url, headers: {
      'Accept': '*/*',
      'Accept-Encoding': 'gzip, deflate, br',
      'Connection': 'keep-alive',
      'Content-Type': 'application/json',
      'Authorization': '$authToken'
    });

    var data = json.decode(response.body);

    print(data);
    final extractedData = json.decode(response.body);
    final List<InitialCartItem> loadedOrders = [];
    if (extractedData == null) {
      return;
    }

    extractedData.forEach((orderData) {
      // print(" id id $orderId");
      loadedOrders.add(
        InitialCartItem(

          id: orderData['id'].toString(),
          total: double.parse(orderData['total']),
          dateTime: DateTime.parse(orderData['created_at']),
         description: orderData['describtion'],
        ),
      );
    });
    _initialCart = loadedOrders.reversed.toList();
    //notifyListeners();
  }


  Future<void> fetchOrdersDetails(int orderId) async {
    String url = "https://alma7al.herokuapp.com/api/v1/users/$userId/orders/$orderId/carts";
    print(authToken);

    final response = await http.get(url, headers: {
      'Accept': '*/*',
      'Accept-Encoding': 'gzip, deflate, br',
      'Connection': 'keep-alive',
      'Content-Type': 'application/json',
      'Authorization': '$authToken'
    });

    var data = json.decode(response.body);

    print(data);
    final extractedData = json.decode(response.body);
   // print(data[1]["item"]["title"]);
    final List<Details> loadedOrders = [];
    if (extractedData == null) {
      return;
    }

    extractedData.forEach((orderData) {
      // print(" id id $orderId");
      loadedOrders.add(
        Details(
          id: orderData["id"].toString(),
        qty: orderData["qty"],
        title: orderData["item"]["title"],
        price: double.parse(orderData["item"]["price"]),
        itemId:  orderData["item"]["id"],

        /*  id: orderData["item"]["category_id"].toString(),
           total: orderData["qty"].toDouble() ,
          dateTime: DateTime.parse(orderData['created_at']),
          */
        /* products: (orderData['item'] as List<dynamic>)
              .map(
                (item) => CartItem(
                  id: item["item"]["title"],
                 */

          /* price: double.parse(item["item"]["price"]),
                  quantity: int.parse(item["item"]["id"]),
                  title: item["item"]["title"].toString(),*//**//*
                  // imageUrl: item['imageUrl']
                )
              ).toList(),
*/
        ),
      );
    });
    _details = loadedOrders.reversed.toList();
    //notifyListeners();
    //_initialCart = loadedOrders.reversed.toList();
    //notifyListeners();
  }

}
