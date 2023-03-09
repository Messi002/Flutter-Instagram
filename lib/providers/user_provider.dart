import 'package:flutter/material.dart';
import 'package:instagram/model/user_model.dart';
import 'package:instagram/resources/auth_method.dart';

// class UserProvider extends ChangeNotifier {
//   UserModel? _user;
//   UserModel get getUser => _user!;
//   final AuthMethods _authMethods = AuthMethods();

//   Future<void> refreshUser() async {
//     UserModel user = await _authMethods.getUserDetails();
//     _user = user;
//     notifyListeners();
//   }
// }


class UserProvider with ChangeNotifier {
  UserModel? _user;
  final AuthMethods _authMethods = AuthMethods();

  UserModel get getUser => _user!;

  Future<void> refreshUser() async {
    UserModel user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}