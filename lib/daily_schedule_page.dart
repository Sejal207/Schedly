import 'package:flutter/material.dart';

class DailySchedulePage extends StatefulWidget {
  @override
  _DailySchedulePageState createState() => _DailySchedulePageState();
}

class _DailySchedulePageState extends State<DailySchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Daily Schedule'),
        backgroundColor: Color(0xFFF88E20),
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
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            _buildScheduleCard(
              time: '09:00 AM - 10:30 AM',
              subject: 'Mathematics',
              className: 'Grade 10-A',
            ),
            _buildScheduleCard(
              time: '11:00 AM - 12:30 PM',
              subject: 'Physics',
              className: 'Grade 11-B',
            ),
            // Add more schedule cards as needed
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleCard({
    required String time,
    required String subject,
    required String className,
  }) {
    return Card(
      color: Color(0xFF1E1E1E),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(
          subject,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          '$time | $className',
          style: TextStyle(color: Colors.white70),
        ),
        leading: Icon(
          Icons.schedule,
          color: Color(0xFFF88E20),
        ),
      ),
    );
  }
}
