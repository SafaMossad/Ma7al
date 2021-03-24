import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  String _userId;

  //String _userName;

  String get token {
    if (_token != null) {
      return _token;
    }
    return null;
  }

  /* String get userName {
    return _userName;
  }*/

  bool get isAuth {
    return token != null;
  }

  String get userId {
    return _userId;
  }

  Future<void> loginFacebook() async {
    String url = "https://alma7al.herokuapp.com/api/v1/sessions";
    Map<String, String> headers = {"Content-type": "application/json"};
    FacebookLogin facebookSignIn = FacebookLogin();

    try {
      final result = await facebookSignIn.logIn(['email']);
      print("facebook result => $result");

      if (result.status == FacebookLoginStatus.loggedIn) {
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,'
            'email,picture&access_token=${result.accessToken.token}');
        final FacebookAccessToken accessToken = result.accessToken;
        final profile = json.decode(graphResponse.body);
        print("Profile data => $profile");
        print("email ${profile["email"]}");

        String body = json.encode(
          {
            'email': '${profile["email"]}',
            'password': "${profile["id"]}",
          },
        );

        // make POST request
        final response = await http.post(url, headers: headers, body: body);

        var data = json.decode(response.body);
        print("API Response=> $data");

        if (data['error'] != null) {
          throw HttpException(data['error']);
        }
        _token = data["auth_token"];
        _userId = data['id'].toString();
        // _userName=profile["email"];
        notifyListeners();
        final prefs = await SharedPreferences.getInstance();
        final userData = json.encode(
          {
            'token': _token,
            'userId': _userId,
            //'email':_userName,
          },
        );
        prefs.setString('userData', userData);
      } else if (result.status == FacebookLoginStatus.cancelledByUser) {
        print('Login cancelled by the user.');
      } else if (result.status == FacebookLoginStatus.error) {
        print('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
      } else {
        print("some thing unknown went wrong");
      }
    } catch (error) {
      print(" Caught error=> $error");
      throw error;
    }
  }

  Future<void> login(String email, String password) async {
    String url = "https://alma7al.herokuapp.com/api/v1/sessions";
    Map<String, String> headers = {"Content-type": "application/json"};
    String body = json.encode({"email": "$email", "password": "$password"});
    try {
      // make POST request
      final response = await http.post(url, headers: headers, body: body);

      var data = json.decode(response.body);
      print("API Response=> $data");

      if (data['errors'] != null) {
        throw HttpException(data['errors']);
      }
      _token = data["auth_token"];
      _userId = data['id'].toString();
      // _userName=data["email"].toString();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'userId': _userId,
          //'email':_userName,
        },
      );
      prefs.setString('userData', userData);
    } catch (error) {
      print(" Caught error=> $error");
      throw error;
    }
  }

  Future<void> signUp(String email, String password) async {
    String url = "https://alma7al.herokuapp.com/api/v1/users";
    Map<String, String> headers = {"Content-type": "application/json"};
    String body = json.encode({
      "user": {
        "email": "$email",
        "password": "$password",
        "password_confirmation": "$password"
      }
    });

    try {
      // make POST request
      final response = await http.post(url, headers: headers, body: body);

      var data = json.decode(response.body);
      print("API Response=> $data");

      if (data['errors'] != null) {
        throw HttpException(data['errors']);
      }
      _token = data["auth_token"];
      _userId = data['id'].toString();
      // _userName=data["email"].toString();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'userId': _userId,
          //'email':_userName,
        },
      );
      prefs.setString('userData', userData);
    } catch (error) {
      print(" Caught error=> $error");
      throw error;
    }
  }

  Future<void> signUpFacebook() async {
    String urllink = "https://alma7al.herokuapp.com/api/v1/users";
    Map<String, String> headers = {"Content-type": "application/json"};
    FacebookLogin facebookSignIn = FacebookLogin();

    try {
      final result = await facebookSignIn.logIn(['email']);
      print("facebook result => $result");

      if (result.status == FacebookLoginStatus.loggedIn) {
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,'
            'email,picture&access_token=${result.accessToken.token}');
        //final FacebookAccessToken accessToken = result.accessToken;
        final profile = json.decode(graphResponse.body);
        print("Profile data => $profile");
        print("email ${profile["email"]}");

        String body = json.encode({
          "user": {
            "email": "${profile["email"]}",
            "password": "${profile["id"].toString()}",
            "password_confirmation": "${profile["id"].toString()}"
          }
        });

        // make POST request
        final response = await http.post(urllink, headers: headers, body: body);

        var data = json.decode(response.body);
        print("API Response=> $data");

        if (data['error'] != null) {
          throw HttpException(data['error']);
        }
        _token = data["auth_token"];
        _userId = data['id'].toString();
        notifyListeners();
        final prefs = await SharedPreferences.getInstance();
        final userData = json.encode(
          {
            'token': _token,
            'userId': _userId,
          },
        );
        prefs.setString('userData', userData);
      } else if (result.status == FacebookLoginStatus.cancelledByUser) {
        print('Login cancelled by the user.');
      } else if (result.status == FacebookLoginStatus.error) {
        print('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
      } else {
        print("some thing unknown went wrong");
      }
    } catch (error) {
      print(" Caught error=> $error");
      throw error;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;

    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;

    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
    prefs.clear();
  }
}
