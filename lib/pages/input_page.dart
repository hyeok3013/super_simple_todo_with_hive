import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:super_simple_todo_with_hive/models/task_model.dart';

class InputPage extends StatefulWidget {
  InputPage({Key? key}) : super(key: key);

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Box<TaskModel> box = Hive.box<TaskModel>("TaskBox");

  TextEditingController _titleController = TextEditingController();

  String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("입력하기"),
        actions: [
          TextButton(
            onPressed: () {
              box.add(TaskModel(title!, false));
              setState(() {});
              Navigator.of(context).pop();
            },
            child: Text(
              "완료",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: TextFormField(
        controller: _titleController,
        onChanged: (_) {
          title = _titleController.text;
        },
      ),
    );
  }
}
