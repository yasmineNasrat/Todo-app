import 'package:sqflite/sqflite.dart';

Database database;
List<Map> tasks = [];
Future<Database> createDB() async {
  database = await openDatabase('todo.db', version: 1,
      onCreate: (database, version) async {
    await database
        .execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT)')
        .then((value) {
      print("Table Created");
    }).catchError((error) {
      print('Error:${error.toString()}');
    });
  }, onOpen: (database) {
    getDataFromDB(database).then((value) {
      tasks = value;
      print(tasks);
    });
    print("db opened");
  });
}

Future insertToDB({ String title}) async {
  return await database.transaction((txn) {
    txn.rawInsert('INSERT INTO tasks(title) VALUES ("$title")').then((value) {
      print("$value INSERTED SUCCESSFULLY");
    }).catchError((error) {
      print('error: ${error.toString()}');
    });
    return null;
  });
}

Future<List<Map>> getDataFromDB(database) async {
  return await database.rawQuery('SELECT * FROM tasks');
}
