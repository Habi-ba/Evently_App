import 'package:evently/models/my_user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  //todo: data_function
  MyUser? currentUser;

  void updateUser(MyUser newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}
