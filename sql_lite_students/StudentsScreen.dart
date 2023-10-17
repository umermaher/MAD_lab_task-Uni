import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'Student.dart';
import 'StudentDatabaseHelper.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController rollno = TextEditingController();
  TextEditingController name = TextEditingController();
  int selectedId = -1;
  List<Student> students = [];

  _loadnotes() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    final notelist = await databaseHelper.queryAll();
    setState(() {
      students = notelist.cast<Student>();
    });
  }

  Future<void> update(dynamic updatedData) async {
    if (updatedData != null && updatedData is Student) {
      final updatedStudentIndex =
      students.indexWhere((student) => student.id == updatedData.id);
      if (updatedStudentIndex != -1) {
        setState(() {
          students[updatedStudentIndex] = updatedData;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadnotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text('SQL Database'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              size: 27,
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              TextField(
                controller: name,
                decoration: const InputDecoration(
                  labelText: "Name",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: rollno,
                decoration: const InputDecoration(
                  labelText: "Rollno",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(children: [
                ElevatedButton(
                  onPressed: () async {
                    DatabaseHelper dbHelper = DatabaseHelper();
                    Student note = Student(
                      rollNo: rollno.text,
                      name: name.text,
                    );
                    await dbHelper.insert(note);
                    _loadnotes();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent),
                  child: const Text("Insert Task"),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    DatabaseHelper dbHelper = DatabaseHelper();
                    Student note = Student(
                      id: selectedId,
                      rollNo: rollno.text,
                      name: name.text,
                    );
                    await dbHelper.update(note);
                    _loadnotes();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Student data updated.'),
                      duration: Duration(seconds: 2),
                    ));
                    rollno.text = '';
                    name.text = '';
                    setState(() {
                      selectedId = -1;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent),
                  child: const Text("Update Task"),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final updatedData = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => StudentDetail(),
                      ),
                    );
                    update(updatedData);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent),
                  child: const Text("List Of Students"),
                ),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}