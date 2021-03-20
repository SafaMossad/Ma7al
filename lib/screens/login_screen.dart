import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/constants/text_formed_field_constants.dart';
import 'package:shop/models/http_exception.dart';
import 'package:shop/widgets/login_background.dart';

import '../providers/auth.dart';
import '../screens/sign_up_screen.dart';
import '../widgets/already_have_an_account_check.dart';
import '../widgets/or_divider.dart';
import '../widgets/rounded_button.dart';
import '../widgets/social_icon.dart';

class LoginScreen extends StatefulWidget {
  static const routeName ="/login";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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

  var _isLoading = false;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('This is Not a Valid Email'),
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

  Future<void> _facebookSubmit() async {
    setState(() {
      _isLoading = true;
    });
    try {
      // Log user in
      await Provider.of<Auth>(context, listen: false).loginFacebook();
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains(' "errors": "Invalid email or password"')) {
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

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      // Log user in
      await Provider.of<Auth>(context, listen: false).login(
        _authData['email'],
        _authData['password'],
      );
    } on HttpException catch (error) {
      var errorMessage = 'Check Email or password';
      if (error.toString().contains("Invalid")) {
        errorMessage = ' Check Email or Password';
      } else if (error.toString().contains(' "errors": "Invalid email or password"')) {
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
      print("messsssage $error");

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
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 35.0),
              child: Container(
                height: size.height * 0.35,
                //width: size.width*75,
                child: Image.asset(
                  "assets/ma7al_logo-removebg-preview.png",
                  /*  height: size.height * 0.50,
                  width: size.width * 0.20,*/
                  fit: BoxFit.fill,
                ),
              ),
            ),

            // SizedBox(height: 20.0),

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
           _isLoading? CircularProgressIndicator() : RoundedButton(text: "LOGIN", press: _submit),

            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
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
                  press: () {
                    _facebookSubmit();
                  },
                ),
                SocialIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    )));
  }
}
