import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:ungmitrphol/models/sqlite_model.dart';

class SQLiteHelper {
  final String databaseName = 'result.db';
  final int databaseVersion = 1;
  final String columnId = 'id';
  final String columnKey = 'codeKey';
  final String columnName = 'codeName';
  final String columnValue = 'codeValue';
  final String columnStamp = 'codeStamp';
  final String tableName = 'resultTable';

  SQLiteHelper() {
    initDatabase();
  }

  Future<Null> initDatabase() async {
    await openDatabase(join(await getDatabasesPath(), databaseName),
        onCreate: (db, version) => db.execute(
            'CREATE TABLE $tableName ($columnId INTEGER PRIMARY KEY, $columnKey TEXT, $columnName TEXT, $columnValue TEXT, $columnStamp TEXT)'),
        version: databaseVersion);
  }

  Future<Database> connectedDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), databaseName));
  }

  Future<Null> insertValueToSQLite(SQLiteModel model) async {
    Database database = await connectedDatabase();
    try {
      database
          .insert(
            tableName,
            model.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          )
          .then((value) => print('### insertValue to SQLite Success ###'));
    } catch (e) {
      print('### Error insertValue to SQLite ==> ${e.toString()}');
    }
  }

  Future<List<SQLiteModel>> readAllSQLite() async {
    Database database = await connectedDatabase();
    try {
      List<SQLiteModel> models = [];
      List<Map<String, dynamic>> maps = await database.query(tableName);
      for (var item in maps) {
        SQLiteModel model = SQLiteModel.fromMap(item);
        models.add(model);
      }
      return models;
    } catch (e) {
      print('### Error read SQLite ==> ${e.toString()}');
      return null;
    }
  }

  Future<Null> clearSQLite() async {
    Database database = await connectedDatabase();
    try {
      await database.delete(tableName);
    } catch (e) {}
  }

  Future<Null> deleteSQLiteWhereId(int id) async {
    Database database = await connectedDatabase();
    try {
      await database.delete(tableName, where: '$columnId = $id');
    } catch (e) {}
  }
}
