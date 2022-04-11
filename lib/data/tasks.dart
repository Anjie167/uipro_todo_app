import 'package:flutter/material.dart';

class Task {
  int taskNumber;
  String title;
  Color progressColor;
  double value;

  Task({
    required this.taskNumber,
    required this.title,
    required this.progressColor,
    required this.value
  });
}

List<Task> categoryList = [
  Task(taskNumber: 30, title: "Business", progressColor: const Color(0xFFAC05FF), value: 3.0),
  Task(taskNumber: 16, title: "Personal", progressColor:  Colors.blue, value: 1.6),
  Task(taskNumber: 15, title: "Programming", progressColor: Colors.green, value: 1.5),
  Task(taskNumber: 3, title: "Sports", progressColor: Colors.red, value: 0.3),
  Task(taskNumber: 60, title: "Family", progressColor: Colors.orange, value: 6.0),
];
