import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Manage Users',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Code to add a user goes here
              },
              child: Text('Add User'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent, // Background color
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Code to remove a user goes here
              },
              child: Text('Remove User'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent, // Background color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
