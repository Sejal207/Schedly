import 'package:flutter/material.dart';

class ResourceOversightPage extends StatefulWidget {
  @override
  _ResourceOversightPageState createState() => _ResourceOversightPageState();
}

class _ResourceOversightPageState extends State<ResourceOversightPage> {
  final List<Map<String, dynamic>> _resources = [
    {
      'id': 1,
      'name': 'Microscope Set',
      'category': 'Laboratory Equipment',
      'status': 'Borrowed',
      'borrowedBy': 'Science Department',
      'borrowDate': '2024-02-20',
      'dueDate': '2024-03-20'
    },
    {
      'id': 2,
      'name': 'Projector',
      'category': 'Multimedia',
      'status': 'Available',
      'borrowedBy': '',
      'borrowDate': '',
      'dueDate': ''
    },
    {
      'id': 3,
      'name': 'Laptop',
      'category': 'Computing',
      'status': 'Borrowed',
      'borrowedBy': 'Math Teacher',
      'borrowDate': '2024-03-01',
      'dueDate': '2024-04-01'
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Borrowed':
        return Colors.orange;
      case 'Available':
        return Colors.green;
      case 'Overdue':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showResourceDetailsModal(Map<String, dynamic> resource) {
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
                  resource['name'],
                  style: TextStyle(
                    color: Color(0xFFF88E20),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Category: ${resource['category']}',
                  style: TextStyle(color: Colors.white70),
                ),
                SizedBox(height: 8),
                if (resource['status'] == 'Borrowed') ...[
                  Text(
                    'Borrowed By: ${resource['borrowedBy']}',
                    style: TextStyle(color: Colors.white70),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Borrow Date: ${resource['borrowDate']}',
                    style: TextStyle(color: Colors.white70),
                  ),
                  Text(
                    'Due Date: ${resource['dueDate']}',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Status: ${resource['status']}',
                      style: TextStyle(
                        color: _getStatusColor(resource['status']),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFF88E20),
                      ),
                      child: Text(
                        resource['status'] == 'Borrowed'
                            ? 'Mark Returned'
                            : 'Mark Borrowed',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        // Implement status change logic
                        Navigator.pop(context);
                      },
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
                      'Resource Oversight',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF88E20),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.add, color: Colors.white70),
                          onPressed: () {
                            // Implement add new resource
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.filter_list, color: Colors.white70),
                          onPressed: () {
                            // Implement filtering logic
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Resources List
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _resources.length,
                  itemBuilder: (context, index) {
                    final resource = _resources[index];
                    return Card(
                      color: Color(0xFF2C2C2C),
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(
                          resource['name'],
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          resource['category'],
                          style: TextStyle(color: Colors.white54),
                        ),
                        trailing: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(resource['status'])
                                .withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            resource['status'],
                            style: TextStyle(
                              color: _getStatusColor(resource['status']),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        onTap: () => _showResourceDetailsModal(resource),
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