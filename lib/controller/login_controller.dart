import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/homepage/managehomepage/managementhomepage.dart';
import 'package:flutter_application_1/view/homepage/staffhomepage.dart';
import 'package:flutter_application_1/database_helper.dart';

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

  //database controll
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

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
  Future<void> tostaffhomepage(BuildContext context) async {
    if (formkey.currentState?.validate() ?? false) {
      List<Map<String, dynamic>> staffRows = await _dbHelper.getStaff();

      final staff = staffRows.firstWhere(
        (staff) => staff["name"] == staffidcontroller.text,
      );

      if (staffidcontroller == staff &&
          staffpasscontroller.text == staff["staff_code"]) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Staffhomepage(staffId: staff['id']), // Assuming this exists
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid Admin ID or Password')),
        );
      }
    }
  }
}
