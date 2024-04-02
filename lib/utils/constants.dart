import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter valid phone number";
const String kAddressNullError = "Please Enter your address";


class AppColor {
  static const kPrimaryColor = Color(0xFF0E4944);
  static const kAccentColor = Color(0xFF9BD35A);
  static const kThirdColor = Color(0xFFDBF4E9);
  static const kForthColor = Color(0xFFB3CDC5);
  static const kBlue = Color(0xFFC5E5F8);

  static const kPlaceholder1 = Color(0xFFD8D8D8);
  static const kPlaceholder2 = Color(0xFFF5F6F8);
  static const kPlaceholder3 = Color.fromARGB(255, 240, 240, 240);

  static const kTextColor1 = Color.fromARGB(255, 150, 150, 150);
  static const kTextColor2 = Color(0xFFDEDEDE);
  static const kTitle = Color(0xFF3B3B3B);
}

class Constants {
  Constants._();
  static const double padding = 20;
  static const double avatarRadius = 45;
}

class AppColors {
  static const Color primary = contentColorCyan;
  static const Color menuBackground = Color(0xFF090912);
  static const Color itemsBackground = Color(0xFF1B2339);
  static const Color pageBackground = Color(0xFF282E45);
  static const Color mainTextColor1 = Colors.white;
  static const Color mainTextColor2 = Colors.white70;
  static const Color mainTextColor3 = Colors.white38;
  static const Color mainGridLineColor = Colors.white10;
  static const Color borderColor = Colors.white54;
  static const Color gridLinesColor = Color(0x11FFFFFF);

  static const Color contentColorBlack = Colors.black;
  static const Color contentColorWhite = Colors.white;
  static const Color contentColorBlue = Color(0xFF2196F3);
  static const Color contentColorYellow = Color(0xFFFFC300);
  static const Color contentColorOrange = Color(0xFFFF683B);
  static const Color contentColorGreen = Color(0xFF3BFF49);
  static const Color contentColorPurple = Color(0xFF6E1BFF);
  static const Color contentColorPink = Color(0xFFFF3AF2);
  static const Color contentColorRed = Color(0xFFE80054);
  static const Color contentColorCyan = Color(0xFF50E4FF);
}

class User {
  static const ADMIN = 1;
  static const OWNER = 2;
  static const VENDOR = 3;

  static update_User(data) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson!);

    user['branch'] = data;

    localStorage.setString("user", json.encode(user));


  }
}



class Palette {
  static const Color background = Color(0xFF000000);
  static const Color blue = Color(0xFF1DA1F2);
  static const Color darkGray = Color(0xFF657786);
  static const Color gray = Color(0xFFAAB8C2);
  static const Color lightGray = Color(0xFFE1E8ED);
  static const Color extraLightGray = Color(0xFFF5F8FA);
  static const Color white = Color(0xFFFFFFFF);
}
