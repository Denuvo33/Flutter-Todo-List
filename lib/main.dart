import 'package:flutter/material.dart';
import 'package:learn_sql/create_screen.dart';
import 'package:learn_sql/database_instance.dart';
import 'package:learn_sql/todo_model.dart';
import 'package:learn_sql/update_screen.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Sqflite();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseInstance? databaseInstance;

  Future _refresh() async {
    setState(() {});
  }

  Future initDatabase() async {
    await databaseInstance!.database();
    setState(() {});
  }

  Future delete(int id) async {
    await databaseInstance!.delete(id);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    databaseInstance = DatabaseInstance();
    initDatabase();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CreateScreen()))
                    .then((value) {
                  setState(() {});
                });
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: databaseInstance != null
            ? FutureBuilder<List<TodoList>>(
                future: databaseInstance!.all(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.length == 0) {
                      return Center(child: Text('No Task'));
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Dismissible(
                          key: Key(snapshot.toString()),
                          onDismissed: (direction) {
                            delete(snapshot.data![index].id!);
                            setState(() {
                              snapshot.data!.removeAt(index);
                            });
                          },
                          child: ListTile(
                            title: Text(
                                snapshot.data![index].title!.toUpperCase()),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(snapshot.data![index].desc ?? ''),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    'Created At: ${snapshot.data![index].createdAt!}'),
                                Text(
                                    'Updated At: ${snapshot.data![index].UpdatedAt!}'),
                                Divider()
                              ],
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UpdateScreen(
                                                todoModel:
                                                    snapshot.data![index],
                                              ))).then((value) {
                                    setState(() {});
                                  });
                                },
                                icon: Icon(Icons.edit)),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                })
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
