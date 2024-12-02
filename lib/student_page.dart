import 'package:flutter/material.dart';

// Import other pages
import 'mentor_connect_page.dart';
import 'doubt_sessions_page.dart';
import 'resource_exchange_page.dart';
import 'carpool_page.dart';
import 'event_calender_page.dart';

// Import components

import 'weekly_timetable.dart';

class StudentPage extends StatefulWidget {
  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Student Dashboard',
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
                  _buildStudentInfo(),
                  SizedBox(height: 20),
                  _buildQuickAccessSection(context),
                  SizedBox(height: 20),
                  WeeklyTimetable(),
                  SizedBox(height: 20),
                  _buildStudentActivities(),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentInfo() {
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
        subtitle: Text('Student ID: 12345', style: TextStyle(color: Colors.white70)),
        trailing: Icon(Icons.edit, color: Color(0xFFF88E20)),
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
                icon: Icons.people_outline,
                title: 'Mentor Connect',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MentorConnectPage()),
                ),
              ),
              SizedBox(width: 10),
              _buildQuickAccessCard(
                icon: Icons.help_outline,
                title: 'Doubt Sessions',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DoubtSessionsPage()),
                ),
              ),
              SizedBox(width: 10),
              _buildQuickAccessCard(
                icon: Icons.drive_eta,
                title: 'Carpool',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CarpoolPage()),
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentActivities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activities',
          style: TextStyle(
            color: Color(0xFFF88E20),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(16),
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
          child: Text(
            'You completed the assignment "Machine Learning Assignment 1".',
            style: TextStyle(color: Colors.white70),
          ),
        ),
      ],
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
                'student@university.com',
                style: TextStyle(color: Colors.white70),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Color(0xFFF88E20),
                child: Icon(Icons.person, color: Colors.white, size: 40),
              ),
              decoration: BoxDecoration(color: Color(0xFF1E1E1E)),
            ),
            _buildDrawerItem(
              icon: Icons.home,
              title: 'Dashboard',
              onTap: () => Navigator.pushReplacementNamed(context, '/home'),
            ),
            _buildDrawerItem(
              icon: Icons.people_outline,
              title: 'Mentor Connect',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MentorConnectPage()),
              ),
            ),
            _buildDrawerItem(
              icon: Icons.help_outline,
              title: 'Doubt Sessions',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DoubtSessionsPage()),
              ),
            ),
            _buildDrawerItem(
              icon: Icons.book_online,
              title: 'Resource Exchange',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ResourceExchangePage()),
              ),
            ),
            _buildDrawerItem(
              icon: Icons.drive_eta,
              title: 'Campus Carpool',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CarpoolPage()),
              ),
            ),
            _buildDrawerItem(
              icon: Icons.calendar_today,
              title: 'Event Calendar',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EventCalendarPage()),
              ),
            ),
            Divider(color: Colors.white30),
            _buildDrawerItem(
              icon: Icons.settings,
              title: 'Settings',
              onTap: () => Navigator.pushNamed(context, '/settings'),
            ),
            _buildDrawerItem(
              icon: Icons.exit_to_app,
              title: 'Logout',
              onTap: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
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