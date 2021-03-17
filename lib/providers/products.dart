import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './product.dart';

class Products with ChangeNotifier {
  final String authToken;
  final String userId;

  Products(this.authToken, this.userId, this._items);

  List<Product> _items = [
/*    Product(
      id: '1',
      title: 'فراولة',
      description: 'فواكة',
      price: 29.99,
      image: 'https://www.kclu.org/sites/kclu2/files/201808/STRAWBERRIEDS.jpg',
    ),
    Product(
      id: '2',
      title: 'عنب',
      description: 'A nice pair of trousers.',
      price: 59.99,
      image:
          'https://www.wcrf-uk.org/sites/default/files/Grape_A-Z%20Fruit10.jpg',
    ),
    Product(
      id: '3',
      title: 'تفاح',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      image: 'http://clipart-library.com/img/781326.png',
    ),
    Product(
      id: '4',
      title: 'موز',
      description: 'Prepare any meal you want.',
      price: 49.99,
      image:
          'https://spng.pngfind.com/pngs/s/18-188217_fruits-banana-png-transparent-png.png',
    ),


    Product(
      id: '5',
      title: 'كيوي',
      description: 'Prepare any meal you want.',
      price: 49.99,
      image:
      'https://images.immediate.co.uk/production/volatile/sites/30/2020/02/Kiwi-fruits-582a07b.jpg?quality=90&resize=960,872',
    ),
    Product(
      id: '6',
      title: 'موز',
      description: 'Prepare any meal you want.',
      price: 49.99,
      image:
      'https://www.wcrf-uk.org/sites/default/files/Honeydew_A-Z%20Fruit12.jpg',
    ),
    Product(
      id: '7',
      title: 'موز',
      description: 'Prepare any meal you want.',
      price: 49.99,
      image:
      'https://www.wcrf-uk.org/sites/default/files/Fig_A-Z%20Fruit.jpg',
    ),*/
  ];

  List<Product> get items {
    return [..._items];
  }

  Future<List<Product>> fetchItems(int index) async {
//_items.clear();
    String myUrl = "https://alma7al.herokuapp.com/api/v1/admins/$userId/categories/$index/items";
    try {
      var response = await http.get(myUrl, headers: {
        'Accept': '*/*',
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'keep-alive',
        'Content-Type': 'application/json',
      });
      print(json.decode(response.body));
      final extractedData = json.decode(response.body);

      final List<Product> loadedProducts = [];

      extractedData.forEach((productData) {
        loadedProducts.add(Product(
          id: productData['id'],
          title: productData['title'],
          price: double.parse(productData['price']),
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }


  Product findId(String id) {
    return _items.firstWhere((product) => product.id == int.parse(id));
  }
}
