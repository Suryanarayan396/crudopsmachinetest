import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/managehomepage_controller.dart';
import 'package:flutter_application_1/controller/login_controller.dart';
import 'package:flutter_application_1/view/homepage/managehomepage/managementhomepage.dart';
import 'package:flutter_application_1/view/loginsignup_page/loginsignup.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const timetable());
}

class timetable extends StatelessWidget {
  const timetable({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ManagehomepageController(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Course Manager',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ManagementaHomepage(),
      ),
    );
  }
}
