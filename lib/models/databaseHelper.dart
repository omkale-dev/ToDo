import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await initDatabase();
      return _database;
    }
  }

  Future<Database> initDatabase() async {
    print('initDatabase:');
    //opens the data base
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'todo.db');
    print("Path to database:" + path);
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE ToDo (id INTEGER PRIMARY KEY, task TEXT, isDone bool)');
    });
  }

  Future<List<Map>> fetchFromDatabase() async {
    print("Fetch from database");
    Database db = await instance.database;
    List<Map> list = await db.rawQuery('SELECT * FROM ToDo');

    return list;
  }

  addItemToDatabase({String name, bool isDone}) async {
    print('addItemToDatabase');
    //adds item to database
    Database db = await instance.database;
    await db.transaction((txn) async {
      //id1 is id of the inserted record, 0 if not inserted
      int id1 = await txn
          .rawInsert('INSERT INTO ToDo(task, isDone) VALUES("$name",$isDone)');
      print('inserted1: $id1');
    });
  }

  updateItemInDatabase({bool isDone, String task}) async {
    print('updateItemInDatabase');
    // Update some record
    Database db = await instance.database;
    int count = await db
        .rawUpdate('UPDATE ToDo SET isDone = ? WHERE task = ?', [isDone, task]);
    //count is number of changes made
    print('updated: $count');
  }

  deleteFromDatabase({String task}) async {
    print('deleteFromDatabase');
    // deletes item from database
    Database db = await instance.database;
    int count = await db.rawDelete('DELETE FROM ToDo WHERE task = ?', [task]);
    // count is number of records deleted
    print(count);
  }

  closeDatabase() async {
    print("Close the database");
    // on app close please close the database
    Database db = await instance.database;
    await db.close();
  }
}
