import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/loginsignup_page/loginsignup.dart';

class StaffpageController extends ChangeNotifier {
  void logoutstaff(BuildContext context) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginSignupScreen(),
        ));
  }
}
