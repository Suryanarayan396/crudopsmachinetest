//

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/managehomepage_controller.dart';

import 'package:provider/provider.dart';

class Coursedialog extends StatefulWidget {
  @override
  _CoursedialogState createState() => _CoursedialogState();
}

class _CoursedialogState extends State<Coursedialog> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ManagehomepageController>(
      builder: (context, mngprov, child) {
        return AlertDialog(
          title: Text('Add Course'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: mngprov.courseNameController,
                  decoration: InputDecoration(labelText: 'Course Name'),
                ),
                SizedBox(height: 10),
                Column(
                  children: mngprov.subjectControllers
                      .asMap()
                      .entries
                      .map((entry) => Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: entry.value,
                                  decoration: InputDecoration(
                                      labelText: 'Subject ${entry.key + 1}'),
                                ),
                              ),
                              IconButton(
                                  icon: Icon(Icons.remove_circle),
                                  onPressed: () {
                                    mngprov.removeCourseSubjectField(entry.key);
                                  }),
                            ],
                          ))
                      .toList(),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      icon: Icon(Icons.add),
                      label: Text('Add Subject'),
                      onPressed: () {
                        mngprov.addcourseSubjectField();
                      },
                    ),
                    ElevatedButton(
                      child: Text('Submit'),
                      onPressed: () {
                        mngprov.coursedlgsubmit(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
