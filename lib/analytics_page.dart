import 'package:flutter/material.dart';

class AnalyticsPage extends StatefulWidget {
  @override
  _AnalyticsPageState createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  final List<Map<String, dynamic>> _analyticsData = [
    {
      'title': 'Total Users',
      'value': '1,254',
      'icon': Icons.people,
      'color': Colors.blue
    },
    {
      'title': 'Active Complaints',
      'value': '37',
      'icon': Icons.warning,
      'color': Colors.orange
    },
    {
      'title': 'Resources Borrowed',
      'value': '256',
      'icon': Icons.book,
      'color': Colors.green
    },
    {
      'title': 'Upcoming Events',
      'value': '12',
      'icon': Icons.event,
      'color': Colors.purple
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analytics Dashboard'),
        backgroundColor: Color(0xFF121212),
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
        child: Column(
          children: [
            // Quick Stats Grid
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.2,
                ),
                itemCount: _analyticsData.length,
                itemBuilder: (context, index) {
                  final stat = _analyticsData[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF2C2C2C),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          stat['icon'],
                          size: 48,
                          color: stat['color'],
                        ),
                        SizedBox(height: 10),
                        Text(
                          stat['title'],
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          stat['value'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // More detailed analytics section could be added here
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Detailed reports and visualizations coming soon',
                style: TextStyle(color: Colors.white54),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}