import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  final String authToken;
  final String userId;

  Orders(this.authToken, this.userId, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
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
          amount: total,
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
    String url = "https://alma7al.herokuapp.com/api/v1/allorders";
    print(authToken);

    final response = await http.get(url);
    print(json.decode(response.body));

    final extractedData = json.decode(response.body) ;
    final List<OrderItem> loadedOrders = [];
    if (extractedData == null) {
      return;
    }

    extractedData.forEach((orderData) {
     // print(" id id $orderId");
      loadedOrders.add(
        OrderItem(
          id: orderData['id'].toString(),
          amount: double.parse(orderData['total']),
          dateTime: DateTime.parse(orderData['created_at']),
          products: (orderData['carts']  as List<dynamic> )
              .map(
                (item) => CartItem(
                id: 1,
                price: 12.0,
                quantity: 3,
                title: "hihihi",
               // imageUrl: item['imageUrl']
            ),
          ).toList(),
        ),
      );
    });
    _orders = loadedOrders;
    notifyListeners();
  }

//  Future<void> addOrder(List<CartItem> cartProducts) async {
//    final urlCart = 'https://alma7al.herokuapp.com/api/v1/users/1/orders';
//
//    final timestamp = DateTime.now();
//
//
//
//
//
//    final urlOrede = 'https://alma7al.herokuapp.com/api/v1/users/1/orders/15/carts';
//    final response = await http.post(
//        urlCart,
//      body: json.encode({
//        "cart": cartProducts
//            .map((cp) => {
//                  'item_id': 12,
//                  'qty': 12,
//                })
//            .toList(),
//      }),
//    headers: {
//              'Accept': '*/*',
//              'Accept-Encoding': 'gzip, deflate, br',
//              'Connection': 'keep-alive',
//              'Content-Type': 'application/json',
//              'Authorization': '$authToken'
//            }
//    );
//
//    print(json.encode(response.body));
// /*   _orders.insert(
//      0,
//      OrderItem(
//        id: json.decode(response.body)['name'],
//        amount: 550,
//        dateTime: timestamp,
//        products: cartProducts,
//      ),
//    );*/
//    notifyListeners();
//  }
}
