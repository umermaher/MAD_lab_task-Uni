
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'Student.dart';

class DatabaseHelper {
  static Database? _database;
  String tableName = "students";
  get database async {
    if(_database != null) {
      return _database!;
    } else {
      _database = await initDb();
      return _database;
    }
  }

  Future<Database> initDb() async {
    final dbPath = await getDatabasesPath();
    final db = join(dbPath, "students.db");
    return await openDatabase(
        db,
        version: 1,
        onCreate: (db, version) {
          db.execute(
              "CREATE TABLE $tableName(id INTEGER PRIMARY KEY, title TEXT, desc TEXT)"
          );
        }
    );
  }

  insert(Student student) async {
    final Database db = await database;
    Map<String, dynamic> notemap = {
      "id": student.id,
      "name": student.name,
      "roll_no": student.rollNo,
    };
    db.insert(tableName, notemap);
  }

  // Future<List<Map<String, dynamic>>> queryAll() async {
  //   final Database db = await database;
  //   return db.query(tableName);
  // }

  Future<List<Student>> queryAll() async {
    final db = await database;
    List<Map<String, dynamic>> students = await db.query(tableName);
    return List.generate(students.length, (index) {
      return Student(
        id: students[index]["id"],
        name: students[index]["name"],
        rollNo: students[index]["roll_no"],
      );
    });
  }

  update(Student student) async {
    final Database db = await database;
    Map<String, dynamic> notemap = {
      "id": student.id,
      "name": student.name,
      "roll_no": student.rollNo,
    };
    db.update(tableName, notemap, where: "id=?", whereArgs: [student.id, student.name, student.rollNo]);
  }

  delete(int id) async {
    final Database db = await database;
    db.delete(
        tableName,
        where: "id = ?",
        whereArgs: [id]
    );
  }

}