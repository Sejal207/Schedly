import 'package:flutter/material.dart';
import 'models/class_schedule.dart'; // Import the shared data model
import 'day_timetable.dart';
import 'models/extra_class.dart'; // Import the ExtraClass model
// Import the DayTimetablePage

class WeeklyTimetable extends StatelessWidget {
  final List<DailySchedule> weeklySchedule = [
    DailySchedule(
      day: 'Monday',
      classes: [
        ClassSchedule(name: 'DC&CN', time: '09:00 AM - 10:30 AM', room: 'Lab 309'),
        ClassSchedule(name: 'DBMS', time: '11:00 AM - 12:30 PM', room: 'NB 204'),
        ClassSchedule(name: 'Java', time: '02:00 PM - 03:30 PM', room: 'Auditorium'),
        ClassSchedule(name: 'DC&CN', time: '04:00 AM - 05:30 AM', room: 'Lab 3')

      ],
    ),
    DailySchedule(
      day: 'Tuesday',
      classes: [
        ClassSchedule(name: 'DBMS', time: '09:00 AM - 10:30 AM', room: 'NB 204'),
        ClassSchedule(name: 'DAA', time: '11:00 AM - 12:30 PM', room: 'Lab 2'),
        ClassSchedule(name: 'DC&CN', time: '02:00 PM - 03:30 PM', room: 'NB 305'),
        ClassSchedule(name: 'Web', time: '04:00 AM - 05:30 AM', room: 'Lab 3'),
        ClassSchedule(name: 'Web', time: '04:00 AM - 05:30 AM', room: 'Lab 3'),
        ClassSchedule(name: 'Web', time: '04:00 AM - 05:30 AM', room: 'Lab 3')

      ],
    ),
    DailySchedule(
      day: 'Wednesday',
      classes: [
        ClassSchedule(name: 'DC&CN', time: '09:00 AM - 10:30 AM', room: 'Lab 3'),
        ClassSchedule(name: 'Machine Learning', time: '11:00 AM - 12:30 PM', room: 'Auditorium'),
        ClassSchedule(name: 'Professional Communication', time: '02:00 PM - 03:30 PM', room: 'NB 101'),
      ],
    ),
    DailySchedule(
      day: 'Thursday',
      classes: [
        ClassSchedule(name: 'Data Structures', time: '09:00 AM - 10:30 AM', room: 'Lab 2'),
        ClassSchedule(name: 'Software Engineering', time: '11:00 AM - 12:30 PM', room: 'Room 305'),
        ClassSchedule(name: 'Professional Communication', time: '02:00 PM - 03:30 PM', room: 'Room 101'),
        ClassSchedule(name: 'DAA', time: '11:00 AM - 12:30 PM', room: 'Lab 2'),
        ClassSchedule(name: 'DC&CN', time: '02:00 PM - 03:30 PM', room: 'NB 305')

      ],
    ),
    DailySchedule(
      day: 'Friday',
      classes: [
        ClassSchedule(name: 'DBMS', time: '09:00 AM - 10:30 AM', room: 'Room 204'),
        ClassSchedule(name: 'DC&CN', time: '11:00 AM - 12:30 PM', room: 'Lab 3'),
        ClassSchedule(name: 'Machine Learning', time: '02:00 PM - 03:30 PM', room: 'Auditorium'),
        ClassSchedule(name: 'DBMS', time: '09:00 AM - 10:30 AM', room: 'NB 204'),
        ClassSchedule(name: 'DAA', time: '11:00 AM - 12:30 PM', room: 'Lab 2'),
        ClassSchedule(name: 'Java', time: '02:00 PM - 03:30 PM', room: 'NB 305')
      ],
    ),
  ];

  final List<ExtraClass> extraClasses = [
    ExtraClass(
      subject: 'Machine Learning',
      instructor: 'Dr. Devanjali Relan ',
      date: 'Friday, 4:00 PM',
      description: 'Additional lab session for complex neural network concepts',
    ),
    ExtraClass(
      subject: 'DBMS',
      instructor: 'Mrs. Nishtha Phutela',
      date: 'Saturday, 10:00 AM',
      description: 'Workshop on advanced database optimization techniques',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Weekly Timetable Section
        Text(
          'Weekly Timetable',
          style: TextStyle(
            color: Color(0xFFF88E20),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(scrollDirection: Axis.vertical,child:Row(
            children: weeklySchedule.map((dailySchedule) {
              return _buildDailyScheduleCard(context, dailySchedule);
            }).toList(),
          ),),
        ),
        SizedBox(height: 20),

        // Extra Classes Section
        Text(
          'Upcoming Extra Classes',
          style: TextStyle(
            color: Color(0xFFF88E20),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Column(
          children: extraClasses.map((extraClass) {
            return _buildExtraClassCard(extraClass);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDailyScheduleCard(BuildContext context, DailySchedule dailySchedule) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DayTimetablePage(
              day: dailySchedule.day,
              classes: dailySchedule.classes,
            ),
          ),
        );
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dailySchedule.day,
                style: TextStyle(
                  color: Color(0xFFF88E20),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 10),
              ...dailySchedule.classes.map((classSchedule) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          classSchedule.name,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            classSchedule.time,
                            style: TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                          Text(
                            classSchedule.room,
                            style: TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildExtraClassCard(ExtraClass extraClass) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                extraClass.subject,
                style: TextStyle(
                  color: Color(0xFFF88E20),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                extraClass.date,
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
          SizedBox(height: 5),
          Text(
            'Instructor: ${extraClass.instructor}',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 5),
          Text(
            extraClass.description,
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
