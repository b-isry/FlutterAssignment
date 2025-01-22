import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:noteapp/student.dart';
import 'package:noteapp/details.dart';
import 'package:noteapp/newStudent.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(StudentAdapter()); 
  await Hive.openBox<Student>('students');
  runApp(MyNoteApp());
}

class MyNoteApp extends StatefulWidget {
  const MyNoteApp({super.key});

  @override
  State<MyNoteApp> createState() => _MyNoteAppState();
}

class _MyNoteAppState extends State<MyNoteApp> {
  late Box<Student> studentBox;

  @override
  void initState() {
    super.initState();
    studentBox = Hive.box<Student>('students');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          title: const Text(
            "Visions",
            style: TextStyle(color: Colors.white),
          ),
        ),
        drawer: Container(
          width: 300,
          color: const Color.fromARGB(255, 255, 255, 255),
          child: ListView(
            children: [
              DrawerHeader(
                child: Row(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        "assets/1.jpg",
                        width: 50,
                        height: 50,
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Bisrat Teshome",
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.account_circle_rounded),
                title: const Text("Home"),
              ),
              ListTile(
                leading: const Icon(Icons.help),
                title: const Text("About"),
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text("Settings"),
              ),
            ],
          ),
        ),
        body: ValueListenableBuilder(
          valueListenable: studentBox.listenable(),
          builder: (context, Box<Student> box, _) {
            if (box.isEmpty) {
              return const Center(child: Text('No students added yet.'));
            }

            List<Student> students = box.values.toList();

            return ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                Student student = students[index];
                return ListTile(
                  contentPadding: const EdgeInsets.all(10.0),
                  // leading: ClipOval(
                  //   child: Image.file(
                  //     File(student.photo),
                  //     width: 50,
                  //     height: 50,
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  title: Text(
                    student.studentName,
                    style: const TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  subtitle: Text(student.vision),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => DetailsPage(
                          name: student.studentName,
                          vision: student.vision,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Newstudent(
                    onAddStudent: (student) async {
                      // Add the new student to the Hive box
                      await studentBox.add(student);
                      setState(() {});
                    },
                  ),
                ),
              );
            },
            child: const Icon(Icons.add),
          );
        }),
      ),
    );
  }
}
