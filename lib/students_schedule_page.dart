import 'package:flutter/material.dart';

class ClassSchedulingPage extends StatefulWidget {
  @override
  _ClassSchedulingPageState createState() => _ClassSchedulingPageState();
}

class _ClassSchedulingPageState extends State<ClassSchedulingPage> {
  List<Map<String, dynamic>> _availableRooms = [
    {'room': 'Room 101', 'time': '10:30 AM - 12:00 PM', 'isBooked': false},
    {'room': 'Room 203', 'time': '01:00 PM - 02:30 PM', 'isBooked': false},
    {'room': 'Auditorium', 'time': '11:45 AM - 01:15 PM', 'isBooked': false},
    {'room': 'Lab 1', 'time': '02:45 PM - 04:15 PM', 'isBooked': false},
    {'room': 'Room 302', 'time': '09:00 AM - 10:30 AM', 'isBooked': false},
  ];

  void _showRescheduleDialog() {
    final _formKey = GlobalKey<FormState>();
    String? _selectedRoom;
    String? _subject;
    String? _className;
    DateTime? _selectedDate;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: Color(0xFF1E1E1E),
          title: Text(
            'Reschedule / Add Class',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Subject Input
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Subject',
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter subject'
                        : null,
                    onSaved: (value) => _subject = value,
                  ),
                  SizedBox(height: 16),

                  // Class Name Input
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Class',
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter class name'
                        : null,
                    onSaved: (value) => _className = value,
                  ),
                  SizedBox(height: 16),

                  // Room Selection Dropdown
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Available Rooms',
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70),
                      ),
                    ),
                    dropdownColor: Color(0xFF2C2C2C),
                    style: TextStyle(color: Colors.white),
                    items: _availableRooms
                        .where((room) => !room['isBooked']) // Only available rooms
                        .map<DropdownMenuItem<String>>((room) {
                      return DropdownMenuItem<String>(
                        value: room['room'], // Room name as the value
                        child: Text('${room['room']} (${room['time']})'), // Display room and time
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedRoom = value;
                      });
                    },
                    validator: (value) => value == null
                        ? 'Please select a room'
                        : null,
                  ),

                  SizedBox(height: 16),

                  // Date Picker
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFF88E20), // Updated primary to backgroundColor
                        ),
                        onPressed: () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(Duration(days: 90)),
                            builder: (context, child) {
                              return Theme(
                                data: ThemeData.dark().copyWith(
                                  colorScheme: ColorScheme.dark(
                                    primary: Color(0xFFF88E20),
                                    onPrimary: Colors.white,
                                    surface: Color(0xFF1E1E1E),
                                    onSurface: Colors.white,
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );

                          if (pickedDate != null) {
                            setState(() {
                              _selectedDate = pickedDate;
                            });
                          }
                        },
                        child: Text(
                          _selectedDate == null
                              ? 'Select Date'
                              : 'Date: ${_selectedDate!.toLocal()}'.split(' ')[0],
                          style: TextStyle(color: Colors.white), // Button text color
                        ),
                      ),
                    ],
                  )

                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel', style: TextStyle(color: Colors.white70)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFF88E20), // Updated primary to backgroundColor
              ),
              onPressed: () {
                if (_formKey.currentState!.validate() && _selectedDate != null) {
                  _formKey.currentState!.save();

                  // Update room booking status
                  final index = _availableRooms.indexWhere(
                          (room) => room['room'] == _selectedRoom
                  );

                  if (index != -1) {
                    setState(() {
                      _availableRooms[index]['isBooked'] = true;
                    });
                  }

                  // Show confirmation
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Class scheduled successfully!'),
                      backgroundColor: Colors.green,
                    ),
                  );

                  Navigator.of(context).pop();
                }
              },
              child: (Text('Schedule',
              style: TextStyle(color: Colors.white)))
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flexible Class Scheduling'),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Available Classrooms',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _availableRooms.length,
                itemBuilder: (context, index) {
                  return _buildRoomCard(_availableRooms[index]);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showRescheduleDialog,
        backgroundColor: Color(0xFFF88E20),
        child: Icon(Icons.add),
        tooltip: 'Schedule New Class',
      ),
    );
  }

  Widget _buildRoomCard(Map<String, dynamic> room) {
    return Card(
      color: room['isBooked'] ? Colors.grey[800] : Color(0xFF1E1E1E),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(
          room['room'],
          style: TextStyle(
            color: room['isBooked'] ? Colors.white54 : Color(0xFFF88E20),
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          'Available: ${room['time']}',
          style: TextStyle(color: room['isBooked'] ? Colors.white38 : Colors.white70),
        ),
        trailing: Icon(
          room['isBooked'] ? Icons.lock : Icons.schedule,
          color: room['isBooked'] ? Colors.white54 : Colors.white,
        ),
      ),
    );
  }
}
