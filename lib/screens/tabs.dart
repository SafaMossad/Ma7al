import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/constants/text_formed_field_constants.dart';

import '../providers/cart.dart';
import '../providers/category.dart';
import '../providers/products.dart';
import '../screens/cart_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/badge.dart';
import '../widgets/product_item.dart';

class Tabs extends StatefulWidget {
  static const routeName = "/tabs";

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {


  var _isInit = true;

 // var categoryId = 1;
  var initial = 8;
  var _isLoading = false;

  void didChangeDependencies() {
    if (_isInit) {
      if (mounted)
        setState(() {
          _isLoading = true;
        });

      try {
        Provider.of<Category>(context, listen: false).fetchItems();
      } catch (e) {
        print("catch error is $e");
      }

      Provider.of<Products>(context, listen: false)
          .fetchItems(initial)
          .then((_) {
        if (mounted)
          setState(() {
            _isLoading = false;
          });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> data(int index) async {
    int x = index + 1;
    setState(() {
      _isLoading = true;
    });
    /*setState(() {
      categoryId = index;
    });*/
    await Provider.of<Products>(context, listen: false).fetchItems(x);
    setState(() {
      _isLoading = false;
    });
  }

  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;
    final categoriesData = Provider.of<Category>(context);
    final categories = categoriesData.category;

    return Scaffold(
        //backgroundColor: Colors.greenAccent,
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text(
            "مرحبا بك في المحل",
            style: TextStyle(fontFamily: ("arab")),
          ),
          centerTitle: true,
          actions: <Widget>[
            Consumer<Cart>(
                builder: (_, cartData, ch) => Badge(
                      child: ch,
                      value: cartData.itemCount.toString(),
                    ),
                child: IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () =>
                      {Navigator.of(context).pushNamed(CartScreen.routeName)},
                ))
          ],
        ),
        body:
        DefaultTabController(
            length: categories.length,
           // initialIndex: 7,
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor),
                  ))
                : Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(children: <Widget>[
                      Container(
                          height: 40.0,

                          /*color: kPrimaryColor,*/
                          child: ListView.builder(shrinkWrap: true,
                              reverse: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: 1,
                              itemBuilder: (BuildContext context, pos) {
                                return TabBar(
                                  labelPadding: EdgeInsets.all(2.0),
                                  onTap: (index) {
                                    data(index);
                                  },
                                  indicator: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: kPrimaryColor),
                                  unselectedLabelStyle: TextStyle(
                                      color: Colors.black, fontSize: 12.0),
                                  labelColor: Colors.white,
                                  indicatorSize: TabBarIndicatorSize.label,
                                  unselectedLabelColor: kPrimaryColor,
                                  isScrollable: true,
                                  /*   // unselectedLabelColor: Colors.redAccent,

                            // indicatorPadding: EdgeInsets.all(5.0),

                            */
                                  /*indicator: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                color: Colors.white),*/
                                  /*
                            // unselectedLabelColor: kPrimaryColor,

                            //unselectedLabelColor: Colors.redAccent,
                            //labelStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w800),

                            //indicatorColor: Colors.transparent,*/
                                  tabs: <Widget>[
                                    ////
                                    for (int x = 0; x < categories.length; x++)
                                      Container(
                                        alignment: Alignment.center,
                                        child: Tab(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                border: Border.all(
                                                    color: kPrimaryColor,
                                                    width: 1)),
                                            width: 120.0,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(categories[x].title,
                                                  style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontFamily: ("jom"))),
                                            ),
                                          ),
                                        ),
                                      ),

                                    ////
                                  ],
                                );
                              })),

                      //Divider(),
                      Expanded(
                        child: TabBarView(
                            physics: NeverScrollableScrollPhysics(),
                            children: <Widget>[
                              for (int x = 0; x < categories.length; x++)
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5.0, vertical: 5.0),
                                  child: _isLoading
                                      ? Center(
                                          child: CircularProgressIndicator(
                                          strokeWidth: 2.0,
                                          valueColor: AlwaysStoppedAnimation<
                                                  Color>(
                                              Theme.of(context).primaryColor),
                                        ))
                                      : GridView.builder(
                                          padding: const EdgeInsets.all(10.0),
                                          itemCount: products.length,
                                          itemBuilder: (ctx, index) =>
                                              ChangeNotifierProvider.value(
                                            value: products[index],
                                            child: ProductItem(),
                                          ),
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 3.2 / 3.9,
                                            crossAxisSpacing: 5,
                                            mainAxisSpacing: 5,
                                          ),
                                        ),
                                ),
                            ]),
                      ),
                    ] /////////////////////////////////////
                        ),
                  )));
  }
}
