import 'package:hive/hive.dart';

part 'student.g.dart';  // This part directive is important for code generation

@HiveType(typeId: 0)  // The typeId must be unique for each Hive object
class Student {
  @HiveField(0)  // Field index
  String studentName;

  @HiveField(1)  // Field index
  String vision;

  @HiveField(2)  // Field index
  String photo;  // New field to store the photo path

  Student(this.studentName, this.vision, this.photo);
}