import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:super_simple_todo_with_hive/models/task_model.dart';

class UpdatePage extends StatefulWidget {
  UpdatePage({Key? key, required this.index}) : super(key: key);
  int index;

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
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
              box.putAt(widget.index, TaskModel(title!, false));

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
