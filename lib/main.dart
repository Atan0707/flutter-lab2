import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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

  void _login(BuildContext context) {
    final input = _controller.text;
    if (input == 'root') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AdminLandingPage()),
      );
    } else if (RegExp(r'^[0-9]+$').hasMatch(input)) {
      final number = int.tryParse(input);
      if (number != null && number >= 2018000000 && number <= 2024999999) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StudentLandingPage()),
        );
      } else {
        _showError(context, 'Invalid student number range.');
      }
    } else if (RegExp(r'^[a-zA-Z]+$').hasMatch(input)) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => StaffLandingPage()),
      );
    } else {
      _showError(context, 'Invalid input.');
    }
  }

  void _showError(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Enter your ID'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _login(context),
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class StudentLandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Landing Page'),
      ),
      body: Center(
        child: Text('Welcome, Student!'),
      ),
    );
  }
}

class StaffLandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staff Landing Page'),
      ),
      body: Center(
        child: Text('Welcome, Staff!'),
      ),
    );
  }
}

class AdminLandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Landing Page'),
      ),
      body: Center(
        child: Text('Welcome, Admin!'),
      ),
    );
  }
}