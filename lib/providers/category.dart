//import 'dart:convert';
//
//import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
//class CategoryTitle with ChangeNotifier {
//  final int id;
//  final String title;
//
//  CategoryTitle({@required this.id, @required this.title});
//}
//
//class Category with ChangeNotifier{
//  List<Category> _category=[];
//
//  List<Category> get category{
//    return[..._category];
//  }
//
//
//  Future<List<Category>> fetchItems() async {
//    String myUrl = "https://alma7al.herokuapp.com/api/v1/users/1/categories";
//    try {
//      var response = await http.get(myUrl, headers: {
//        'Accept': '*/*',
//        'Accept-Encoding': 'gzip, deflate, br',
//        'Connection': 'keep-alive',
//        'Content-Type': 'application/json',
//      });
//      print(json.decode(response.body));
//      final extractedData = json.decode(response.body);
//
//      final List<Category> loadedProducts = [];
//
//      extractedData.forEach((productData) {
//        loadedProducts.add(Category(
//          id: productData['id'],
//          title: productData['title'],
//        ));
//      });
//      _category = loadedProducts;
//      notifyListeners();
//    } catch (error) {
//      throw error;
//    }
//  }
//}