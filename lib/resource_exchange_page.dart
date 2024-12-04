import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

// Resource Model (previous code remains the same)
class Resource {
  final String id;
  final String title;
  final String type;
  final String owner;
  final String description;
  bool isAvailable;

  Resource({
    String? id,
    required this.title,
    required this.type,
    required this.owner,
    required this.description,
    this.isAvailable = true,
  }) : id = id ?? Uuid().v4();

  Resource copyWith({
    String? title,
    String? type,
    String? owner,
    String? description,
    bool? isAvailable,
  }) {
    return Resource(
      id: this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      owner: owner ?? this.owner,
      description: description ?? this.description,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }
}

// Resource Service (previous code remains the same)
class ResourceService {
  static List<Resource> resources = [
    Resource(
      title: 'Machine Learning Textbook',
      type: 'Book',
      owner: 'Alex',
      description: 'Comprehensive ML textbook covering key concepts',
    ),
    Resource(
      title: 'Python Cheat Sheet',
      type: 'Notes',
      owner: 'Sarah',
      description: 'Quick reference for Python programming',
    ),
    Resource(
      title: 'Algorithm Design Course',
      type: 'Video',
      owner: 'Mike',
      description: 'Online course covering advanced algorithm design',
    ),
  ];

  static void addResource(Resource resource) {
    resources.add(resource);
  }

  static void updateResource(Resource updatedResource) {
    final index = resources.indexWhere((resource) => resource.id == updatedResource.id);
    if (index != -1) {
      resources[index] = updatedResource;
    }
  }

  static List<Resource> searchResources(String query, {String? type}) {
    return resources.where((resource) {
      final matchesQuery = resource.title.toLowerCase().contains(query.toLowerCase()) ||
          resource.description.toLowerCase().contains(query.toLowerCase());

      final matchesType = type == null || resource.type == type;

      return matchesQuery && matchesType && resource.isAvailable;
    }).toList();
  }

  static Resource? getResourceById(String id) {
    try {
      return resources.firstWhere((resource) => resource.id == id);
    } catch (e) {
      return null;
    }
  }
}

// Resource Exchange Page
class ResourceExchangePage extends StatefulWidget {
  @override
  _ResourceExchangePageState createState() => _ResourceExchangePageState();
}

class _ResourceExchangePageState extends State<ResourceExchangePage> {
  List<Resource> _displayedResources = [];
  String? _selectedType;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _displayedResources = ResourceService.resources;
  }

  void _searchResources(String query, {String? type}) {
    setState(() {
      _selectedType = type;
      _displayedResources = ResourceService.searchResources(query, type: type);
    });
  }

  void _showAddResourceDialog() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    String selectedType = 'Book';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Add New Resource'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: 'Resource Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: descriptionController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Resource Description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: selectedType,
                    decoration: InputDecoration(
                      labelText: 'Resource Type',
                      border: OutlineInputBorder(),
                    ),
                    items: ['Book', 'Notes', 'Video', 'Other']
                        .map((type) => DropdownMenuItem(
                      value: type,
                      child: Text(type),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedType = value!;
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
                  child: Text('Add'),
                  onPressed: () {
                    if (titleController.text.isNotEmpty && descriptionController.text.isNotEmpty) {
                      final newResource = Resource(
                        title: titleController.text,
                        type: selectedType,
                        owner: 'Current User', // In a real app, this would be the logged-in user
                        description: descriptionController.text,
                      );

                      ResourceService.addResource(newResource);

                      setState(() {
                        _displayedResources = ResourceService.resources;
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

  void _showResourceDetailsDialog(Resource resource) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(resource.title),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Type: ${resource.type}'),
              SizedBox(height: 10),
              Text('Owner: ${resource.owner}'),
              SizedBox(height: 10),
              Text('Description: ${resource.description}'),
              SizedBox(height: 10),
              Text('Availability: ${resource.isAvailable ? 'Available' : 'Not Available'}'),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            if (resource.isAvailable)
              ElevatedButton(
                child: Text('Request Resource'),
                onPressed: () {
                  // In a real app, this would handle resource request logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Resource request sent!')),
                  );
                  Navigator.of(context).pop();
                },
              ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resource Exchange'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search resources...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (value) {
                    _searchResources(value, type: _selectedType);
                  },
                ),
                SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      'All',
                      'Book',
                      'Notes',
                      'Video',
                      'Other'
                    ].map((type) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: ChoiceChip(
                          label: Text(type),
                          selected: _selectedType == (type == 'All' ? null : type),
                          onSelected: (selected) {
                            setState(() {
                              _selectedType = selected
                                  ? (type == 'All' ? null : type)
                                  : null;
                              _searchResources(
                                  _searchController.text,
                                  type: _selectedType
                              );
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: _displayedResources.isEmpty
          ? Center(
        child: Text(
          'No resources found',
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: _displayedResources.length,
        itemBuilder: (context, index) {
          final resource = _displayedResources[index];
          return ListTile(
            title: Text(resource.title),
            subtitle: Text(resource.type),
            trailing: Text(
              resource.isAvailable ? 'Available' : 'Unavailable',
              style: TextStyle(
                color: resource.isAvailable ? Colors.green : Colors.red,
              ),
            ),
            onTap: () => _showResourceDetailsDialog(resource),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddResourceDialog,
        child: Icon(Icons.add),
        tooltip: 'Add New Resource',
      ),
    );
  }
}

// Main Application
class ResourceExchangeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resource Exchange',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ResourceExchangePage(),
    );
  }
}

void main() {
  runApp(ResourceExchangeApp());
}