import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/managehomepage_controller.dart';
import 'package:flutter_application_1/model/course_model.dart';
import 'package:flutter_application_1/model/staff_model.dart';
import 'package:provider/provider.dart';

class TimetableDialog extends StatefulWidget {
  @override
  _TimetableDialogState createState() => _TimetableDialogState();
}

class _TimetableDialogState extends State<TimetableDialog> {
  late Course selectedCourse;
  late String selectedSubject;
  late String selectedDay;
  late String selectedTimestart;
  late String selectedTimeend;
  late Staff selectedstaff;

  List<String> days = ["Day 1", "Day 2", "Day 3", 'Day 4', "Day 5"];
  List<String> periods = [
    "10:00 AM - 11:00 AM",
    "11:00 AM - 12:00 PM",
    "01:00 PM - 02:00 PM",
    "02:00 PM - 03:00 PM"
  ];

  @override
  void initState() {
    super.initState();
    selectedCourse = Course(courseName: "", subjects: [], id: 0);
    selectedSubject = "";
    selectedstaff = Staff(name: "", phoneNumber: "", id: 0, code: '');
    selectedTimestart = periods[0];
    selectedTimeend = periods[1];
    selectedDay = days[0];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ManagehomepageController>(
      builder: (context, homeprov, child) {
        return AlertDialog(
          title: Text('Create Timetable'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Course dropdown
                DropdownButton<int>(
                  value: selectedCourse.id != 0 &&
                          homeprov.courses
                              .any((course) => course.id == selectedCourse.id)
                      ? selectedCourse.id
                      : null, // Set to null if no valid course is selected
                  items: homeprov.courses.map((Course course) {
                    return DropdownMenuItem<int>(
                      value: course.id,
                      child: Text(course.courseName),
                    );
                  }).toList(),
                  onChanged: (int? newCourseId) {
                    setState(() {
                      selectedCourse = homeprov.courses.firstWhere(
                          (course) => course.id == newCourseId,
                          orElse: () =>
                              Course(courseName: "", subjects: [], id: 0));
                      selectedSubject = selectedCourse.subjects.isNotEmpty
                          ? selectedCourse.subjects[0]
                          : "";
                    });
                  },
                ),

                // Subject dropdown
                DropdownButton<String>(
                  value: selectedSubject,
                  items: selectedCourse.subjects.map((String subject) {
                    return DropdownMenuItem(
                        value: subject, child: Text(subject));
                  }).toList(),
                  onChanged: (String? newSubject) {
                    setState(() {
                      selectedSubject = newSubject!;
                    });
                  },
                ),

                // Staff dropdown
                DropdownButton<Staff>(
                  value: selectedstaff.id != 0 &&
                          homeprov.staffList
                              .any((staff) => staff.id == selectedstaff.id)
                      ? selectedstaff
                      : null, // Set to null if no valid staff is selected
                  onChanged: (Staff? newStaff) {
                    setState(() {
                      selectedstaff = newStaff!;
                    });
                  },
                  items: homeprov.staffList.map((Staff staff) {
                    return DropdownMenuItem<Staff>(
                      value: staff,
                      child: Text(staff.name),
                    );
                  }).toList(),
                ),

                // Day dropdown
                DropdownButton<String>(
                  value: selectedDay,
                  onChanged: (String? newDay) {
                    setState(() {
                      selectedDay = newDay!;
                    });
                  },
                  items: days.map((String day) {
                    return DropdownMenuItem<String>(
                      value: day,
                      child: Text(day),
                    );
                  }).toList(),
                ),

                // Time selection
                Column(
                  children: [
                    Text("Start Time: "),
                    DropdownButton<String>(
                      value: selectedTimestart,
                      onChanged: (String? newTime) {
                        setState(() {
                          selectedTimestart = newTime!;
                        });
                      },
                      items: periods.map((String time) {
                        return DropdownMenuItem<String>(
                          value: time,
                          child: Text(time),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20),
                    Text("End Time: "),
                    DropdownButton<String>(
                      value: selectedTimeend,
                      onChanged: (String? newTime) {
                        setState(() {
                          selectedTimeend = newTime!;
                        });
                      },
                      items: periods.map((String time) {
                        return DropdownMenuItem<String>(
                          value: time,
                          child: Text(time),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                // Create a timetable entry
                if (selectedCourse.courseName.isNotEmpty &&
                    selectedSubject.isNotEmpty &&
                    selectedstaff.name.isNotEmpty) {
                  Map<String, dynamic> timetableData = {
                    'course_id': selectedCourse.id,
                    'subject': selectedSubject,
                    'staff_id': selectedstaff.id, // Corrected staff ID handling
                    'day': selectedDay,
                    'start_time': selectedTimestart,
                    'end_time': selectedTimeend,
                  };

                  // Wait until the save operation completes before closing the dialog
                  await homeprov.saveTimetable(timetableData);
                  Navigator.of(context).pop(); // Close the dialog after saving
                } else {
                  // Show a message if any details are missing
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Please fill details."),
                  ));
                }
              },
              child: Text("Save"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog without saving
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
}
