import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MeetingsEventsPage extends StatefulWidget {
  @override
  _MeetingsEventsPageState createState() => _MeetingsEventsPageState();
}

class _MeetingsEventsPageState extends State<MeetingsEventsPage> {
  List<Map<String, dynamic>> _meetings = [
    {
      'title': 'Parent-Teacher Conference',
      'date': DateTime(2024, 3, 15, 14, 0),
      'location': 'School Conference Room',
      'type': 'Conference'
    },
    {
      'title': 'Staff Meeting',
      'date': DateTime(2024, 3, 20, 10, 30),
      'location': 'Staff Lounge',
      'type': 'Internal Meeting'
    },
    {
      'title': 'Curriculum Planning',
      'date': DateTime(2024, 3, 25, 16, 0),
      'location': 'Library Meeting Room',
      'type': 'Workshop'
    },
  ];

  String _formatDate(DateTime date) {
    return '${_getWeekday(date)}, ${_getMonth(date)} ${date.day}, ${date.year} - ${_formatTime(date)}';
  }

  String _getWeekday(DateTime date) {
    const weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    return weekdays[date.weekday - 1];
  }

  String _getMonth(DateTime date) {
    const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
    return months[date.month - 1];
  }

  String _formatTime(DateTime date) {
    String hour = date.hour.toString().padLeft(2, '0');
    String minute = date.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  void _addEvent() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 20,
            left: 20,
            right: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add New Event',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF88E20),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Event Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Location',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Date',
                          border: OutlineInputBorder(),
                        ),
                        onTap: () {
                          showCupertinoModalPopup(
                            context: context,
                            builder: (context) => Container(
                              height: 216,
                              padding: EdgeInsets.only(top: 6.0),
                              margin: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom,
                              ),
                              color: CupertinoColors.systemBackground.resolveFrom(context),
                              child: SafeArea(
                                top: false,
                                child: CupertinoDatePicker(
                                  initialDateTime: DateTime.now(),
                                  mode: CupertinoDatePickerMode.dateAndTime,
                                  use24hFormat: true,
                                  onDateTimeChanged: (DateTime newDateTime) {
                                    // Handle date selection
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Event Type',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Save Event'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF88E20),
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),
                SizedBox(height: 20),
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
      appBar: AppBar(
        title: Text(
          'Meetings & Events',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF121212),
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
          itemCount: _meetings.length,
          itemBuilder: (context, index) {
            final meeting = _meetings[index];
            return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: Color(0xFF2C2C2C),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                title: Text(
                  meeting['title'],
                  style: TextStyle(
                    color: Color(0xFFF88E20),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Text(
                      _formatDate(meeting['date']),
                      style: TextStyle(color: Colors.white70),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Location: ${meeting['location']}',
                      style: TextStyle(color: Colors.white70),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Type: ${meeting['type']}',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      _meetings.removeAt(index);
                    });
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
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}