import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shop/screens/details.dart';

import '../constants/text_formed_field_constants.dart';
import '../providers/cart.dart';
import '../providers/product.dart';

class ProductItem extends StatefulWidget {
  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Card(
        color: kPrimaryLightColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: kPrimaryColor, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: GestureDetector(
          onTap: () {
            /*  showModalBottomSheet(backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) {
                        final theme = Theme.of(context);

                        return Container(
                          height: screenHeight,
                          decoration: BoxDecoration(
                              color: kPrimaryLightColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25.0),
                                  topRight: Radius.circular(25.0))),
                          child: Column(
                            children: [
                              Container(
                                  height: 50.0,
                                  width: 150.0,
                                  child: Image(
                                    image: NetworkImage(
                                        "http://pngimg.com/uploads/carrot/carrot_PNG4993.png"),
                                    fit: BoxFit.scaleDown,
                                  )),
                              Row(
                                children: [

                                  Text(
                                    product.title,
                                    textAlign: TextAlign.center,
                                  ),
                                  Text("\$" + "${product.price}"),
                                ],
                              )
                            ],
                          )
                        );
                      });*/

            Navigator.of(context).pushNamed(ProductDetails.routeName,
                arguments: product.id.toString());
          },
          child: Container(
            padding: EdgeInsets.only(right: 10.0),
            height: 150,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                      height: 100.0,
                      width: 150.0,
                      child: Image(
                        image: NetworkImage(
                            "http://www.pngall.com/wp-content/uploads/2016/04/Tomato-Download-PNG.png"),
                        fit: BoxFit.scaleDown,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 105.0),
                  child: Container(
                      height: 120.0,
                      width: double.infinity,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                product.title,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 17.0),
                              ),
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                "\$" + "${product.price}",
                                style: TextStyle(fontSize: 15.0),
                              )),
                          SizedBox(height: 5.0),
                        ],
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 170.0, left: 5.0),
                  child: Container(
                      alignment: Alignment.center,
                      height: 30.0,
                      width: 200.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: kPrimaryColor),
                      child: Center(
                        child: FlatButton(
                            onPressed: () {
                              cart.addItem(product.id.toString(), product.price,
                                  product.title);
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
                                      cart.removeSingleItem(
                                          product.id.toString());
                                    },
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              'أضف الي العربة',
                              style: GoogleFonts.bigShouldersText(
                                  color: Colors.white, fontSize: 12.0),
                            )),
                      )),
                )
              ],
            ),
          ),
        )

        /*GridTile(
            child: GestureDetector(
                onTap: () {
                */
        /*  showModalBottomSheet(backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) {
                        final theme = Theme.of(context);

                        return Container(
                          height: screenHeight,
                          decoration: BoxDecoration(
                              color: kPrimaryLightColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25.0),
                                  topRight: Radius.circular(25.0))),
                          child: Column(
                            children: [
                              Container(
                                  height: 50.0,
                                  width: 150.0,
                                  child: Image(
                                    image: NetworkImage(
                                        "http://pngimg.com/uploads/carrot/carrot_PNG4993.png"),
                                    fit: BoxFit.scaleDown,
                                  )),
                              Row(
                                children: [

                                  Text(
                                    product.title,
                                    textAlign: TextAlign.center,
                                  ),
                                  Text("\$" + "${product.price}"),
                                ],
                              )
                            ],
                          )
                        );
                      });*/
        /*
                   Navigator.of(context)
                      .pushNamed(ProductDetails.routeName, arguments: product.id.toString());
                },
                child:),
            */
        /*footer: GridTileBar(
              subtitle: Text("\$" + "${product.price}"),
              backgroundColor: Colors.black87,
              */
        /*
            */
        /*    leading: Consumer<Product>(
                builder: (ctx ,product ,child)=> IconButton(
                  icon: Icon(
                  product.isFavourite? Icons.favorite : Icons.favorite_border,
                    color: Colors.redAccent,
                  ),
                  color: Theme.of(context).accentColor,
                  onPressed: () {product.toggleFavorite();},
                ),
              ),*/ /*
            */
              /*
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
            ),*/
              /*
          ),*/

        );
  }
}
