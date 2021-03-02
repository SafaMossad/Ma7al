import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryItem {
  final int id;
  final String title;

  CategoryItem({@required this.id, @required this.title});
}

class Category with ChangeNotifier {
  List<CategoryItem> _category = [];
  final String authToken;
  final String userId;

  Category(this.authToken, this.userId, this._category);

  List<CategoryItem> get category {
    return [..._category];
  }

  Future<List<CategoryItem>> fetchItems() async {
    String myUrl = "https://alma7al.herokuapp.com/api/v1/admins/$userId/categories";
    try {
      var response = await http.get(myUrl, headers: {
        'Accept': '*/*',
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'keep-alive',
        'Content-Type': 'application/json',
      });
      print(json.decode(response.body));
      final extractedData = json.decode(response.body);
      print("data data $extractedData");

      final List<CategoryItem> loadedCategory = [];

      extractedData.forEach((productData) {
        loadedCategory.add(CategoryItem(
          id: productData['id'],
          title: productData['title'],
        ));
      });
      _category = loadedCategory;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
