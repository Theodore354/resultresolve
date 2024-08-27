import 'package:flutter/material.dart';

class ComplaintFormScreen extends StatefulWidget {
  final String courseName;

  ComplaintFormScreen({super.key, required this.courseName});

  @override
  _ComplaintFormScreenState createState() => _ComplaintFormScreenState();
}

class _ComplaintFormScreenState extends State<ComplaintFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _indexController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String _issueStatus = 'Incomplete';
  String? _selectedLevel = 'Level 100';
  String? _selectedLecturer;

  // Predefined list of lecturers
  final List<String> _lecturers = [
    'Dr. Smith',
    'Prof. Johnson',
    'Ms. Williams',
    'Mr. Brown',
  ];

  // Dropdown for current levels
  final List<String> _levels = [
    'Level 100',
    'Level 200',
    'Level 300',
    'Level 400',
  ];

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Process the data or send it to the server
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form Submitted')),
      );
      // Clear the form fields
      _fullNameController.clear();
      _indexController.clear();
      _yearController.clear();
      _contactController.clear();
      _descriptionController.clear();
      setState(() {
        _selectedLecturer = null;
        _selectedLevel = 'Level 100';
        _issueStatus = 'Incomplete';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaint Form for ${widget.courseName}'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          // To avoid overflow issues
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _fullNameController,
                  decoration:
                      const InputDecoration(labelText: 'Student Full Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _indexController,
                  decoration: const InputDecoration(labelText: 'Index'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your index';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _yearController,
                  decoration:
                      const InputDecoration(labelText: 'Year Course Was Taken'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the year';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _contactController,
                  decoration:
                      const InputDecoration(labelText: 'Contact Information'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your contact information';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedLevel,
                  items: _levels.map((level) {
                    return DropdownMenuItem<String>(
                      value: level,
                      child: Text(level),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedLevel = newValue;
                    });
                  },
                  decoration: const InputDecoration(labelText: 'Current Level'),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select your current level';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedLecturer,
                  items: _lecturers.map((lecturer) {
                    return DropdownMenuItem<String>(
                      value: lecturer,
                      child: Text(lecturer),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedLecturer = newValue;
                    });
                  },
                  decoration:
                      const InputDecoration(labelText: 'Name of Lecturer'),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a lecturer';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  'Complaint Type',
                  style: const TextStyle(fontSize: 16),
                ),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Incomplete', style: TextStyle(fontSize:10),),
                        value: 'Incomplete',
                        groupValue: _issueStatus,
                        onChanged: (value) {
                          setState(() {
                            _issueStatus = value!;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Absent', style: TextStyle(fontSize: 10),),
                        value: 'Absent',
                        groupValue: _issueStatus,
                        onChanged: (value) {
                          setState(() {
                            _issueStatus = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide a description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
