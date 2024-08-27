import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget {
  final List<Map<String, String>> newsItems = [
    {
      "title": "Exam Results Released",
      "description":
          "The results for the semester exams have been released. Please check the results portal.",
      "date": "August 21, 2024",
    },
    {
      "title": "New Semester Registration",
      "description":
          "Registration for the new semester is now open. Make sure to register before the deadline.",
      "date": "August 15, 2024",
    },
    {
      "title": "Holiday Announcement",
      "description":
          "The university will be closed for a public holiday next week. Classes will resume on the following Monday.",
      "date": "August 10, 2024",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: newsItems.length,
        itemBuilder: (context, index) {
          final newsItem = newsItems[index];
          return Card(
            margin: EdgeInsets.all(10.0),
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    newsItem['title']!,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    newsItem['date']!,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    newsItem['description']!,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
