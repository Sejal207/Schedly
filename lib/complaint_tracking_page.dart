import 'package:flutter/material.dart';

class ComplaintTrackingPage extends StatefulWidget {
  @override
  _ComplaintTrackingPageState createState() => _ComplaintTrackingPageState();
}

class _ComplaintTrackingPageState extends State<ComplaintTrackingPage> {
  final List<Map<String, dynamic>> _complaints = [
    {
      'id': 1,
      'title': 'Broken Lab Equipment',
      'description': 'Science lab microscope is damaged',
      'submittedBy': 'Jane Smith',
      'status': 'Pending',
      'date': '2024-03-15'
    },
    {
      'id': 2,
      'title': 'Scheduling Conflict',
      'description': 'Double booking of conference room',
      'submittedBy': 'John Doe',
      'status': 'In Progress',
      'date': '2024-03-10'
    },
    {
      'id': 3,
      'title': 'IT Support Request',
      'description': 'Network connectivity issues',
      'submittedBy': 'Alice Johnson',
      'status': 'Resolved',
      'date': '2024-03-05'
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'In Progress':
        return Colors.blue;
      case 'Resolved':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  void _showComplaintDetailsModal(Map<String, dynamic> complaint) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Color(0xFF2C2C2C),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  complaint['title'],
                  style: TextStyle(
                    color: Color(0xFFF88E20),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Description: ${complaint['description']}',
                  style: TextStyle(color: Colors.white70),
                ),
                SizedBox(height: 8),
                Text(
                  'Submitted By: ${complaint['submittedBy']}',
                  style: TextStyle(color: Colors.white70),
                ),
                SizedBox(height: 8),
                Text(
                  'Date: ${complaint['date']}',
                  style: TextStyle(color: Colors.white70),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Status: ${complaint['status']}',
                      style: TextStyle(
                        color: _getStatusColor(complaint['status']),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.check_circle, color: Colors.green),
                          onPressed: () {
                            // Resolve complaint
                            Navigator.pop(context);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.red),
                          onPressed: () {
                            // Reject or escalate complaint
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Complaint Tracking',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF88E20),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.filter_list, color: Colors.white70),
                      onPressed: () {
                        // Implement filtering logic
                      },
                    ),
                  ],
                ),
              ),

              // Complaints List
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _complaints.length,
                  itemBuilder: (context, index) {
                    final complaint = _complaints[index];
                    return Card(
                      color: Color(0xFF2C2C2C),
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(
                          complaint['title'],
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          complaint['submittedBy'],
                          style: TextStyle(color: Colors.white54),
                        ),
                        trailing: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(complaint['status'])
                                .withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            complaint['status'],
                            style: TextStyle(
                              color: _getStatusColor(complaint['status']),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        onTap: () => _showComplaintDetailsModal(complaint),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}