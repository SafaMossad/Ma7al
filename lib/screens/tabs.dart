import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../providers/products.dart';
import '../screens/cart_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/badge.dart';
import '../widgets/product_item.dart';

class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  List subCategories = [
    "فاكهة",
    "لحوم ",
    "أسماك",
    "بقالة",
    "عطارة",
    "خضار ",
    "مسليات",
    "مجمدات ",
    "أكل جاهز",
  ];

  var _isInit = true;

  @override
/*  void initState() {
    // Provider.of<Products>(context).fetchAndSetProducts(); // WON'T WORK!
    Future.delayed(Duration.zero).then((_) {
      Provider.of<Products>(context).fetchItems(_index);
    });
    super.initState();
  }*/

  int _index = 1;
  var _isLoading = false;

  void didChangeDependencies() {
    if (_isInit) {
      if (mounted)
        setState(() {
          _isLoading = true;
        });

      Provider.of<Products>(context, listen: false)
          .fetchItems(_index)
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
    await Provider.of<Products>(context, listen: false).fetchItems(x);
    setState(() {
      _isLoading = false;
    });
  }

  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text("Timeline"),
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
        body: DefaultTabController(
            initialIndex: 0,
            length: subCategories.length,
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(children: <Widget>[
                  TabBar(
                    onTap: (index) {
                      data(index);
                    },
                    physics: NeverScrollableScrollPhysics(),
                    //physics: NeverScrollableScrollPhysics(),
                    isScrollable: true,
                    indicatorColor: Colors.grey,
                    tabs: <Widget>[
                      ////
                      for (int x = 0; x < subCategories.length; x++)
                        Tab(
                            child: Text(
                          subCategories[x],
                          style: TextStyle(color: Colors.redAccent),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        )),

                      ////
                    ],
                  ),
                  _isLoading
                      ? Padding(
                          padding: EdgeInsets.only(top: 250.0),
                          child: CircularProgressIndicator())
                      : Expanded(

                          child: TabBarView(
                              physics: NeverScrollableScrollPhysics(),
                              children: <Widget>[
                                for (int x = 0; x < subCategories.length; x++)
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5.0, vertical: 5.0),
                                    child: _isLoading
                                        ? Center(
                                            child: CircularProgressIndicator())
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
                                              childAspectRatio: 7.1 / 7.5,
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10,
                                            ),
                                          ),
                                  ),
                              ]),
                        ),
                ] /////////////////////////////////////
                    ))));
  }
}
