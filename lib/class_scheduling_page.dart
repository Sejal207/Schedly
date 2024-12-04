import 'package:flutter/material.dart';
import 'models/class_schedule.dart';

class AcademicSchedulePage extends StatelessWidget {
  // Define academic programs and their batches/divisions
  final Map<String, List<String>> academicPrograms = {
    'B.Tech': [
      '2024-28',
      '2023-27',
      '2022-26',
      '2021-25',
      'E-Com',
      'ME'
    ],
    'Professional Courses': [

      'BBA',
      'LLB',
      'MBA',
      'Liberal Arts',
      'Bcom'
    ],
    'Law': [
      'SOL'
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Academic Scheduling'),
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
        child: ListView.builder(
          itemCount: academicPrograms.keys.length,
          itemBuilder: (context, programIndex) {
            String programCategory = academicPrograms.keys.elementAt(programIndex);
            return _buildProgramCategoryExpansionTile(
                context,
                programCategory,
                academicPrograms[programCategory]!
            );
          },
        ),
      ),
    );
  }

  Widget _buildProgramCategoryExpansionTile(
      BuildContext context,
      String category,
      List<String> programs
      ) {
    return ExpansionTile(
      title: Text(
        category,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      iconColor: Color(0xFFF88E20),
      collapsedIconColor: Colors.white,
      children: programs.map((program) {
        return _buildProgramExpansionTile(context, program);
      }).toList(),
    );
  }

  Widget _buildProgramExpansionTile(BuildContext context, String program) {
    return ExpansionTile(
      title: Text(
        program,
        style: TextStyle(
          color: Color(0xFFF88E20),
          fontWeight: FontWeight.bold,
        ),
      ),
      iconColor: Color(0xFFF88E20),
      collapsedIconColor: Colors.white,
      children: List.generate(5, (index) {
        return _buildDivisionCard(
            context,
            '$program - Division ${index + 1}'
        );
      }),
    );
  }

  Widget _buildDivisionCard(BuildContext context, String division) {
    return Card(
      color: Color(0xFF1E1E1E),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(
          division,
          style: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Icon(
          Icons.schedule,
          color: Colors.white,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AcademicSchedulePage(),
            ),
          );
        },
      ),
    );
  }
}

// Main App Widget
class AcademicSchedulingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Timetable',
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFFF88E20),
        scaffoldBackgroundColor: Color(0xFF121212),
      ),
      home: AcademicSchedulePage(),
    );
  }
}

void main() {
  runApp(AcademicSchedulingApp());
}