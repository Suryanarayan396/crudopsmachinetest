class Timetable {
  final int id;
  final int courseId;
  final String subject;
  final int staffId;
  final String day;
  final String startTime;
  final String endTime;

  Timetable({
    required this.id,
    required this.courseId,
    required this.subject,
    required this.staffId,
    required this.day,
    required this.startTime,
    required this.endTime,
  });

  // Convert a map to a Timetable object
  factory Timetable.fromMap(Map<String, dynamic> map) {
    return Timetable(
      id: map['id'],
      courseId: map['course_id'],
      subject: map['subject'],
      staffId: map['staff_id'],
      day: map['day'],
      startTime: map['start_time'],
      endTime: map['end_time'],
    );
  }

  // Convert Timetable object to map
  Map<String, dynamic> toMap() {
    return {
      'course_id': courseId,
      'subject': subject,
      'staff_id': staffId,
      'day': day,
      'start_time': startTime,
      'end_time': endTime,
    };
  }
}
