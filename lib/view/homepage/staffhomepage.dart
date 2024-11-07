import 'package:flutter/material.dart';

class Staffhomepage extends StatefulWidget {
  const Staffhomepage({super.key});

  @override
  State<Staffhomepage> createState() => _StaffhomepageState();
}

class _StaffhomepageState extends State<Staffhomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("staff page"),
      ),
    );
  }
}
