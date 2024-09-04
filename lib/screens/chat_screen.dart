import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String courseName;
  final String lecturerName;

  ChatScreen({required this.courseName, required this.lecturerName});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, String>> messages = [];
  final TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadInitialMessages();
  }

  Future<void> _loadInitialMessages() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      messages.addAll([
        {
          "sender": widget.lecturerName,
          "text":
              "Welcome! How can I assist you with your ${widget.courseName} result?"
        },
      ]);
    });
  }

  @override
  Future<void> update() async {
    try {
      await Future.delayed(Duration(seconds: 2));
      setState(() {
        messages.add({
          "sender": widget.lecturerName,
          "text": "Thank you for your patience. I’m reviewing your request.",
        });
      });
    } catch (e) {
      print('Update failed: $e');
    }
  }

  void _sendMessage() {
    if (messageController.text.isNotEmpty) {
      setState(() {
        messages.add({"sender": "You", "text": messageController.text});
        messageController.clear();
      });
      update(); // Call update to simulate refreshing or checking for new messages
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.courseName} - Chat with ${widget.lecturerName}'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[messages.length - index - 1];
                final isMe = message['sender'] == "You";
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment:
                        isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                      decoration: BoxDecoration(
                        color: isMe ? Colors.blueAccent : Colors.grey[300],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        message['text']!,
                        style: TextStyle(
                            color: isMe ? Colors.white : Colors.black),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blueAccent),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
}
