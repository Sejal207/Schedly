import 'package:flutter/material.dart';
import 'models/class_schedule.dart'; // Import the shared data model

class DayTimetablePage extends StatelessWidget {
  final String day;
  final List<ClassSchedule> classes;

  DayTimetablePage({
    Key? key,
    required this.day,
    required this.classes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$day Timetable',
          style: TextStyle(color: Color(0xFFF88E20), fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF1E1E1E),

      ),
      body: ListView.builder(
        itemCount: classes.length,
        itemBuilder: (context, index) {
          final classSchedule = classes[index];
          return ListTile(
            title: Text(classSchedule.name),
            subtitle: Text('${classSchedule.time} in ${classSchedule.room}'),
          );
        },
      ),
    );
  }
}
