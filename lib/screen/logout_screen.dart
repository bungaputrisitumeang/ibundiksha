import 'package:flutter/material.dart';
import 'package:ibundiksha/screen/login_screen.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  void _logout(BuildContext context) {
    // Clear session if necessary, then go to login screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Logout')),
      body: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.logout),
          label: const Text('Logout'),
          onPressed: () => _logout(context),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        ),
      ),
    );
  }
}
