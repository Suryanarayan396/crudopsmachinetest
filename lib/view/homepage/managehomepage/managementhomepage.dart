import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/managehomepage_controller.dart';
import 'package:flutter_application_1/main.dart';

import 'package:flutter_application_1/utils/constants/colorconst.dart';
import 'package:flutter_application_1/utils/widgets/textheading_widget.dart';

import 'package:provider/provider.dart';

class ManagementaHomepage extends StatefulWidget {
  const ManagementaHomepage({super.key});

  @override
  State<ManagementaHomepage> createState() => _ManagementaHomepageState();
}

class _ManagementaHomepageState extends State<ManagementaHomepage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Fetch courses and staff data when the page loads
    final homeprov =
        Provider.of<ManagehomepageController>(context, listen: false);
    homeprov.fetchCourses();
    homeprov.fetchStaff();
    homeprov.fetchTimetables();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer<ManagehomepageController>(
      builder: (context, homeprov, child) => Scaffold(
          appBar: AppBar(
            toolbarHeight: 70,
            backgroundColor: Colorconst.darkblue,
            title: Text(
              'Course Manager',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colorconst.textwhite),
            ),
            actions: [
              CircleAvatar(
                child: IconButton(
                  icon: Icon(
                    Icons.logout_rounded,
                    size: 25,
                    color: Colorconst.darkred,
                  ),
                  onPressed: () {
                    homeprov.logoutmanagement(context);
                  },
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: TextheadingWidget(
                      title: "Courses",
                      containercolor: Colorconst.darkblue,
                      height: size.height * 0.065,
                      width: size.width * 0.4,
                      textcolor: Colorconst.textwhite),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: homeprov.courses.length,
                  itemBuilder: (context, index) {
                    final course = homeprov.courses[index];
                    return ListTile(
                      title: Text(
                        course.courseName,
                        style: TextStyle(fontSize: 30),
                      ),
                      subtitle: Text(
                        course.subjects.join("\n"),
                        style: TextStyle(fontSize: 20),
                      ),
                      trailing: IconButton(
                        onPressed: () async {
                          await homeprov.deleteCourse(course.id);
                        },
                        color: Colorconst.darkred,
                        icon: Icon(
                          Icons.delete,
                        ),
                      ),
                      onTap: () {
                        // course item tap
                      },
                    );
                  },
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: TextheadingWidget(
                      title: "Staff",
                      containercolor: Colorconst.darkblue,
                      height: size.height * 0.065,
                      width: size.width * 0.4,
                      textcolor: Colorconst.textwhite),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: homeprov.staffList.length,
                  itemBuilder: (context, index) {
                    final staff = homeprov.staffList[index];
                    return ListTile(
                      title: Text(
                        staff.name,
                        style: TextStyle(fontSize: 30),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            staff.phoneNumber,
                            style: TextStyle(fontSize: 20),
                          ),
                          Text("staff code:${staff.code}",
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      trailing: IconButton(
                        onPressed: () async {
                          await homeprov.deleteStaff(staff.id);
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colorconst.darkred,
                        ),
                      ),
                      onTap: () {
                        // staff item handle
                      },
                    );
                  },
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: TextheadingWidget(
                      title: "Timetable",
                      containercolor: Colorconst.darkblue,
                      height: size.height * 0.065,
                      width: size.width * 0.4,
                      textcolor: Colorconst.textwhite),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: homeprov.timetables.length,
                  itemBuilder: (context, index) {
                    final timetable = homeprov.timetables[index];
                    return ListTile(
                      title: Text("${timetable.subject}-${timetable.day}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Staff:${timetable.staffId}"),
                          Text(
                              "Time:${timetable.startTime}-${timetable.endTime}"),
                        ],
                      ),
                      trailing: IconButton(
                        onPressed: () async {
                          await homeprov.deletetimetable(timetable.id);
                        },
                        color: Colorconst.darkred,
                        icon: Icon(
                          Icons.delete,
                        ),
                      ),
                      onTap: () {
                        // staff item handle
                      },
                    );
                  },
                ),
              ],
            ),
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
              SizedBox(
                height: 25,
              ),
              FloatingActionButton(
                onPressed: () {
                  homeprov.createtimetable(context);
                },
                tooltip: 'Timetable',
                child: Icon(
                  Icons.table_rows_rounded,
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
