import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/managehomepage_controller.dart';
import 'package:flutter_application_1/utils/constants/colorconst.dart';

import 'package:provider/provider.dart';

class ManagementaHomepage extends StatefulWidget {
  const ManagementaHomepage({super.key});

  @override
  State<ManagementaHomepage> createState() => _ManagementaHomepageState();
}

class _ManagementaHomepageState extends State<ManagementaHomepage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ManagehomepageController>(
      builder: (context, homeprov, child) => Scaffold(
          appBar: AppBar(
            title: Text('Course Manager'),
          ),
          body: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return ListTile();
            },
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FloatingActionButton(
                onPressed: () {
                  homeprov.addcourse(context);
                },
                tooltip: 'Add Course',
                child: Icon(
                  Icons.school_rounded,
                  size: 28,
                  color: Colorconst.textwhite,
                ),
                backgroundColor: Colorconst.darkblue,
              ),
              SizedBox(
                height: 25,
              ),
              FloatingActionButton(
                onPressed: () {
                  homeprov.addStaff(context);
                },
                tooltip: 'Add Staff',
                child: Icon(
                  Icons.person_2_rounded,
                  size: 28,
                  color: Colorconst.textwhite,
                ),
                backgroundColor: Colorconst.darkblue,
              ),
            ],
          )),
    );
  }
}
