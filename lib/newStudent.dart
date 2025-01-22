import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
// import 'package:hive/hive.dart';
import 'student.dart'; // Ensure Student class is in your import

class Newstudent extends StatefulWidget {
  // Add onAddStudent callback parameter
  final Function(Student) onAddStudent;

  const Newstudent({super.key, required this.onAddStudent});

  @override
  _NewstudentState createState() => _NewstudentState();
}

class _NewstudentState extends State<Newstudent> {
  File? _image; // Variable to store the selected image
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _visionController = TextEditingController();

  // Function to pick image from gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path); // Store the picked image
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Vision', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 16.0),
              // Name TextField
              SizedBox(
                width: 300,
                height: 50,
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Name",
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              // Vision TextField
              SizedBox(
                width: 300,
                height: 50,
                child: TextField(
                  controller: _visionController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Vision",
                  ),
                ),
              ),
              const SizedBox(height: 16.0),

              // Display the selected image
              _image == null
                  ? const Text('No image selected.') // If no image is selected, show this text
                  : Image.file(
                      _image!,
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),

              const SizedBox(height: 16.0),

              // Buttons to pick image from gallery or camera
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Center the buttons
                children: [
                  ElevatedButton(
                    onPressed: () => _pickImage(ImageSource.gallery), // Pick from gallery
                    child: const Icon(Icons.image_search),
                  ),
                  const SizedBox(width: 16.0), // Add space between the buttons
                  ElevatedButton(
                    onPressed: () => _pickImage(ImageSource.camera), // Take a picture
                    child: const Icon(Icons.camera),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Get the student data
                  String name = _nameController.text;
                  String vision = _visionController.text;
                  String photo = _image?.path ?? ''; // Path of the image (or an empty string if no image)

                  // Ensure that the fields are not empty
                  if (name.isEmpty || vision.isEmpty ) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please fill all fields")));
                    return;
                  }

                  // Create a new student object
                  Student newStudent = Student(name, vision);

                  // Call the onAddStudent function to add the new student
                  widget.onAddStudent(newStudent);

                  // Go back to the previous screen
                  Navigator.of(context).pop();
                  
                },
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
