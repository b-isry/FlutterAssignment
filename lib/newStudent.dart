import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:noteapp/student.dart';

class Newstudent extends StatefulWidget {
  final Function(Student) onAddStudent;

  const Newstudent({super.key, required this.onAddStudent});

  @override
  _NewstudentState createState() => _NewstudentState();
}

class _NewstudentState extends State<Newstudent> {
  final _nameController = TextEditingController();
  final _visionController = TextEditingController();
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _addStudent() async {
    if (_image == null) return;

    final name = _nameController.text;
    final vision = _visionController.text;

    if (name.isNotEmpty && vision.isNotEmpty) {
      final newStudent = Student(name, vision, _image!.path);
      widget.onAddStudent(newStudent);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        title: Text('Add New Student' , style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),),
        iconTheme: IconThemeData(color: Colors.white),
      ),
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
                : Image.file(_image!, width: 100, height: 100),
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
