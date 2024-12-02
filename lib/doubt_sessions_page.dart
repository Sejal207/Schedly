import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

// Doubt Model
class Doubt {
  final String id;
  final String title;
  final String description;
  final String status;
  final String priority;
  final DateTime createdAt;
  final String? resolvedBy;

  Doubt({
    String? id,
    required this.title,
    required this.description,
    this.status = 'Pending',
    this.priority = 'Medium',
    DateTime? createdAt,
    this.resolvedBy,
  })  : id = id ?? Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  Doubt copyWith({
    String? title,
    String? description,
    String? status,
    String? priority,
    String? resolvedBy,
  }) {
    return Doubt(
      id: this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      createdAt: this.createdAt,
      resolvedBy: resolvedBy ?? this.resolvedBy,
    );
  }
}

// Doubt Service
class DoubtService {
  static List<Doubt> doubts = [
    Doubt(
      title: 'Machine Learning Concepts',
      description: 'Need help understanding gradient descent',
      status: 'Pending',
      priority: 'High',
    ),
    Doubt(
      title: 'Python Programming',
      description: 'Struggling with list comprehensions',
      status: 'Resolved',
      priority: 'Medium',
      resolvedBy: 'John Smith',
    ),
    Doubt(
      title: 'Database Design',
      description: 'Complex query optimization',
      status: 'In Progress',
      priority: 'Low',
    ),
    Doubt(
      title: 'Development',
      description: 'express js issues',
      status: 'Pending',
      priority: 'High',
    ),
    Doubt(
      title: 'OOPS Programming',
      description: 'Struggling with hashmaps',
      status: 'Resolved',
      priority: 'Medium',
      resolvedBy: 'John Smith',
    ),
    Doubt(
      title: 'Database Design',
      description: 'Complex query optimization',
      status: 'In Progress',
      priority: 'Low',
    ),
  ];

  static void addDoubt(Doubt doubt) {
    doubts.add(doubt);
  }

  static void updateDoubt(Doubt updatedDoubt) {
    final index = doubts.indexWhere((doubt) => doubt.id == updatedDoubt.id);
    if (index != -1) {
      doubts[index] = updatedDoubt;
    }
  }

  static List<Doubt> filterDoubts(String? status) {
    if (status == null || status == 'All') {
      return doubts;
    }
    return doubts.where((doubt) => doubt.status == status).toList();
  }
}

// Doubt Sessions Page
class DoubtSessionsPage extends StatefulWidget {
  @override
  _DoubtSessionsPageState createState() => _DoubtSessionsPageState();
}

class _DoubtSessionsPageState extends State<DoubtSessionsPage> {
  List<Doubt> _displayedDoubts = [];
  String _selectedStatus = 'All';

  @override
  void initState() {
    super.initState();
    _displayedDoubts = DoubtService.doubts;
  }

  void _filterDoubts(String status) {
    setState(() {
      _selectedStatus = status;
      _displayedDoubts = DoubtService.filterDoubts(status);
    });
  }

  void _showAddDoubtDialog() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    String selectedPriority = 'Medium';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Create New Doubt'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: 'Doubt Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: descriptionController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Doubt Description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: selectedPriority,
                    decoration: InputDecoration(
                      labelText: 'Priority',
                      border: OutlineInputBorder(),
                    ),
                    items: ['Low', 'Medium', 'High']
                        .map((priority) => DropdownMenuItem(
                      value: priority,
                      child: Text(priority),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedPriority = value!;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                ElevatedButton(
                  child: Text('Create Doubt'),
                  onPressed: () {
                    if (titleController.text.isNotEmpty) {
                      final newDoubt = Doubt(
                        title: titleController.text,
                        description: descriptionController.text,
                        priority: selectedPriority,
                      );
                      DoubtService.addDoubt(newDoubt);
                      _filterDoubts(_selectedStatus);
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

  void _showDoubtDetailsDialog(Doubt doubt) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(doubt.title),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Description: ${doubt.description}'),
              SizedBox(height: 10),
              Text('Status: ${doubt.status}'),
              Text('Priority: ${doubt.priority}'),
              if (doubt.resolvedBy != null)
                Text('Resolved By: ${doubt.resolvedBy}'),
            ],
          ),
          actions: [
            if (doubt.status != 'Resolved')
              ElevatedButton(
                child: Text('Mark as Resolved'),
                onPressed: () {
                  final updatedDoubt = doubt.copyWith(
                    status: 'Resolved',
                    resolvedBy: 'System',
                  );
                  DoubtService.updateDoubt(updatedDoubt);
                  _filterDoubts(_selectedStatus);
                  Navigator.of(context).pop();
                },
              ),
            TextButton(
              child: Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filters = ['All', 'Pending', 'In Progress', 'Resolved'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Doubt Sessions',
          style: TextStyle(color: Color(0xFFF88E20), fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF1E1E1E),
        elevation: 0,
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
            // Filters
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(10),
              child: Row(
                children: filters.map((filter) {
                  return Container(
                    margin: EdgeInsets.only(right: 10),
                    child: ChoiceChip(
                      label: Text(
                        filter,
                        style: TextStyle(color: Colors.white),
                      ),
                      selected: _selectedStatus == filter,
                      onSelected: (bool selected) {
                        if (selected) {
                          _filterDoubts(filter);
                        }
                      },
                      backgroundColor: Color(0xFF2C2C2C),
                      selectedColor: Color(0xFFF88E20),
                    ),
                  );
                }).toList(),
              ),
            ),

            // Doubts List
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: _displayedDoubts.length,
                itemBuilder: (context, index) {
                  final doubt = _displayedDoubts[index];
                  Color priorityColor;
                  switch (doubt.priority) {
                    case 'High':
                      priorityColor = Colors.red;
                      break;
                    case 'Medium':
                      priorityColor = Colors.orange;
                      break;
                    default:
                      priorityColor = Colors.green;
                  }

                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Color(0xFF2C2C2C),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      title: Text(
                        doubt.title,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        doubt.status,
                        style: TextStyle(color: Colors.white70),
                      ),
                      trailing: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: priorityColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          doubt.priority,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      onTap: () => _showDoubtDetailsDialog(doubt),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDoubtDialog,
        backgroundColor: Color(0xFFF88E20),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}