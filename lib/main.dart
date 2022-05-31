import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:super_simple_todo_with_hive/models/task_model.dart';
import 'package:super_simple_todo_with_hive/pages/input_page.dart';
import 'package:super_simple_todo_with_hive/pages/update_page.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  await Hive.openBox<TaskModel>("TaskBox");
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Box<TaskModel> box = Hive.box<TaskModel>("TaskBox");
  TextEditingController _titleController = TextEditingController();

  String? title;
  void CreatDialog() {
    showDialog(
        context: context,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            //Dialog Main Title
            title: Column(
              children: <Widget>[
                new Text("Dialog Title"),
              ],
            ),
            //
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _titleController,
                  onChanged: (_) {
                    title = _titleController.text;
                  },
                ),
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text("확인"),
                onPressed: () {
                  box.add(TaskModel(title!, false));
                  Navigator.pop(context);
                  _titleController.clear();
                  setState(() {});
                },
              ),
            ],
          );
        });
  }

  void UpdateDialog(int index) {
    showDialog(
        context: context,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            //Dialog Main Title
            title: Column(
              children: <Widget>[
                new Text("Dialog Title"),
              ],
            ),
            //
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _titleController,
                  onChanged: (_) {
                    title = _titleController.text;
                  },
                ),
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text("확인"),
                onPressed: () {
                  box.putAt(index, TaskModel(title!, false));
                  Navigator.pop(context);
                  _titleController.clear();
                  setState(() {});
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          CreatDialog();
        },
      ),
      appBar: AppBar(
        title: Text("Hive + Todo"),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                box.getAt(index)!.title,
              ),
              onTap: () {
                box.deleteAt(index);
                setState(() {});
              },
              onLongPress: () {
                UpdateDialog(index);
              },
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              color: Colors.black,
            );
          },
          itemCount: box.length),
    );
  }
}
