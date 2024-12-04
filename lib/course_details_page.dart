import 'package:flutter/material.dart';

class CourseDetailsPage extends StatefulWidget {
  final Map<String, dynamic> course;
  final Function(double) onProgressUpdated;

  const CourseDetailsPage({
    required this.course,
    required this.onProgressUpdated,
  });

  @override
  _CourseDetailsPageState createState() => _CourseDetailsPageState();
}

class _CourseDetailsPageState extends State<CourseDetailsPage> {
  void _toggleAssignmentCompletion(int index) {
    setState(() {
      widget.course['assignments'][index]['completed'] =
      !widget.course['assignments'][index]['completed'];

      // Update progress
      final completedAssignments = widget.course['assignments']
          .where((assignment) => assignment['completed'])
          .length;

      final totalAssignments = widget.course['assignments'].length;
      final progress = completedAssignments / totalAssignments;

      widget.onProgressUpdated(progress);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.course['title'],
          style: const TextStyle(
              color: Colors.orange, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: widget.course['assignments'].length,
        itemBuilder: (context, index) {
          final assignment = widget.course['assignments'][index];

          return ListTile(
            title: Text(
              assignment['name'],
              style: const TextStyle(color: Colors.white),
            ),
            trailing: Checkbox(
              value: assignment['completed'],
              onChanged: (value) {
                _toggleAssignmentCompletion(index);
              },
              activeColor: Colors.orange,
            ),
          );
        },
      ),
    );
  }
}
