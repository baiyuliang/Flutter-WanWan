import 'package:moor_flutter/moor_flutter.dart';

part 'db.g.dart';

@DataClassName("User")
class UserTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get userid => text()();

  TextColumn get pwd => text()();

  TextColumn get nickname => text()();

  TextColumn get avatar => text()();

  TextColumn get imToken => text()();
}

@UseMoor(tables: [UserTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase._()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: "db.sqlite", logStatements: true));

  static AppDatabase _instance;

  static AppDatabase getInstance() {
    if (_instance == null) {
      _instance = AppDatabase._();
    }
    return _instance;
  }

  int get schemaVersion => 1;

  Future<List<User>> getAllUsers() => select(userTable).get();

  Stream<List<User>> watchAllUsers() => select(userTable).watch();

  Future insertUser(User user) => into(userTable).insert(user);

  Future updateUser(User user) => update(userTable).replace(user);

  Future deleteUser(User user) => delete(userTable).delete(user);

  // SingleSelectable<User> getUser(String userid) =>
  //     select(userTable)..where((tbl) => tbl.userid.equals(userid));

  // Future<List<User>> getUserByPwd(String userid, String pwd) => (select(userTable)
  //   ..where((tbl) => tbl.userid.equals(userid))
  //   ..where((tbl) => tbl.pwd.equals(pwd))
  //   ..get()) as Future<List<User>>;

  Future getUser(String userid) {
    SingleOrNullSelectable selectable = select(userTable)
      ..where((tbl) => tbl.userid.equals(userid));
    return selectable.getSingleOrNull();
  }

  Future getUserByPwd(String userid, String pwd) {
    SingleOrNullSelectable selectable = select(userTable)
      ..where((tbl) => tbl.userid.equals(userid))
      ..where((tbl) => tbl.pwd.equals(pwd));
    return selectable.getSingleOrNull();
  }
}
