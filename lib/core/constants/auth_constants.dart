import 'package:flutter/widgets.dart';

class AuthTextConstants {
  AuthTextConstants._();

  static const String heyThere = 'Hey There';
  static const String welcomeBack = 'WELCOME BACK';
  static const String login = 'Login';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String forgotPassword = 'Forget Password ?';
  static const String or = 'Or';
  static const String noAccount = "Don't Have An Account Yet ? ";
  static const String register = 'Register';
}

class AuthUiConstants {
  AuthUiConstants._();

  static const EdgeInsets screenHorizontalPadding = EdgeInsets.symmetric(
    horizontal: 16,
  );
  static const EdgeInsets cardPadding = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 24,
  );

  static const double logoWidth = 70;
  static const double logoHeight = 48;
  static const double cardRadius = 50;
}
