import 'package:flutter/material.dart';

class LoadingSpinner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.transparent,
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
          valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).primaryColor),
        ));
  }
}
