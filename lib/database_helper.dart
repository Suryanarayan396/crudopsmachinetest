import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class DatabaseHelper {
  static Database? _database;

  // Singleton pattern: only one instance of the database is allowed
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;

    // If the database is not already created, create it
    _database = await _initDatabase();
    return _database!;
  }

  // Open the database and create the tables
  Future<Database> _initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'course_manager.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // Create tables in the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE courses(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        course_name TEXT NOT NULL
      );
    ''');

    await db.execute('''
      CREATE TABLE subjects(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        course_id INTEGER,
        subject_name TEXT NOT NULL,
        FOREIGN KEY (course_id) REFERENCES courses(id)
      );
    ''');

    await db.execute('''
      CREATE TABLE staff(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        phone_number TEXT NOT NULL,
        staff_code TEXT NOT NULL
      );
    ''');

    await db.execute('''
    CREATE TABLE timetable(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      course_id INTEGER,
      subject TEXT NOT NULL,
      staff_id INTEGER,
      day TEXT NOT NULL,
      start_time TEXT NOT NULL,
      end_time TEXT NOT NULL,
      FOREIGN KEY (course_id) REFERENCES courses(id),
      FOREIGN KEY (staff_id) REFERENCES staff(id)
    );
  ''');
  }

  // Insert a new course
  Future<int> insertCourse(Map<String, dynamic> course) async {
    Database db = await database;
    return await db.insert('courses', course);
  }

  // Insert a new subject
  Future<int> insertSubject(Map<String, dynamic> subject) async {
    Database db = await database;
    return await db.insert('subjects', subject);
  }

  // Insert a new staff member
  Future<int> insertStaff(Map<String, dynamic> staff) async {
    Database db = await database;
    return await db.insert('staff', staff);
  }

  // Fetch all courses
  Future<List<Map<String, dynamic>>> getCourses() async {
    Database db = await database;
    return await db.query('courses');
  }

  // Fetch all subjects for a specific course
  Future<List<Map<String, dynamic>>> getSubjects(int courseId) async {
    Database db = await database;
    return await db
        .query('subjects', where: 'course_id = ?', whereArgs: [courseId]);
  }

  // Fetch all staff
  Future<List<Map<String, dynamic>>> getStaff() async {
    Database db = await database;
    return await db.query('staff');
  }

  // Close the database
  Future close() async {
    Database db = await database;
    db.close();
  }

  // delete a course from the database
  Future<void> deleteCourse(int courseId) async {
    Database db = await database;
    await db.delete(
      "courses",
      where: "id=?",
      whereArgs: [courseId],
    );

    // subjects delete
    await db.delete(
      "subjects",
      where: "course_id=?",
      whereArgs: [courseId],
    );
  }

  // delete staff
  Future<void> deleteStaff(int staffId) async {
    Database db = await database;
    await db.delete(
      "staff",
      where: "id=?",
      whereArgs: [staffId],
    );
  }
//timetable strorage

  Future<int> insertTimetable(Map<String, dynamic> timetableData) async {
    final db = await database;
    return await db.insert('timetable', timetableData);
  }

  Future<List<Map<String, dynamic>>> getTimetables() async {
    final db = await database;
    return await db.query('timetable');
  }

  //delete timetable

  Future<void> deletetimetable(int timetableId) async {
    final db = await database;
    await db.delete(
      "timetable",
      where: "id=?",
      whereArgs: [timetableId],
    );
  }
}
