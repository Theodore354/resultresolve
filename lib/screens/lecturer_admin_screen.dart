import 'package:flutter/material.dart';

class LecturerAdminScreen extends StatelessWidget {
  // Dummy data for complaints
  final List<Map<String, String>> complaints = [
    {
      'studentName': 'John Doe',
      'course': 'Computer Science 101',
      'issue': 'Incomplete Grade',
      'status': 'Pending',
    },
    {
      'studentName': 'Jane Smith',
      'course': 'Data Structures',
      'issue': 'Missing Assignment',
      'status': 'Resolved',
    },
    {
      'studentName': 'Emily Johnson',
      'course': 'Algorithms',
      'issue': 'Exam Re-evaluation',
      'status': 'Pending',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lecturer Admin Dashboard'),
      ),
      body: ListView.builder(
        itemCount: complaints.length,
        itemBuilder: (context, index) {
          final complaint = complaints[index];
          return Card(
            margin: EdgeInsets.all(10.0),
            child: ListTile(
              title:
                  Text('${complaint['studentName']} - ${complaint['course']}'),
              subtitle: Text('Issue: ${complaint['issue']}'),
              trailing: Text(
                complaint['status']!,
                style: TextStyle(
                  color: complaint['status'] == 'Resolved'
                      ? Colors.green
                      : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                // Navigate to a detailed complaint view or take action
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ComplaintDetailScreen(
                      complaint: complaint,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class ComplaintDetailScreen extends StatelessWidget {
  final Map<String, String> complaint;

  ComplaintDetailScreen({required this.complaint});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaint Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Student: ${complaint['studentName']}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Course: ${complaint['course']}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Issue: ${complaint['issue']}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Status: ${complaint['status']}',
              style: TextStyle(
                fontSize: 16,
                color: complaint['status'] == 'Resolved'
                    ? Colors.green
                    : Colors.red,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Example action: Mark as resolved
                // In a real app, you might update the status in the database
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Marked as Resolved')),
                );
                Navigator.pop(context);
              },
              child: Text('Mark as Resolved'),
            ),
          ],
        ),
      ),
    );
  }
}
