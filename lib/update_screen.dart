import 'package:flutter/material.dart';
import 'package:learn_sql/database_instance.dart';
import 'package:learn_sql/todo_model.dart';

class UpdateScreen extends StatefulWidget {
  final TodoList? todoModel;
  const UpdateScreen({super.key, this.todoModel});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  DatabaseInstance databaseInstance = DatabaseInstance();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState

    databaseInstance.database();
    _titleController.text = widget.todoModel!.title ?? '';
    _descController.text = widget.todoModel!.desc ?? '';
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update'),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                  hintText: 'Title', border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _descController,
              decoration: InputDecoration(
                  hintText: 'Description', border: OutlineInputBorder()),
            ),
            ElevatedButton(
                onPressed: () async {
                  await databaseInstance.update(widget.todoModel!.id!, {
                    'title': _titleController.text,
                    'desc': _descController.text,
                    'updated_at':
                        TimeOfDay.fromDateTime(DateTime.now()).toString(),
                  });
                  Navigator.pop(context);
                  setState(() {});
                },
                child: Text('Update'))
          ],
        ),
      ),
    );
  }
}
