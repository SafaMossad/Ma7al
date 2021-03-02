import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/product.dart';
import '../screens/details.dart';

class ProductItem extends StatefulWidget {
  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(ProductDetails.routeName, arguments: product.id);
            },
            child: Container(
                height: 250.0,
                width: 150.0,
                child: Image(
                  image: NetworkImage(
                      "http://pngimg.com/uploads/carrot/carrot_PNG4993.png"),
                  fit: BoxFit.scaleDown,
                ))),
        footer: GridTileBar(
          subtitle: Text("\$" + "${product.price}"),
          backgroundColor: Colors.black87,
          /*    leading: Consumer<Product>(
            builder: (ctx ,product ,child)=> IconButton(
              icon: Icon(
              product.isFavourite? Icons.favorite : Icons.favorite_border,
                color: Colors.redAccent,
              ),
              color: Theme.of(context).accentColor,
              onPressed: () {product.toggleFavorite();},
            ),
          ),*/
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              cart.addItem(product.id.toString(), product.price, product.title);
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Added item to cart!',
                  ),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      cart.removeSingleItem(product.id.toString());
                    },
                  ),
                ),
              );
            },
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
