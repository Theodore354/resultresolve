import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'role_selection_screen.dart'; // Import the RoleSelectionScreen
import 'complaint_form_screen.dart'; // Import the Complaint Form Screen
import 'chat_screen.dart'; // Import the Chat Screen

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchCourseController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;

  // Define courses based on levels
  final Map<String, List<Map<String, String>>> levelCourses = {
    'Level 100': [
      {'courseName': 'Study Skills', 'lecturerName': 'Dr. Kim'},
      {'courseName': 'African Studies', 'lecturerName': 'Dr. Davis'},
      {'courseName': 'Computational Maths', 'lecturerName': 'Dr. Grace'},
      {'courseName': 'Discrete Structures', 'lecturerName': 'Dr. Daniel'},
      {'courseName': 'Sociology', 'lecturerName': 'Dr. Gifty'},
    ],
    'Level 200': [
      {'courseName': 'African Studies', 'lecturerName': 'Dr. Smith'},
      {'courseName': 'System Analysis', 'lecturerName': 'Dr. Johnson'},
      {'courseName': 'Computer Architecture', 'lecturerName': 'Dr. Dennis'},
      {'courseName': 'Operational French', 'lecturerName': 'Dr. Tabri'},
      {'courseName': 'Database Management', 'lecturerName': 'Dr. Davis'},
    ],
    'Level 300': [
      {'courseName': 'Micro Computing', 'lecturerName': 'Prof. Williams'},
      {'courseName': 'Data Communication', 'lecturerName': 'Dr. Lewis'},
      {'courseName': 'Mobile App Development', 'lecturerName': 'Dr. George'},
      {'courseName': 'Accounting & Management', 'lecturerName': 'Dr. Davis'},
      {'courseName': 'African Studies', 'lecturerName': 'Dr. Davis'},
    ],
    'Level 400': [
      {'courseName': 'Cloud Computing', 'lecturerName': 'Dr. Asunka'},
      {'courseName': 'Project Management', 'lecturerName': 'Dr. Dominic'},
      {
        'courseName': 'Social Media & Networking',
        'lecturerName': 'Dr. Philomina'
      },
      {
        'courseName': 'Management Information System',
        'lecturerName': 'Dr. Dominic'
      },
      {'courseName': 'E-Commerce', 'lecturerName': 'Dr. Patrick'},
    ],
  };

  List<Map<String, String>> filteredCourses = [];
  String selectedLevel = 'Level 100'; // Default selected level

  // Navbar index
  int myIndex = 1;

  final PageController _pageController = PageController(initialPage: 1);
  final ScrollController _scrollController = ScrollController();
  Timer? _scrollTimer;

  @override
  void initState() {
    super.initState();
    filteredCourses =
        levelCourses[selectedLevel]!; // Initialize with Level 100 courses
    searchCourseController
        .addListener(_filterCourses); // Add listener to search input

    // Set up auto-scrolling
    _scrollTimer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_scrollController.hasClients) {
        final maxScrollExtent = _scrollController.position.maxScrollExtent;
        _scrollController
            .animateTo(
          _scrollController.offset + 200, // Scroll offset
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        )
            .whenComplete(() {
          if (_scrollController.offset >= maxScrollExtent) {
            _scrollController.jumpTo(0); // Jump back to the start
          }
        });
      }
    });
  }

  @override
  void dispose() {
    searchCourseController.dispose();
    _scrollController.dispose();
    _scrollTimer?.cancel();
    super.dispose();
  }

  void _filterCourses() {
    final query = searchCourseController.text.toLowerCase();
    setState(() {
      filteredCourses = levelCourses[selectedLevel]!
          .where(
              (course) => course['courseName']!.toLowerCase().contains(query))
          .toList();
    });
  }

  void _navigateToComplaintForm(String courseName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ComplaintFormScreen(courseName: courseName),
      ),
    );
  }

  void _navigateToChatScreen(Map<String, String> course) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(
          courseName: course['courseName']!,
          lecturerName: course['lecturerName']!,
        ),
      ),
    );
  }

  void _logout(BuildContext context) async {
    // Optionally clear session or authentication data
    await FirebaseAuth.instance.signOut();

    // Navigate to the RoleSelectionScreen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => RoleSelectionScreen()),
      (route) => false, // This clears the entire navigation stack
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
            ),
            const Icon(
              Icons.notifications,
              color: Colors.grey,
              size: 30.0,
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      drawer: _buildProfileDrawer(context),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
          _pageController.jumpToPage(index);
        },
        currentIndex: myIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Chat"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: "News"),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            myIndex = index;
          });
        },
        children: [
          _buildChatSelectionScreen(), // Course selection screen for Chat
          _buildHomePage(context), // Your Home screen
          _buildNewsScreen(), // Implemented News screen
        ],
      ),
    );
  }

  Widget _buildProfileDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(
                      'lib/assets/male-profile.jpg'), // Add a placeholder image
                ),
                SizedBox(height: 10),
                Text(
                  'Welcome',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  user.email! ?? 'no user',
                  style: TextStyle(color: Colors.white70, fontSize: 11),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              // Navigate to edit profile screen
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              // Navigate to account settings screen
            },
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                _logout(context); // Call the logout method
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatSelectionScreen() {
    return ListView.builder(
      itemCount: filteredCourses.length,
      itemBuilder: (context, index) {
        final course = filteredCourses[index];
        return ListTile(
          title: Text(course['courseName']!),
          subtitle: Text('Lecturer: ${course['lecturerName']}'),
          trailing: const Icon(Icons.chat),
          onTap: () => _navigateToChatScreen(course),
        );
      },
    );
  }

  Widget _buildHomePage(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text(
            "Choose Level",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 5),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var level in [
                  'Level 100',
                  'Level 200',
                  'Level 300',
                  'Level 400'
                ])
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedLevel = level;
                          filteredCourses = levelCourses[selectedLevel]!;
                          _filterCourses();
                        });
                      },
                      child: Container(
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        decoration: BoxDecoration(
                          color: selectedLevel == level
                              ? Colors.blue
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            level,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 4.0),
            child: SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                controller: _scrollController, // Assign the ScrollController
                itemCount: 4, // Adjusted to match the number of images
                itemBuilder: (context, index) {
                  final imageAssetPaths = [
                    "lib/assets/1stslider.jpeg",
                    "lib/assets/2ndslider.jpeg",
                    "lib/assets/3rdslider.jpeg",
                    "lib/assets/4thslider.jpeg"
                  ];

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 3.0), // Reduced horizontal padding
                    child: Container(
                      height: 150,
                      width: 400,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: Image.asset(
                        imageAssetPaths[index % 4],
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Text(
                              'Image not available',
                              style: TextStyle(color: Colors.red),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextField(
                  controller: searchCourseController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: "Course Title",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    itemCount: filteredCourses.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          _navigateToComplaintForm(
                              filteredCourses[index]['courseName']!);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 10.0),
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            filteredCourses[index]['courseName']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildNewsScreen() {
    final List<Map<String, String>> newsArticles = [
      {
        'title': 'University Launches New AI Program',
        'description':
            'The university has launched a new AI program for students.'
      },
      {
        'title': 'New Research Paper Published by Faculty',
        'description':
            'Faculty members have published a new research paper on data science.'
      },
      {
        'title': 'Upcoming Seminar on Data Security',
        'description': 'A seminar on data security will be held next week.'
      },
    ];

    return ListView.builder(
      itemCount: newsArticles.length,
      itemBuilder: (context, index) {
        final article = newsArticles[index];
        return ListTile(
          title: Text(article['title']!),
          subtitle: Text(article['description']!),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () {
            // Handle tap, for example, navigate to full article page
          },
        );
      },
    );
  }
}
