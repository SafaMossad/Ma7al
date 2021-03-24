/*
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static final FacebookLogin facebookSignIn = new FacebookLogin();
  String name = '', image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
        actions: [
          FlatButton(
            child: Text(
              'Login',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              final FacebookLoginResult result =
              await facebookSignIn.logIn(['email']);

              switch (result.status) {
                case FacebookLoginStatus.loggedIn:
                  final FacebookAccessToken accessToken = result.accessToken;
                  final graphResponse = await http.get(
                      'https://graph.facebook.com/v2.12/me?fields=first_name,picture&access_token=${accessToken.token}');
                  final profile = jsonDecode(graphResponse.body);
                  print(profile);
                  setState(() {
                    name = profile['first_name'];
                    image = profile['picture']['data']['url'];
                  });
                  print('''
         Logged in!

         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
                  break;
                case FacebookLoginStatus.cancelledByUser:
                  print('Login cancelled by the user.');
                  break;
                case FacebookLoginStatus.error:
                  print('Something went wrong with the login process.\n'
                      'Here\'s the error Facebook gave us: ${result.errorMessage}');
                  break;
              }
            },
          )
        ],
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(name),
              image != null
                  ? Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(image)),
                    shape: BoxShape.circle),
              )
                  : Container()
            ],
          )),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:shop/screens/order_details_screen.dart';
import './providers/category.dart';
import 'package:provider/provider.dart';
import './providers/orders.dart';
import './screens/orders_screen.dart';
import './screens/splash_screen.dart';

import './providers/auth.dart';
import './providers/cart.dart';
import './providers/products.dart';
import './screens/cart_screen.dart';
import './screens/details.dart';
import './screens/login_screen.dart';
import './screens/tabs.dart';
import 'constants/text_formed_field_constants.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: Auth()),
          ChangeNotifierProxyProvider<Auth, Products>(
          //  child: Tabs(),
            update: (ctx, auth, previousProducts) => Products(
              auth.token,
              auth.userId,
              previousProducts == null ? [] : previousProducts.items,
            ),
          ),
          ChangeNotifierProvider(create: (ctx) => Cart()),
          ChangeNotifierProxyProvider<Auth, Orders>(
            update: (ctx, auth, previousOrders) => Orders(
              auth.token,
              auth.userId,
              previousOrders == null ? [] : previousOrders.orders,
            ),
          ),
          ChangeNotifierProxyProvider<Auth, Category>(
            update: (ctx, auth, previousCategory) => Category(
              auth.token,
              auth.userId,
              previousCategory == null ? [] : previousCategory.category,
            ),
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'فاكهة',
            theme: ThemeData(
              accentColor: Colors.red,
              primaryColor: kPrimaryColor,
              canvasColor: Colors.white,
              //scaffoldBackgroundColor: Colors.blueGrey,
              visualDensity: VisualDensity.adaptivePlatformDensity,
                fontFamily: ("arab")
            ),
            home: auth.isAuth? Tabs() : FutureBuilder(
              future: auth.tryAutoLogin(),
              builder: (ctx, authResultSnapshot) =>
              authResultSnapshot.connectionState ==
                  ConnectionState.waiting
                  ? SplashScreen()
                  : LoginScreen(),
            ),
            routes: {
              LoginScreen.routeName: (ctx) => LoginScreen(),
              Tabs.routeName: (ctx) => Tabs(),
              ProductDetails.routeName: (ctx) => ProductDetails(),
              OrderDetails.routeName:(ctx)=> OrderDetails(),
              CartScreen.routeName: (ctx) => CartScreen(),
              OrdersScreen.routeName: (ctx) => OrdersScreen(),
            },
          ),
        ));
  }
}
