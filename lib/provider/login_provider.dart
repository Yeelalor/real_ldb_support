import 'package:flutter/material.dart';

class login_provider with ChangeNotifier {
  bool _islogined = false;
  bool get islogined => _islogined;
  final _staffID = TextEditingController();
  final _staffPassword = TextEditingController();
  get staffID => _staffID;
  get staffPassword => _staffPassword;
  void login() {
    _islogined = true;
    notifyListeners();
  }

  void logout() {
    _islogined = false;
    notifyListeners();
  }
}
