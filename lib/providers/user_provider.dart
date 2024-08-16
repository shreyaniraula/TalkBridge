import 'package:flutter/material.dart';
import 'package:video_call/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    username: '',
    password: '',
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
