import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/constants/text_formed_field_constants.dart';
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

  String errorMsg(String str) {
    switch (str) {
      case 'Enter Your Password':
        return 'Invalid Email or Password';
    }
    return null;
  }

  bool isVisible = false;

  @override
  void initState() {
    isVisible = true;
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
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

                Container(
                  padding: EdgeInsets.only(right: 40.0, left: 40.0),
                  child: TextFormField(
                    validator: (String value) {
                      String errorMsg;
                      if ((value.isEmpty ||
                          !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
                          r"*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9]"
                          r"(?:[a-z0-9-]*[a-z0-9])?")
                              .hasMatch(value))) {
                        errorMsg = 'Invalid Email or Password';
                      } else {
                        return null;
                      }
                      return errorMsg;
                    },
                    onSaved: (value) {
                      _authData['email'] = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                      //ده علشان اثبت التايتل والهينت في مكانه واشوف بقي انا محتاج الشكل بتاعهم هيكون ايه وهل هخلي ال label فوق ولا في نص التيكيست فيلد وكدا
                      //floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: "Email",
                      labelStyle: TextStyle(color: kPrimaryColor),
                      hintText: "Email",
                      prefixIcon: Padding(
                        child: Icon(
                          Icons.email,
                          color: kPrimaryColor,
                        ),
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),

                Container(
                  padding: EdgeInsets.only(right: 40.0, left: 40.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty || value.length < 6) {
                        return errorMsg("Enter Your Password");
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      _authData['password'] = value;
                    },
                    obscureText: isVisible
                    //&& "Enter Your Password" == 'Enter Your Password'
                        ? true
                        : false,
                    decoration: kTextFieldDecoration.copyWith(
                      //  floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: "Password",
                      labelStyle: TextStyle(color: kPrimaryColor),
                      hintText: "Enter Your Password",
                      prefixIcon: Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: Icon(
                          Icons.lock,
                          color: kPrimaryColor,
                        ),
                      ),
                      suffixIcon: isVisible
                      //&& 'Enter Your Password' == 'Enter Your Password'
                          ? IconButton(
                        icon: Icon(Icons.visibility_off),
                        color: Colors.black,
                        onPressed: () {
                          setState(() {
                            isVisible = false;
                          });
                        },
                      )
                          : IconButton(
                          icon: Icon(Icons.visibility),
                          color: Colors.black,
                          onPressed: () {
                            setState(() {
                              isVisible = true;
                            });
                          }),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
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
