import 'package:flutter/material.dart';
import 'package:learn_sql/database_instance.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  DatabaseInstance databaseInstance = DatabaseInstance();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    databaseInstance.database();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create'),
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
                  await databaseInstance.insert({
                    'title': _titleController.text,
                    'desc': _descController.text,
                    'created_at':
                        TimeOfDay.fromDateTime(DateTime.now()).toString(),
                    'updated_at':
                        TimeOfDay.fromDateTime(DateTime.now()).toString(),
                  });
                  Navigator.pop(context);
                  setState(() {});
                },
                child: Text('Create'))
          ],
        ),
      ),
    );
  }
}
