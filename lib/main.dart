import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'student_page.dart';
import 'teacher_page.dart';
import 'admin_page.dart';

void main() {
  runApp(SchedlyApp());
}

class SchedlyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Schedly',
      theme: ThemeData(
        colorScheme: ColorScheme.dark(
          primary: Color(0xFFF88E20), // Slate blue
          secondary: Color(0xFF4CAF50), // Green accent
          background: Color(0xFF121212), // Dark background
          surface: Color(0xFF1E1E1E), // Slightly lighter dark surface
        ),
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _selectedRole;
  late AnimationController _animationController;
  late Animation<double> _animation;

  final List<String> _roles = ['Student', 'Teacher', 'Admin'];

  @override
  void initState() {
    super.initState();
    // Add animation for login card
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username == 'user' && password == 'password' && _selectedRole != null) {
      _navigateToRolePage();
    } else {
      _showLoginError();
    }
  }

  void _navigateToRolePage() {
    Widget destinationPage;
    switch (_selectedRole) {
      case 'Student':
        destinationPage = StudentPage();
        break;
      case 'Teacher':
        destinationPage = TeacherPage();
        break;
      case 'Admin':
        destinationPage = AdminDashboardPage();
        break;
      default:
        return;
    }

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => destinationPage,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(1.0, 0.0);
          var end = Offset.zero;
          var curve = Curves.easeInOutQuart;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  void _showLoginError() {
    HapticFeedback.heavyImpact();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.red.shade900.withOpacity(0.8),
        title: Text(
          'Login Failed',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: Text(
          _selectedRole == null
              ? 'Please select a role.'
              : 'Incorrect username or password.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
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
        child: Center(
          child: ScaleTransition(
            scale: _animation,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF1E1E1E),
                        Color(0xFF2C2C2C),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Schedly',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFF88E20),
                            letterSpacing: 1.2,
                          ),
                        ),
                        SizedBox(height: 32),
                        _buildAnimatedTextField(
                          controller: _usernameController,
                          labelText: 'Username',
                          icon: Icons.person,
                          delay: 0,
                        ),
                        SizedBox(height: 16),
                        _buildAnimatedTextField(
                          controller: _passwordController,
                          labelText: 'Password',
                          icon: Icons.lock,
                          obscureText: true,
                          delay: 200,
                        ),
                        SizedBox(height: 16),
                        _buildRoleDropdown(),
                        SizedBox(height: 32),
                        _buildLoginButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    bool obscureText = false,
    int delay = 0,
  }) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 500 + delay),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(0, (1 - value) * 50),
          child: Opacity(
            opacity: value,
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              style: TextStyle(color: Colors.white70),
              decoration: InputDecoration(
                labelText: labelText,
                prefixIcon: Icon(icon, color: Color(0xFFF88E20)),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Color(0xFFF88E20), width: 2),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRoleDropdown() {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 700),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(0, (1 - value) * 50),
          child: Opacity(
            opacity: value,
            child: DropdownButtonFormField<String>(
              value: _selectedRole,
              decoration: InputDecoration(
                labelText: 'Select Role',
                prefixIcon: Icon(Icons.group, color: Color(0xFFF88E20)),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Color(0xFFF88E20), width: 2),
                ),
              ),
              dropdownColor: Color(0xFF2C2C2C),
              hint: Text('Select Role', style: TextStyle(color: Colors.white70)),
              onChanged: (value) {
                setState(() {
                  _selectedRole = value;
                });
              },
              items: _roles.map((role) {
                return DropdownMenuItem(
                  value: role,
                  child: Text(role, style: TextStyle(color: Colors.white70)),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoginButton() {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 900),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(0, (1 - value) * 50),
          child: Opacity(
            opacity: value,
            child: ElevatedButton(
              onPressed: _login,
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFFF88E20),
                minimumSize: Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 5,
              ),
            ),
          ),
        );
      },
    );
  }
}