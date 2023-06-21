import 'dart:io';

import 'package:drift/drift.dart';
// These imports are used to open the database
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

class Users extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get email => text()();
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    return NativeDatabase.createInBackground(file);
  });
}

@DriftDatabase(tables: [Users])
class AppDatabase extends _$AppDatabase {
  // we tell the database where to store the data with this constructor
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<User>> getListUsers() async{
    return await select(users).get();
  }

  Future<int> insertUser(UsersCompanion usersCompanion) async{
    return await into(users).insert(usersCompanion);
  }

  Future<int> deleteUser(UsersCompanion usersCompanion) async{
    return await delete(users).delete(usersCompanion);
  }

  Future<bool> updateUser(UsersCompanion usersCompanion) async{
    return await update(users).replace(usersCompanion);
  }

}

