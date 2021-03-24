import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/screens/login_screen.dart';
import 'package:shop/screens/tabs.dart';

import '../providers/auth.dart';
import '../screens/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  //bool _isLoading =false;
  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<Auth>(context, listen: false);

    return Drawer(
      child: Column(
        children: <Widget>[
          Consumer<Auth>(
            builder: (ctx, product, _) => UserAccountsDrawerHeader(
              //accountName: Text(authData.userName),
              // accountEmail: Text(authData.userName),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Color(0xffced4da),
                child: Text(
                  " authData.userName[0]",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('الرئيسية'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(Tabs.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.reorder),
            title: Text("طلباتي"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('ارسال شكوي'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.supervised_user_circle),
            title: Text('من نحن'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.apps),
            title: Text('نبذة عن التطبيق'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('تسجيل الخروج'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
