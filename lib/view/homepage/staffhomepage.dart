import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/staffpage_controller.dart';
import 'package:flutter_application_1/database_helper.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/model/timetable_model.dart';
import 'package:provider/provider.dart';

class Staffhomepage extends StatefulWidget {
  final int staffId;
  const Staffhomepage({super.key, required this.staffId});

  @override
  State<Staffhomepage> createState() => _StaffhomepageState();
}

class _StaffhomepageState extends State<Staffhomepage> {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  List<Timetable> timetables = [];
  @override
  void initState() {
    fetchstafftimetable();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StaffpageController>(
      builder: (context, staffprov, child) => Scaffold(
        appBar: AppBar(
          title: Text("Staff timetable"),
          actions: [
            IconButton(
              icon: Icon(Icons.logout_rounded),
              onPressed: () {
                staffprov.logoutstaff(context);
              },
            )
          ],
        ),
        body: ListView.builder(
          itemCount: timetables.length,
          itemBuilder: (context, index) {
            final timetable = timetables[index];
            return Card(
              child: ListTile(
                title: Text("${timetable.subject}-${timetable.day}"),
                subtitle: Column(
                  children: [
                    Text("Time: ${timetable.startTime} - ${timetable.endTime}"),
                    Text("Course ID: ${timetable.courseId}"),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> fetchstafftimetable() async {
    final timetablerows = await _dbHelper.getTimetables();
    setState(() {
      timetables = timetablerows
          .where(
        (timetable) => timetable["staff_id"] == widget.staffId,
      )
          .map(
        (timetablerow) {
          return Timetable(
              id: timetablerow['id'],
              courseId: timetablerow['course_id'],
              subject: timetablerow['subject'],
              staffId: timetablerow['staff_id'],
              day: timetablerow['day'],
              startTime: timetablerow['start_time'],
              endTime: timetablerow['end_time']);
        },
      ).toList();
    });
  }
}
