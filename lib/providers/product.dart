import 'package:flutter/widgets.dart';

class Product with ChangeNotifier {
  final int id;
  final String title;
  final double price;



  Product({@required this.id,
      @required this.title,
      @required this.price,
   });

}
