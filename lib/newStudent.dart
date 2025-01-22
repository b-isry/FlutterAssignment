import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:noteapp/student.dart';

class Newstudent extends StatefulWidget {
  final Function(Student) onAddStudent;

  Newstudent({required this.onAddStudent});

  @override
  _NewstudentState createState() => _NewstudentState();
}

class _NewstudentState extends State<Newstudent> {
  final _nameController = TextEditingController();
  final _visionController = TextEditingController();
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _addStudent() {
    final name = _nameController.text;
    final vision = _visionController.text;

    if (name.isNotEmpty && vision.isNotEmpty && _image != null) {
      final newStudent = Student(name, vision, _image!.path);
      widget.onAddStudent(newStudent);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New Student')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _visionController,
              decoration: InputDecoration(labelText: 'Vision'),
            ),
            SizedBox(height: 10),
            _image == null
                ? Text('No image selected.')
                : Image.file(_image!),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            ElevatedButton(
              onPressed: _addStudent,
              child: Text('Add Student'),
            ),
          ],
        ),
      ),
    );
  }
}