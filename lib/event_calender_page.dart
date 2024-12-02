import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uuid/uuid.dart';

// Event Model
class Event {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String Club;
  final String location;
  final List<String> attendees;

  Event({
    String? id,
    required this.title,
    required this.description,
    required this.date,
    required this.Club,
    this.location = '',
    this.attendees = const [],
  }) : id = id ?? Uuid().v4();

  Event copyWith({
    String? title,
    String? description,
    DateTime? date,
    String? location,
    String? Club,
    List<String>? attendees,
  }) {
    return Event(
      id: this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      location: location ?? this.location,
      attendees: attendees ?? this.attendees,
      Club: Club ?? this.Club
    );
  }
}

// Event Service
class EventService {
  static List<Event> events = [
    Event(
      title: 'Machine Learning Workshop',
      description: 'Hands-on workshop on latest ML techniques',
      date: DateTime.now().add(Duration(days: 7)),
      location: 'Tech Conference Hall',
      attendees: ['Alex', 'Sarah', 'Mike'],
      Club: 'ACM',
    ),
    Event(
      title: 'Python Coding Meetup',
      description: 'Monthly Python programming community meetup',
      date: DateTime.now().add(Duration(days: 14)),
      location: 'Community Center',
      attendees: ['John', 'Emma'],
      Club: 'Scimat'
    ),
  ];

  static void addEvent(Event event) {
    events.add(event);
  }

  static void updateEvent(Event updatedEvent) {
    final index = events.indexWhere((event) => event.id == updatedEvent.id);
    if (index != -1) {
      events[index] = updatedEvent;
    }
  }

  static List<Event> getEventsForDay(DateTime day) {
    return events.where((event) =>
        isSameDay(event.date, day)
    ).toList();
  }

  static bool isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) {
      return false;
    }
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}

// Event Calendar Page
class EventCalendarPage extends StatefulWidget {
  @override
  _EventCalendarPageState createState() => _EventCalendarPageState();
}

class _EventCalendarPageState extends State<EventCalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<Event> _selectedEvents = [];

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = EventService.getEventsForDay(_selectedDay!);
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!EventService.isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _selectedEvents = EventService.getEventsForDay(selectedDay);
      });
    }
  }

  void _showAddEventDialog() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final locationController = TextEditingController();
    DateTime selectedDate = _selectedDay ?? DateTime.now();
    final ClubController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Add New Event'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: 'Event Title',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: descriptionController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Event Description',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: locationController,
                      decoration: InputDecoration(
                        labelText: 'Location',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: ClubController,
                      decoration: InputDecoration(
                        labelText: 'Organised by Club',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        Text('Date: '),
                        TextButton(
                          child: Text(
                            '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}',
                          ),
                          onPressed: () async {
                            final pickedDate = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (pickedDate != null) {
                              setState(() {
                                selectedDate = pickedDate;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                ElevatedButton(
                  child: Text('Add'),
                  onPressed: () {
                    if (titleController.text.isNotEmpty) {
                      final newEvent = Event(
                        title: titleController.text,
                        description: descriptionController.text,
                        date: selectedDate,
                        location: locationController.text,
                        Club: ClubController.text
                      );

                      EventService.addEvent(newEvent);

                      // Refresh events for the selected day
                      setState(() {
                        _selectedEvents = EventService.getEventsForDay(_selectedDay!);
                      });

                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Calendar'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return EventService.isSameDay(_selectedDay, day);
            },
            onDaySelected: _onDaySelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            eventLoader: (day) {
              return EventService.getEventsForDay(day);
            },
          ),
          Expanded(
            child: _selectedEvents.isEmpty
                ? Center(child: Text('No events for this day'))
                : ListView.builder(
              itemCount: _selectedEvents.length,
              itemBuilder: (context, index) {
                final event = _selectedEvents[index];
                return ListTile(
                  title: Text(event.title),
                  subtitle: Text(event.location),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddEventDialog,
        child: Icon(Icons.add),
        tooltip: 'Add New Event',
      ),
    );
  }
}