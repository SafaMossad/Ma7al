import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/auth.dart';
import 'package:shop/models/http_exception.dart';

import '../shared_text_field_component/email_field.dart';
import '../shared_text_field_component/password_field.dart';
import '../shared_text_field_component/phone_field.dart';
import '../widgets/already_have_an_account_check.dart';
import '../widgets/or_divider.dart';
import '../widgets/rounded_button.dart';
import '../widgets/signUp_background.dart';
import '../widgets/social_icon.dart';
import 'login_screen.dart';
import 'tabs.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _submitForm() async {
    try {
      // Log user in
      await Provider.of<Auth>(context, listen: false).signUpFacebook();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Tabs()));
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error
          .toString()
          .contains(' "errors": "Invalid email or password"')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      print(",esssssage $error");

      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  "assets/ma7al_logo-removebg-preview.png",
                  height: size.height * 0.20,
                  width: size.width * 0.30,
                  fit: BoxFit.cover,
                ),

                /*  SizedBox(height: size.height * 0.04),

                Text(
                  "Welcome to SIGN UP",
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),
                ),*/
                // SizedBox(height: size.height * 0.04),
                EmailField(label: "Your Email", hintTxt: "Email"),
                SizedBox(height: size.height * 0.02),
                PasswordField(
                    label: "Password", hintTxt: "Enter Your Password"),
                SizedBox(height: size.height * 0.02),
                PasswordField(
                    label: "Password", hintTxt: "Enter Your Password"),
                SizedBox(height: size.height * 0.02),
                Phone(label: "Phone", hintTxt: "Enter Your Phone Number"),
                SizedBox(height: size.height * 0.02),
                RoundedButton(
                  text: "SIGN UP",
                  press: _submitForm,
                ),
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  login: false,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen();
                        },
                      ),
                    );
                  },
                ),
                OrDivider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SocialIcon(
                      iconSrc: "assets/icons/facebook.svg",
                      press: _submitForm,
                    ),
                    /*SocialIcon(
                      iconSrc: "assets/icons/twitter.svg",
                      press: () {},
                    ),*/
                    SocialIcon(
                      iconSrc: "assets/icons/google-plus.svg",
                      press: () {},
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
