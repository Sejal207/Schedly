import 'package:flutter/material.dart';

class WeeklyTimetableForTeacher extends StatelessWidget {
  final List<DailyScheduleForTeacher> weeklySchedule = [
    DailyScheduleForTeacher(
      day: 'Monday',
      classes: [
        TeacherClassSchedule(
          subject: 'Mathematics',
          division: 'CSE 1',
          classroom: 'Room 101',
          time: '09:00 AM - 10:00 AM',
        ),
        TeacherClassSchedule(
          subject: 'Physics',
          division: 'CSE4',
          classroom: 'Lab 202',
          time: '10:15 AM - 11:15 AM',
        ),
        TeacherClassSchedule(
          subject: 'Chemistry',
          division: 'CSE7',
          classroom: 'Lab 303',
          time: '11:30 AM - 12:30 PM',
        ),
      ],
    ),
    DailyScheduleForTeacher(
      day: 'Tuesday',
      classes: [
        TeacherClassSchedule(
          subject: 'Computer Science',
          division: 'CSE4',
          classroom: 'Room 104',
          time: '09:00 AM - 10:00 AM',
        ),
        TeacherClassSchedule(
          subject: 'Mathematics',
          division: 'CSE7',
          classroom: 'Room 201',
          time: '10:15 AM - 11:15 AM',
        ),
        TeacherClassSchedule(
          subject: 'Physics',
          division: 'CSE5',
          classroom: 'Lab 202',
          time: '11:30 AM - 12:30 PM',
        ),
      ],
    ),
    // Add more days as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Weekly Timetable Section
        Text(
          'Teacher\'s Weekly Timetable',
          style: TextStyle(
            color: Color(0xFFF88E20),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: weeklySchedule.map((dailySchedule) {
              return _buildDailyScheduleCard(context, dailySchedule);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildDailyScheduleCard(BuildContext context, DailyScheduleForTeacher dailySchedule) {
    return GestureDetector(
      onTap: () {
        // Navigate to a detailed day view if needed
      },
      child: Container(
        width: 250,
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(0xFF2C2C2C),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              offset: Offset(0, 4),
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Day title
            Text(
              dailySchedule.day,
              style: TextStyle(
                color: Color(0xFFF88E20),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            // Vertically scrollable class list
            Container(
              height: 150, // Adjust height as needed
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Column(
                    children: dailySchedule.classes.map((classSchedule) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.3),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                classSchedule.subject,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  classSchedule.division,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  classSchedule.time,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  classSchedule.classroom,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Data Models
class DailyScheduleForTeacher {
  final String day;
  final List<TeacherClassSchedule> classes;

  DailyScheduleForTeacher({required this.day, required this.classes});
}

class TeacherClassSchedule {
  final String subject;
  final String division;
  final String classroom;
  final String time;

  TeacherClassSchedule({
    required this.subject,
    required this.division,
    required this.classroom,
    required this.time,
  });
}
