import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:resultresolve/components/my_button.dart';
import 'package:resultresolve/components/my_textfield.dart';
import 'package:resultresolve/components/square_tile.dart';
import 'package:resultresolve/screens/home_page.dart'; // Import the HomePage screen

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text editing controllers
  final indexController = TextEditingController();
  final passwordController = TextEditingController();

  // Loading state
  bool isLoading = false;

  @override
  void dispose() {
    indexController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Sign in method
  Future<void> signUserIn() async {
    if (isLoading) return; // Prevent multiple submissions

    // Ensure the index and password are not empty and of type String
    String index = indexController.text.trim();
    String password = passwordController.text.trim();

    if (index.isEmpty || password.isEmpty) {
      showErrorDialog('Please enter both index number and password');
      return;
    }

    // Explicitly ensure types (although these will naturally be Strings)
    final String email = '$index@gctu.edu.gh';
    final String typedPassword = password;

    try {
      setState(() {
        isLoading = true;
      });

      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      print("Attempting to sign in with email: $email");

      // Attempt to sign in
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: typedPassword,
      );

      print("Sign in successful, user: ${userCredential.user?.uid}");

      // Ensure user is signed in before navigating
      if (userCredential.user != null) {
        // Dismiss loading indicator
        if (mounted) {
          Navigator.pop(context); // Pop the loading dialog
        }

        // Navigate to HomePage after successful login
        if (mounted) {
          Navigator.pushReplacementNamed(
              context, '/home'); // Navigate to HomePage
        }
      } else {
        throw FirebaseAuthException(
          code: 'unknown',
          message: 'User login failed. Please try again.',
        );
      }
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException: ${e.code}, ${e.message}");

      // Dismiss loading indicator
      if (mounted) {
        Navigator.pop(context); // Ensure the dialog is dismissed
      }

      // Handle and display specific errors
      if (mounted) {
        showErrorDialog(_getErrorMessage(e));
      }
    } catch (e) {
      print("Unknown error: $e");

      // Dismiss loading indicator
      if (mounted) {
        Navigator.pop(context); // Ensure the dialog is dismissed
      }

      // Handle any other errors
      if (mounted) {
        showErrorDialog('An unexpected error occurred. Please try again.');
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  String _getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found for that index number.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'invalid-email':
        return 'The index number is not valid.';
      default:
        return e.message ?? 'An error occurred. Please try again.';
    }
  }

  void showErrorDialog(String message) {
    if (mounted) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Dismiss the keyboard on tap outside
      },
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),

                  // Logo
                  const Icon(
                    Icons.lock,
                    size: 100,
                  ),

                  const SizedBox(height: 50),

                  // Welcome back, you've been missed!
                  Text(
                    'Welcome back you\'ve been missed!',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Index number textfield
                  MyTextField(
                    controller: indexController,
                    hintText: 'Index Number',
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),

                  // Password textfield
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),

                  const SizedBox(height: 10),

                  // Forgot password?
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Sign in button
                  MyButton(
                    onTap: signUserIn,
                  ),

                  const SizedBox(height: 50),

                  // Or continue with
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Colors.grey[400],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                'Students',
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                  thickness: 0.5, color: Colors.grey[400]),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Use your GCTU Index Number as your Username, and',
                          style: TextStyle(color: Colors.grey[700]),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Pa55@gctu as your password.',
                          style: TextStyle(color: Colors.grey[700]),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 50),

                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
