import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/course_model.dart';
import 'package:flutter_application_1/model/staff_model.dart';
import 'package:flutter_application_1/view/homepage/managehomepage/components/StaffDialog.dart';
import 'package:flutter_application_1/view/homepage/managehomepage/components/coursedialog.dart';

class ManagehomepageController with ChangeNotifier {
  List<Staff> staffList = [];
  List<Course> courses = [];

  void addStaff(BuildContext context) async {
    final Staff? newStaff = await showDialog<Staff>(
      context: context,
      builder: (BuildContext context) {
        return StaffDialog(context);
      },
    );

    if (newStaff != null) {
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
      // Add the new course to a list of courses (you'll need a `courses` list)
      courses.add(newcourse);
      notifyListeners();
    }
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
          .pop(Course(courseName: courseName, subjects: subjects));
    } else {
      // Show an error or do validation
    }
  }

  void dispose() {
    courseNameController.dispose();
    for (var controller in subjectControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
