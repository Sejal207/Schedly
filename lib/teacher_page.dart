import 'package:flutter/material.dart';
import 'daily_schedule_page.dart';
import 'students_schedule_page.dart';
import 'class_scheduling_page.dart';
import 'meetings_events_page.dart';
import 'weekly_timetable_teachers.dart';
import 'main.dart';

class TeacherPage extends StatefulWidget {
  @override
  _TeacherPageState createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Teacher Dashboard',
          style: TextStyle(color: Color(0xFFF88E20), fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF1E1E1E),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Color(0xFFF88E20)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('No new notifications')),
              );
            },
          ),
        ],
      ),
      drawer: _buildDrawer(context),
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
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildTeacherInfo(),
                  SizedBox(height: 20),
                  _buildQuickAccessSection(context),
                  SizedBox(height: 20),
                  WeeklyTimetableForTeacher(),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeacherInfo() {
    return Container(
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
        leading: CircleAvatar(
          backgroundColor: Color(0xFFF88E20),
          child: Icon(Icons.person, color: Colors.white),
        ),
        title: Text(
          'John Doe',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Teacher ID: 100XYZ', style: TextStyle(color: Colors.white70)),
      ),
    );
  }

  Widget _buildQuickAccessSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Access',
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
            children: [

              _buildQuickAccessCard(
                icon: Icons.people,
                title: 'Student Schedules',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AcademicSchedulePage()),
                ),
              ),
              SizedBox(width: 10),
              _buildQuickAccessCard(
                icon: Icons.class_,
                title: 'Class Scheduling',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ClassSchedulingPage()),
                ),
              ),
              SizedBox(width: 10),
              _buildQuickAccessCard(
                icon: Icons.event,
                title: 'Meetings & Events',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MeetingsEventsPage()),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickAccessCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
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
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Color(0xFFF88E20), size: 40),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xFF1E1E1E),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                'John Doe',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              accountEmail: Text(
                'teacher@university.com',
                style: TextStyle(color: Colors.white70),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Color(0xFFF88E20),
                child: Icon(Icons.person, color: Colors.white, size: 40),
              ),
              decoration: BoxDecoration(color: Color(0xFF1E1E1E)),
            ),
            _buildDrawerItem(
              icon: Icons.schedule,
              title: 'Daily Schedule',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DailySchedulePage()),
              ),
            ),
            _buildDrawerItem(
              icon: Icons.people,
              title: 'Student Schedules',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AcademicSchedulePage()),
              ),
            ),
            _buildDrawerItem(
              icon: Icons.class_,
              title: 'Class Scheduling',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ClassSchedulingPage()),
              ),
            ),
            _buildDrawerItem(
              icon: Icons.event,
              title: 'Meetings & Events',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MeetingsEventsPage()),
              ),
            ),
            Divider(color: Colors.white30),
            _buildDrawerItem(
              icon: Icons.exit_to_app,
              title: 'Logout',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFFF88E20)),
      title: Text(title, style: TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }
}
