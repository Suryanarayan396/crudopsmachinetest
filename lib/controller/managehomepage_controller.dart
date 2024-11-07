import 'package:flutter/material.dart';
import 'package:flutter_application_1/database_helper.dart';
import 'package:flutter_application_1/model/course_model.dart';
import 'package:flutter_application_1/model/staff_model.dart';
import 'package:flutter_application_1/model/timetable_model.dart';
import 'package:flutter_application_1/view/homepage/managehomepage/components/StaffDialog.dart';
import 'package:flutter_application_1/view/homepage/managehomepage/components/coursedialog.dart';
import 'package:flutter_application_1/view/homepage/managehomepage/components/timtableDialog.dart';

class ManagehomepageController with ChangeNotifier {
  List<Staff> staffList = [];
  List<Course> courses = [];
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  List<Timetable> timetables = [];

  // Future<void> fetchStaff() async {
  //   final staffRows = await _dbHelper.getStaff();
  //   staffList = staffRows.map((staff) {
  //     return Staff(
  //       name: staff['name'],
  //       phoneNumber: staff['phone_number'],
  //       code: staff['staff_code'],
  //     );
  //   }).toList();
  //   notifyListeners();
  // }

  Future<void> addStaff(BuildContext context) async {
    final Staff? newStaff = await showDialog<Staff>(
      context: context,
      builder: (BuildContext context) {
        return StaffDialog();
      },
    );

    if (newStaff != null) {
      await _dbHelper.insertStaff({
        'name': newStaff.name,
        'phone_number': newStaff.phoneNumber,
        'staff_code': newStaff.code,
      });
      staffList.add(newStaff);
      notifyListeners();
    }
  }

  Future<void> addcourse(context) async {
    final Course? newcourse = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Coursedialog();
      },
    );

    if (newcourse != null) {
      await _saveCourse(newcourse); // Save the course in the database
      courses.add(newcourse);
      notifyListeners();
    }
  }

  Future<int> _saveCourse(Course course) async {
    int courseId =
        await _dbHelper.insertCourse({'course_name': course.courseName});

    // Insert each subject of the course
    for (var subject in course.subjects) {
      await _dbHelper.insertSubject({
        'course_id': courseId,
        'subject_name': subject,
      });
    }
    return courseId;
  }

//coursedlgpage functions

  final TextEditingController courseNameController = TextEditingController();
  final List<TextEditingController> subjectControllers = [];

  void addcourseSubjectField() {
    subjectControllers.add(TextEditingController());
    notifyListeners();
  }

  void removeCourseSubjectField(int index) {
    subjectControllers[index].dispose();
    subjectControllers.removeAt(index);
    notifyListeners();
  }

  void coursedlgsubmit(BuildContext context) {
    final courseName = courseNameController.text;
    final subjects =
        subjectControllers.map((controller) => controller.text).toList();

    if (courseName.isNotEmpty &&
        subjects.every((subject) => subject.isNotEmpty)) {
      Navigator.of(context)
          .pop(Course(courseName: courseName, subjects: subjects, id: 0));
    } else {
      // Show an error or do validation
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("please fill all details")));
    }
  }

  void dispose() {
    courseNameController.dispose();
    for (var controller in subjectControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  // fetch details

  // Fetch Staff List from DB
  Future<void> fetchStaff() async {
    final staffRows = await _dbHelper.getStaff();
    staffList = staffRows.map((staff) {
      return Staff(
        name: staff['name'],
        id: staff['id'],
        phoneNumber: staff['phone_number'],
        code: staff['staff_code'],
      );
    }).toList();
    notifyListeners();
  }

  Future<void> fetchCourses() async {
    final courseRows = await _dbHelper.getCourses();
    courses = [];

    for (var courseRow in courseRows) {
      final courseName = courseRow['course_name'];
      final courseId = courseRow['id'];
      final subjects = await _dbHelper.getSubjects(courseRow['id']);
      final subjectList =
          subjects.map((subject) => subject['subject_name'] as String).toList();

      courses.add(
          Course(courseName: courseName, subjects: subjectList, id: courseId));
    }

    notifyListeners();
  }

  // deleting the entered details
// Delete course method
  Future<void> deleteCourse(int courseId) async {
    await _dbHelper.deleteCourse(courseId);

    courses.removeWhere((course) => course.id == courseId);

    notifyListeners(); // Notify UI to update
  }

// Delete staff method
  Future<void> deleteStaff(int staffId) async {
    // Remove the staff from the database
    await _dbHelper.deleteStaff(staffId);

    // Remove the staff from the local list
    staffList.removeWhere((staff) => staff.id == staffId);

    notifyListeners(); // Notify UI to update
  }

  // timetable section

  Future<void> saveTimetable(Map<String, dynamic> timetableData) async {
    final timetableId = await _dbHelper.insertTimetable(timetableData);

    // Optionally, fetch the latest timetable after saving it
    fetchTimetables();
  }

  Future<void> createtimetable(BuildContext context) async {
    final Map<String, List<String>>? timetable =
        await showDialog<Map<String, List<String>>>(
      context: context,
      builder: (context) => TimetableDialog(),
    );

    if (timetable != null) {
      // Save the timetable to the database
      final timetableId = await _dbHelper
          .insertTimetable({'timetable_data': timetable.toString()});

      // After saving,fetch timetable data
      fetchTimetables();
    }
  }

  Future<void> fetchTimetables() async {
    final timetableRows = await _dbHelper.getTimetables();
    timetables = timetableRows.map((timetableRow) {
      return Timetable(
        id: timetableRow['id'],
        courseId: timetableRow['course_id'],
        subject: timetableRow['subject'],
        staffId: timetableRow['staff_id'],
        day: timetableRow['day'],
        startTime: timetableRow['start_time'],
        endTime: timetableRow['end_time'],
      );
    }).toList();
    notifyListeners();
  }

  Future<void> deletetimetable(int timetableId) async {
    try {
      await _dbHelper.deletetimetable(timetableId);
      fetchTimetables();
      notifyListeners();
    } catch (e) {
      print("error deleting");
    }
  }
}
