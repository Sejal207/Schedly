import 'package:flutter/material.dart';
import 'package:schedly_prjapp/main.dart';

// Import the admin-specific pages
import 'user_management_page.dart';
import 'complaint_tracking_page.dart';
import 'resource_oversight_page.dart';
import 'events_management_page.dart';
import 'analytics_page.dart';
import 'system_config_page.dart';


class AdminDashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin Dashboard',
          style: TextStyle(color: Color(0xFFF88E20), fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF1E1E1E),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Color(0xFFF88E20)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('5 new system alerts')),
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
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            _buildAdminInfo(),
            SizedBox(height: 20),
            _buildQuickAccessSection(context),
            SizedBox(height: 20),
            SystemOverviewCards(), // System overview component
            SizedBox(height: 20),
            _buildRecentActivities(),
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
                'Admin User',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              accountEmail: Text(
                'admin@university.com',
                style: TextStyle(color: Colors.white70),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Color(0xFFF88E20),
                child: Icon(Icons.admin_panel_settings, color: Colors.white, size: 40),
              ),
              decoration: BoxDecoration(color: Color(0xFF1E1E1E)),
            ),
            _buildDrawerItem(
              icon: Icons.dashboard,
              title: 'Dashboard',
              onTap: () => Navigator.pushReplacementNamed(context, '/admin-home'),
            ),
            _buildDrawerItem(
              icon: Icons.people,
              title: 'User Management',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserManagementPage()),
              ),
            ),
            _buildDrawerItem(
              icon: Icons.report_problem,
              title: 'Complaint Tracking',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ComplaintTrackingPage()),
              ),
            ),
            _buildDrawerItem(
              icon: Icons.library_books,
              title: 'Resource Oversight',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ResourceOversightPage()),
              ),
            ),
            _buildDrawerItem(
              icon: Icons.event,
              title: 'Event Management',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EventManagementPage()),
              ),
            ),
            _buildDrawerItem(
              icon: Icons.analytics,
              title: 'System Analytics',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AnalyticsPage()),
              ),
            ),
            _buildDrawerItem(
              icon: Icons.settings,
              title: 'System Configuration',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SystemConfigPage()),
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

  Widget _buildAdminInfo() {
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
          child: Icon(Icons.admin_panel_settings, color: Colors.white),
        ),
        title: Text(
          'Admin User',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Text('System Administrator', style: TextStyle(color: Colors.white70)),
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
                icon: Icons.people,
                title: 'Users',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserManagementPage()),
                ),
              ),
              SizedBox(width: 10),
              _buildQuickAccessCard(
                icon: Icons.report_problem,
                title: 'Complaints',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ComplaintTrackingPage()),
                ),
              ),
              SizedBox(width: 10),
              _buildQuickAccessCard(
                icon: Icons.analytics,
                title: 'Analytics',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AnalyticsPage()),
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

  Widget _buildRecentActivities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent System Activities',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '• 3 new user registrations',
                style: TextStyle(color: Colors.white70),
              ),
              Text(
                '• 2 unresolved complaints',
                style: TextStyle(color: Colors.white70),
              ),
              Text(
                '• System backup completed',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ------------------ System Overview Component ------------------
class SystemOverviewCards extends StatefulWidget {
  @override
  _SystemOverviewCardsState createState() => _SystemOverviewCardsState();
}

class _SystemOverviewCardsState extends State<SystemOverviewCards> {
  final List<SystemMetric> metrics = [
    SystemMetric(
      title: "Total Users",
      value: "1,234",
      icon: Icons.people,
      color: Colors.blueAccent,
    ),
    SystemMetric(
      title: "Active Complaints",
      value: "12",
      icon: Icons.report_problem,
      color: Colors.orangeAccent,
    ),
    SystemMetric(
      title: "Resources",
      value: "456",
      icon: Icons.library_books,
      color: Colors.greenAccent,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'System Overview',
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
            children: metrics.map((metric) {
              return _buildMetricCard(metric);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard(SystemMetric metric) {
    return Container(
      width: 180,
      margin: EdgeInsets.only(right: 10),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(metric.icon, color: metric.color, size: 40),
              Text(
                metric.value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            metric.title,
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

class SystemMetric {
  String title;
  String value;
  IconData icon;
  Color color;

  SystemMetric({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });
}