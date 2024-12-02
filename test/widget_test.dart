import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:schedly_prjapp/main.dart';
import 'package:schedly_prjapp/student_page.dart';
import 'package:schedly_prjapp/teacher_page.dart';
import 'package:schedly_prjapp/admin_page.dart';

void main() {
  testWidgets('Login page is displayed correctly', (WidgetTester tester) async {
    // Build the Schedly app.
    await tester.pumpWidget(SchedlyApp());

    // Verify the LoginPage is displayed with all required fields and buttons.
    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Select Role'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('Login redirects to the correct page based on role', (WidgetTester tester) async {
    // Build the Schedly app.
    await tester.pumpWidget(SchedlyApp());

    // Enter the username, password, and select a role.
    await tester.enterText(find.byType(TextField).at(0), 'user'); // Username field
    await tester.enterText(find.byType(TextField).at(1), 'password'); // Password field
    await tester.tap(find.byType(DropdownButtonFormField<String>)); // Open dropdown
    await tester.pumpAndSettle(); // Wait for dropdown animation
    await tester.tap(find.text('Student').last); // Select "Student" role
    await tester.pumpAndSettle();

    // Tap the login button.
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    // Verify navigation to the StudentPage.
    expect(find.text('Student Page - Schedule, Events, etc.'), findsOneWidget);
  });

  testWidgets('Student Page has the correct features', (WidgetTester tester) async {
    // Wrap the StudentPage inside a MaterialApp to ensure it has the necessary context.
    await tester.pumpWidget(MaterialApp(
      home: StudentPage(),
    ));

    // Verify the Student Page content (e.g., schedule, events, carpool system).
    expect(find.text('Student Dashboard'), findsOneWidget);
    // Add more specific checks when features like schedule lists or carpool buttons are implemented.
  });

  testWidgets('Teacher Page has the correct features', (WidgetTester tester) async {
    // Wrap the TeacherPage inside a MaterialApp.
    await tester.pumpWidget(MaterialApp(
      home: TeacherPage(),
    ));

    // Verify the Teacher Page content.
    expect(find.text('Teacher Page - Teaching schedule, etc.'), findsOneWidget);
  });

  testWidgets('Admin Page has the correct features', (WidgetTester tester) async {
    // Wrap the AdminPage inside a MaterialApp.
    await tester.pumpWidget(MaterialApp(
      home: AdminDashboardPage(),
    ));

    // Verify the Admin Page content.
    expect(find.text('Admin Page - User management, events, etc.'), findsOneWidget);
  });
}
