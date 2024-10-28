import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

  void _login(BuildContext context) async {
    final input = _controller.text;
    final password = _passwordController.text;

    // Initialize Firebase Realtime Database reference
    final ref = FirebaseDatabase.instance.ref();

    if (input == 'root') {
      // Check admin credentials in Firebase
      final snapshot = await ref.child('users/admin').get();
      if (snapshot.exists) {
        final adminData = snapshot.value as Map<dynamic, dynamic>;
        if (adminData['password'] == password) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AdminLandingPage()),
          );
        } else {
          _showError(context, 'Invalid admin password.');
        }
      } else {
        _showError(context, 'Admin user not found.');
      }
    } else if (RegExp(r'^[0-9]+$').hasMatch(input)) {
      final number = int.tryParse(input);
      if (number != null && number >= 2018000000 && number <= 2024999999) {
        // Check student credentials in Firebase
        final snapshot = await ref.child('users/students/$input').get();
        if (snapshot.exists) {
          final studentData = snapshot.value as Map<dynamic, dynamic>;
          if (studentData['password'] == password) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const StudentLandingPage()),
            );
          } else {
            _showError(context, 'Invalid student password.');
          }
        } else {
          _showError(context, 'Student not found.');
        }
      } else {
        _showError(context, 'Invalid student number range.');
      }
    } else if (RegExp(r'^[a-zA-Z]+$').hasMatch(input)) {
      // Check staff credentials in Firebase
      final snapshot = await ref.child('users/staff/$input').get();
      if (snapshot.exists) {
        final staffData = snapshot.value as Map<dynamic, dynamic>;
        if (staffData['password'] == password) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const StaffLandingPage()),
          );
        } else {
          _showError(context, 'Invalid staff password.');
        }
      } else {
        _showError(context, 'Staff member not found.');
      }
    } else {
      _showError(context, 'Invalid input.');
    }
  }

  void _showError(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Enter your ID'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Enter your Password'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _login(context),
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class StudentLandingPage extends StatelessWidget {
  const StudentLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Landing Page'),
      ),
      body: const Center(
        child: Text('Welcome, Student!'),
      ),
    );
  }
}

class StaffLandingPage extends StatelessWidget {
  const StaffLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff Landing Page'),
      ),
      body: const Center(
        child: Text('Welcome, Staff!'),
      ),
    );
  }
}

class AdminLandingPage extends StatelessWidget {
  const AdminLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Landing Page'),
      ),
      body: const Center(
        child: Text('Welcome, Admin!'),
      ),
    );
  }
}
