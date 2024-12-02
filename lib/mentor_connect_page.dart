import 'package:flutter/material.dart';

// Mentor Model
class Mentor {
  final String id;
  final String name;
  final String domain;
  final double rating;
  final String category;
  final String bio;
  final List<String> skills;

  Mentor({
    required this.id,
    required this.name,
    required this.domain,
    required this.rating,
    required this.category,
    required this.bio,
    required this.skills,
  });
}

// Mentor Service (simulating backend)
class MentorService {
  static List<Mentor> mentors = [
    Mentor(
      id: '1',
      name: 'Kiran Khatter',
      domain: 'Development',
      rating: 4.5,
      category: 'Tech',
      bio: 'Senior Software Engineer with 10 years of experience',
      skills: ['Flutter', 'Dart', 'Mobile Development'],
    ),
    Mentor(
      id: '2',
      name: 'Nishtha Phutela ',
      domain: 'Data Science',
      rating: 4.8,
      category: 'Research',
      bio: 'Machine Learning expert with published research',
      skills: ['Python', 'Machine Learning', 'Data Analysis'],
    ),
    Mentor(
      id: '3',
      name: 'Davinder Singh',
      domain: 'Business Strategy',
      rating: 4.7,
      category: 'Business',
      bio: 'Startup advisor and business consultant',
      skills: ['Entrepreneurship', 'Strategic Planning', 'Consulting'],
    ),
    Mentor(
      id: '4',
      name: 'Atul Mishra',
      domain: 'Software Engineering',
      rating: 4.6,
      category: 'Tech',
      bio: 'Senior Software Engineer with 10 years of experience',
      skills: ['OOPS', 'DSA', 'DAA'],
    ),
    Mentor(
      id: '5',
      name: 'Anubhav Aggarwal',
      domain: 'Research',
      rating: 4.8,
      category: 'Tech',
      bio: 'Senior Software Engineer with 10 years of experience',
      skills: ['BEEE', 'FDL'],
    ),
  ];

  // Search mentors
  static List<Mentor> searchMentors(String query, {String? category}) {
    return mentors.where((mentor) {
      final matchesQuery = mentor.name.toLowerCase().contains(query.toLowerCase()) ||
          mentor.domain.toLowerCase().contains(query.toLowerCase()) ||
          mentor.skills.any((skill) => skill.toLowerCase().contains(query.toLowerCase()));

      final matchesCategory = category == null || mentor.category == category;

      return matchesQuery && matchesCategory;
    }).toList();
  }

  // Get mentors by category
  static List<Mentor> getMentorsByCategory(String category) {
    return mentors.where((mentor) => mentor.category == category).toList();
  }
}

// Mentor Connect Page (Updated)
class MentorConnectPage extends StatefulWidget {
  @override
  _MentorConnectPageState createState() => _MentorConnectPageState();
}

class _MentorConnectPageState extends State<MentorConnectPage> {
  List<Mentor> _displayedMentors = [];
  String? _selectedCategory;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _displayedMentors = MentorService.mentors;
  }

  void _filterMentors(String query, {String? category}) {
    setState(() {
      _selectedCategory = category;
      _displayedMentors = MentorService.searchMentors(query, category: category);
    });
  }

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'name': 'Tech', 'icon': Icons.computer},
      {'name': 'Business', 'icon': Icons.business},
      {'name': 'Development', 'icon': Icons.design_services},
      {'name': 'Research', 'icon': Icons.science},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Mentor Connect',
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
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF2C2C2C),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search Mentors',
                  hintStyle: TextStyle(color: Colors.white54),
                  prefixIcon: Icon(Icons.search, color: Color(0xFFF88E20)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  _filterMentors(value, category: _selectedCategory);
                },
              ),
            ),
            SizedBox(height: 20),

            // Mentor Categories
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((category) {
                  return Container(
                    margin: EdgeInsets.only(right: 10),
                    child: ChoiceChip(
                      label: Text(
                        category['name'] as String,
                        style: TextStyle(color: Colors.white),
                      ),
                      selected: _selectedCategory == category['name'],
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedCategory = selected ? category['name'] as String : null;
                          _filterMentors(_searchController.text, category: _selectedCategory);
                        });
                      },
                      backgroundColor: Color(0xFF2C2C2C),
                      selectedColor: Color(0xFFF88E20),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20),

            // Available Mentors
            Text(
              'Available Mentors',
              style: TextStyle(
                color: Color(0xFFF88E20),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),

            // Mentor List
            ..._displayedMentors.map((mentor) {
              return Container(
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Color(0xFF2C2C2C),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color(0xFFF88E20),
                    child: Text(
                      mentor.name[0],
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    mentor.name,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    mentor.domain,
                    style: TextStyle(color: Colors.white70),
                  ),
                  trailing: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Color(0xFFF88E20),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${mentor.rating} ★',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onTap: () {
                    // Navigate to mentor details page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MentorDetailPage(mentor: mentor),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

// Mentor Detail Page
class MentorDetailPage extends StatelessWidget {
  final Mentor mentor;

  const MentorDetailPage({Key? key, required this.mentor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mentor Profile',
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
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            // Mentor Profile Header
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF2C2C2C),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Color(0xFFF88E20),
                    child: Text(
                      mentor.name[0],
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    mentor.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    mentor.domain,
                    style: TextStyle(color: Colors.white70),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: Color(0xFFF88E20)),
                      Text(
                        '${mentor.rating} / 5.0',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Mentor Bio
            _buildSectionCard('About', mentor.bio),
            SizedBox(height: 10),

            // Skills
            _buildSkillsCard(mentor.skills),
            SizedBox(height: 20),

            // Book Mentor Button
            ElevatedButton(
              onPressed: () {
                // Implement booking logic
                _showBookMentorDialog(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFF88E20),
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Book Mentor Session',
                style: TextStyle(
                  color: Colors.white, // Set text color to white
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(String title, String content) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Color(0xFFF88E20),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            content,
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsCard(List<String> skills) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Skills',
            style: TextStyle(
              color: Color(0xFFF88E20),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: skills.map((skill) {
              return Chip(
                label: Text(skill),
                backgroundColor: Color(0xFFF88E20).withOpacity(0.2),
                labelStyle: TextStyle(color: Color(0xFFF88E20)),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  void _showBookMentorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Book Mentor Session'),
          content: Text('Would you like to book a session with ${mentor.name}?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Confirm'),
              onPressed: () {
                // Implement booking confirmation logic
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Mentor session request made!'),
                    backgroundColor: Color(0xFFF88E20),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}