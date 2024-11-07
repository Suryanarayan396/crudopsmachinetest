import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/constants/colorconst.dart';
import 'package:flutter_application_1/controller/login_controller.dart';
import 'package:flutter_application_1/utils/widgets/textheading_widget.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

// Login form page
class Loginform extends StatelessWidget {
  final Size size;
  final LoginController logsignprovider; // Pass LoginController here

  const Loginform({
    super.key,
    required this.size,
    required this.logsignprovider,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Name/Email Input Field
            TextFormField(
              controller: logsignprovider.staffidcontroller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Username is required";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Name',
                filled: true,
                fillColor: Colors.grey[200],
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
              onChanged: (value) {},
            ),
            const SizedBox(height: 15),

            // Password Input Field
            TextFormField(
              controller: logsignprovider.staffpasscontroller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Password is required";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Password',
                filled: true,
                fillColor: Colors.grey[200],
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
              obscureText: true,
              onChanged: (value) {},
            ),
            const SizedBox(height: 15),

            // Login Button
            InkWell(
              onTap: () {
                // Trigger login action here
              },
              child: TextheadingWidget(
                title: "Login",
                containercolor: Colorconst.darkblue,
                height: size.height * 0.065,
                width: size.width * 0.3,
                textcolor: Colorconst.textwhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Signup form page
class Signupform extends StatelessWidget {
  final LoginController logsignprovider;
  final Size size;

  const Signupform({
    super.key,
    required this.size,
    required this.logsignprovider,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Admin Id (Username) Input Field
            TextFormField(
              controller: logsignprovider.mngidcontroller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Username is required";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Admin Id',
                filled: true,
                fillColor: Colors.grey[200],
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            const SizedBox(height: 15),

            // Password Input Field
            TextFormField(
              controller: logsignprovider.mngpasscontroller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Password is required";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Password',
                filled: true,
                fillColor: Colors.grey[200],
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
              obscureText: true,
              onChanged: (value) {},
            ),
            const SizedBox(height: 15),

            // Login Button to toggle back to login form
            InkWell(
              onTap: () {
                logsignprovider.tomanagementhomepage(context);
              },
              child: TextheadingWidget(
                title: "Login",
                containercolor: Colorconst.darkblue,
                height: size.height * 0.065,
                width: size.width * 0.3,
                textcolor: Colorconst.textwhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Main screen that handles login/signup toggle
class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({super.key});

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: InkWell(
        onTap: () async {
          // Show confirmation dialog before deleting the database
          bool deleteConfirmed = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Are you sure?"),
              content:
                  const Text("This will delete all data from the database."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false); // Cancel delete
                  },
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true); // Confirm delete
                  },
                  child: const Text("Delete"),
                ),
              ],
            ),
          );

          if (deleteConfirmed) {
            // Call deleteDatabaseFile() to delete the database
            await deleteDatabaseFile();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                      "Database deleted and will be recreated next time.")),
            );
          }
        },
        child: TextheadingWidget(
          title: "Student",
          containercolor: Colorconst.darkblue,
          height: size.height * 0.07,
          width: size.width * 0.4,
          textcolor: Colorconst.textwhite,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Consumer<LoginController>(
            builder: (context, logsignprovider, child) => SingleChildScrollView(
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    // Toggle between STAFF and MANAGEMENT
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            logsignprovider.toggleStaffManagement("STAFF");
                            logsignprovider.pageController.jumpToPage(0);
                          },
                          child: TextheadingWidget(
                            title: "STAFF",
                            containercolor: logsignprovider.isStaffselected
                                ? Colorconst.maincolor
                                : Colorconst.darkblue,
                            height: size.height * 0.065,
                            width: size.width * 0.4,
                            textcolor: Colorconst.textwhite,
                          ),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        InkWell(
                          onTap: () {
                            logsignprovider.toggleStaffManagement("MANAGEMENT");
                            logsignprovider.pageController.jumpToPage(1);
                          },
                          child: TextheadingWidget(
                            title: "MANAGEMENT",
                            containercolor: !logsignprovider.isStaffselected
                                ? Colorconst.maincolor
                                : Colorconst.darkblue,
                            height: size.height * 0.065,
                            width: size.width * 0.4,
                            textcolor: Colorconst.textwhite,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    // Login/Signup Forms inside PageView
                    Container(
                      height: size.height * 0.6, // Fixed height for PageView
                      child: Form(
                        key: logsignprovider.formkey,
                        child: PageView(
                          controller: logsignprovider.pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            Loginform(
                              size: size,
                              logsignprovider: logsignprovider,
                            ),
                            Signupform(
                              size: size,
                              logsignprovider: logsignprovider,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> deleteDatabaseFile() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'course_manager.db');
    await deleteDatabase(path); // Deletes the entire database file
    print("Database deleted and will be recreated next time.");
  }
}
