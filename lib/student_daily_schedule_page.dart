import 'package:flutter/material.dart';

class StudentDailySchedulePage extends StatelessWidget {
  final String day;
  final List<ClassSchedule> classes;

  const StudentDailySchedulePage({
    Key? key,
    required this.day,
    required this.classes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$day Schedule',
          style: TextStyle(color: Color(0xFFF88E20), fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF1E1E1E),
        iconTheme: IconThemeData(color: Color(0xFFF88E20)),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF121212),
              Color(0xFF1E1E1E),
              Color(0xFF2C2C2C),
            ],
          ),
        ),
        child: ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: classes.length,
          itemBuilder: (context, index) {
            final classSchedule = classes[index];
            return _buildClassCard(classSchedule);
          },
        ),
      ),
    );
  }

  Widget _buildClassCard(ClassSchedule classSchedule) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
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
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        title: Text(
          classSchedule.name,
          style: TextStyle(
            color: Color(0xFFF88E20),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text(
              'Time: ${classSchedule.time}',
              style: TextStyle(color: Colors.white70),
            ),
            Text(
              'Room: ${classSchedule.room}',
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}

class ClassSchedule {
  final String name;
  final String time;
  final String room;

  ClassSchedule({
    required this.name,
    required this.time,
    required this.room,
  });
}