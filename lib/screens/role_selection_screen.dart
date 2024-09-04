import 'package:flutter/material.dart';
import 'login_page.dart'; // Import your existing LoginPage
import 'lecturer_login_screen.dart'; // Import the LecturerLoginScreen
import 'AdminPage.dart'; // Import the AdminPage

class RoleSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        color: Colors.blueAccent,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Adding a more visually appealing title section
              Text(
                'Welcome to',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 22,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'ResultResolve',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40),
              // Adding a professional and descriptive subtitle
              Text(
                'Please select your role to continue',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 40),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 10,
                child: ListTile(
                  leading:
                      Icon(Icons.person, size: 50, color: Colors.blueAccent),
                  title: Text(
                    'Student',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text('Log in with your index number'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 10,
                child: ListTile(
                  leading:
                      Icon(Icons.school, size: 50, color: Colors.blueAccent),
                  title: Text(
                    'Lecturer',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text('Log in with your credentials'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LecturerLoginScreen()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdminPage()),
          );
        },
        child: Icon(Icons.admin_panel_settings),
        backgroundColor: Colors.white,
      ),
    );
  }
}
