import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:resultresolve/screens/splash_screen.dart';
import 'package:resultresolve/screens/error_screen.dart';
import 'package:resultresolve/screens/home_page.dart';
import 'package:resultresolve/screens/role_selection_screen.dart'; // Import the RoleSelectionScreen
import 'package:resultresolve/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensures the app is ready before Firebase initialization
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions
          .currentPlatform, // Initializes Firebase with platform-specific options
    );
    runApp(
        MyApp()); // Runs the main app after successful Firebase initialization
  } catch (e) {
    runApp(ErrorApp(
        errorMessage: e
            .toString())); // Displays an error screen if Firebase fails to initialize
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ResultResolve',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(), // Starts with the SplashScreen
      routes: {
        '/home': (context) => HomePage(), // Define the HomePage route here
        // Add other routes as needed
      },
    );
  }
}

class ErrorApp extends StatelessWidget {
  final String errorMessage;

  ErrorApp({required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
          ErrorScreen(errorMessage: errorMessage), // Displays the error message
    );
  }
}
