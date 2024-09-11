import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_call/constants.dart';
import 'package:video_call/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:video_call/providers/user_provider.dart';
import 'package:video_call/screens/home_page.dart';
import 'package:video_call/widgets/snackbar.dart';

class AuthService {
  void registerUser(
      {required BuildContext context,
      required String username,
      required String password}) async {
    try {
      User user = User(id: '', username: username, password: password);

      http.Response res = await http.post(
        Uri.parse('$uri/api/users/register'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (res.statusCode == 409) {
        showSnackbar(context, 'User with this username already exists');
      } else {
        showSnackbar(context, 'User registered successfully');
      }
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  void logInUser(
      {required BuildContext context,
      required String username,
      required String password}) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/users/login'),
        body: jsonEncode({'username': username, 'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (res.statusCode != 200) {
        showSnackbar(context, 'Unable to login.');
      }

      SharedPreferences preferences = await SharedPreferences.getInstance();
      Provider.of<UserProvider>(context, listen: false).setUser(res.body);
      await preferences.setString(
          "x-auth-token", jsonDecode(res.body)['token']);

      Navigator.pushNamedAndRemoveUntil(context, HomePage.routeName, (route)=>false);
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }
}
