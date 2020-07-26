import 'package:activity_timers/model/ActivityTimer.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common/sqlite_api.dart';

//CODE PRODUCED AFTER FOLLOWING GUIDE FROM 'Coding With Curry' (2020) [SOURCE FOUND IN PICTORIAL]
// CODE WAS NOT COPIED FROM SOURCE BUT SIMILARITIES MAY OCCUR AS THIS PROJECT DEVELOPS UP PRINCIPALS LEARNED IN GUIDE

class DatabaseProvider {
  static const String TABLE_NAME = "timers";
  static const String COLUMN_ID = "id";
  static const String COLUMN_TITLE = "title";
  static const String COLUMN_DURATION = "duration";

  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();

  Database _database;

  Future<Database> get database async {
    print('Database getter called');

    if (_database != null) {
      return _database;
    }

    _database = await createDatabase();

    return _database;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, 'timerDB.db'),
      version: 1,
      onCreate: (Database database, int version) async {
        print('Creating timers table');

        await database.execute(
          "CREATE TABLE $TABLE_NAME ("
          "$COLUMN_ID INTEGER PRIMARY KEY,"
          "$COLUMN_TITLE TEXT,"
          "$COLUMN_DURATION INTEGER"
          ")",
        );
      },
    );
  }

  Future<List<ActivityTimer>> getTimers() async {
    final db = await database;

    var timers = await db
        .query(TABLE_NAME, columns: [COLUMN_ID, COLUMN_TITLE, COLUMN_DURATION]);

    List<ActivityTimer> timerList = List<ActivityTimer>();

    timers.forEach(
      (currentTimer) {
        ActivityTimer timer = ActivityTimer.fromMap(currentTimer);

        timerList.add(timer);
      },
    );

    return timerList;
  }

  Future<ActivityTimer> insert(ActivityTimer timer) async {
    final db = await database;
    timer.id = await db.insert(TABLE_NAME, timer.toMap());
    return timer;
  }

  Future<int> update(ActivityTimer timer) async {
    final db = await database;

    return await db.update(
      TABLE_NAME,
      timer.toMap(),
      where: "id = ?",
      whereArgs: [timer.id],
    );
  }
}
