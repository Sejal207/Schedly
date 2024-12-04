import 'package:flutter/material.dart';

class EventManagementPage extends StatefulWidget {
  @override
  _EventManagementPageState createState() => _EventManagementPageState();
}

class _EventManagementPageState extends State<EventManagementPage> {
  List<Map<String, String>> _events = [
    {
      'title': 'Annual Staff Meeting',
      'date': '2024-12-15',
      'time': '10:00 AM',
      'location': 'Main Conference Hall'
    },
    {
      'title': 'Student Workshop',
      'date': '2024-11-20',
      'time': '2:00 PM',
      'location': 'Classroom A'
    },
  ];

  void _addEvent() {
    // Implement event addition logic
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Event'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Event Title'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Date'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Time'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Location'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Management'),
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
        child: ListView.builder(
          itemCount: _events.length,
          itemBuilder: (context, index) {
            final event = _events[index];
            return Card(
              color: Color(0xFF2C2C2C),
              margin: EdgeInsets.all(8),
              child: ListTile(
                title: Text(
                  event['title']!,
                  style: TextStyle(color: Colors.white70),
                ),
                subtitle: Text(
                  '${event['date']} at ${event['time']} | ${event['location']}',
                  style: TextStyle(color: Colors.white54),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    // Implement delete logic
                  },
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEvent,
        backgroundColor: Color(0xFFF88E20),
        child: Icon(Icons.add),
      ),
    );
  }
}