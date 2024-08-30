import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LecturerAdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Complaints'),
        backgroundColor: Colors.blueAccent,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('complaints')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching complaints'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No complaints found'));
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
              return ListTile(
                title: Text(data['courseName']),
                subtitle: Text(
                    'Student: ${data['fullName']} | Status: ${data['issueStatus']}'),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  // Optionally navigate to a detailed view of the complaint
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
