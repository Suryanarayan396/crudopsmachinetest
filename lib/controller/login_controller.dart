import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/homepage/managehomepage/managementhomepage.dart';

class LoginController extends ChangeNotifier {
  final PageController pageController = PageController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController staffidcontroller = TextEditingController();
  TextEditingController mngidcontroller = TextEditingController();
  TextEditingController mngpasscontroller = TextEditingController();
  TextEditingController staffpasscontroller = TextEditingController();

  bool isStaffselected = true; // By default, STAFF is selected

//management id and password
  String adminid = "Admin01";
  String password = "Admin@123";

  void toggleStaffManagement(String selection) {
    if (selection == "STAFF") {
      isStaffselected = true;
    } else {
      isStaffselected = false;
    }
    notifyListeners();
  }

  // Method for validation and navigating to management page
  void tomanagementhomepage(BuildContext context) {
    // Only navigate if the form is valid
    if (formkey.currentState?.validate() ?? false) {
      // Compare text in controllers to the stored admin credentials
      if (mngidcontroller.text == adminid &&
          mngpasscontroller.text == password) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ManagementaHomepage(), // Assuming this exists
          ),
        );
      } else {
        // Show error if credentials don't match
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid Admin ID or Password')),
        );
      }
    }
  }

  // Method to handle login validation for staff
  void staffLogin(BuildContext context) {
    if (formkey.currentState?.validate() ?? false) {
      // Navigate to a different page for staff after successful validation
      // You can replace this with the actual navigation logic
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Staff Login Successful')),
      );
    }
  }
}
