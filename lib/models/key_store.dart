import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String DB_PATH = "key_store_path.db";
const String TABLE_NAME = "app_data_table";
const String ID = "_id";
const String PUBLIC_KEY = "public_key";
const String PRIVATE_KEY = "private_key";
const String TEAM_NAME = "team_name";
const String TEAM_LEADER = "team_leader";
const String TEAM_COUNT = "team_count";
const String TEAM_TYPE = 'team_type';

const String INVENTORY_TABLE_NAME = 'inventory_table_name';
const String ITEM_ID = '_id';
const String ITEM_TYPE = 'item_type';
const String ITEM_COUNT = 'item_count';

const String COMMUNICATE_TABLE_NAME = 'comm_table_name';

class TeamData {
  int id;
  final String publicKey;
  final String privateKey;
  String leaderName;
  String teamName;
  int teamCount;
  String teamType;

  TeamData({
    this.id,
    this.privateKey,
    this.publicKey,
    this.leaderName = "NULL",
    this.teamCount = 0,
    this.teamName = "NULL",
    this.teamType = "main",
  });
  TeamData.fromMap(Map<dynamic, dynamic> map)
      : id = map[ID],
        publicKey = map[PUBLIC_KEY],
        privateKey = map[PRIVATE_KEY],
        leaderName = map[TEAM_LEADER],
        teamName = map[TEAM_NAME],
        teamCount = map[TEAM_COUNT],
        teamType = map[TEAM_TYPE];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      ID: id,
      PUBLIC_KEY: publicKey,
      PRIVATE_KEY: privateKey,
      TEAM_LEADER: leaderName,
      TEAM_NAME: teamName,
      TEAM_COUNT: teamCount,
      TEAM_TYPE: teamType,
    };
  }
}

class TeamDataProvider {
  static Database db;
  static Future open() async {
    String dbPath = join(await getDatabasesPath(), DB_PATH);
    db = await openDatabase(
      dbPath,
      version: 5,
      onCreate: (db, version) {
        var batch = db.batch();
        batch.execute('''
        create table $TABLE_NAME (
          $ID integer primary key autoincrement,
          $PUBLIC_KEY text not null,
          $PRIVATE_KEY text not null,
          $TEAM_NAME text,
          $TEAM_LEADER text,
          $TEAM_TYPE text,
          $TEAM_COUNT integer
        )
        ''');
        batch.execute('''
        create table $INVENTORY_TABLE_NAME(
          $ITEM_ID integer primary key autoincrement,
          $ITEM_TYPE string not null,
          $ITEM_COUNT integer not null,
          $PUBLIC_KEY integer not null,
          foreign key ($PUBLIC_KEY) references $TABLE_NAME ($PUBLIC_KEY)
        )
        ''');
        batch.commit();
      },
    );
  }

  static Future insert(TeamData keyStore) async {
    List<Map> maps = await db.query(TABLE_NAME, where: "$PUBLIC_KEY = ?", whereArgs: [keyStore.publicKey]);
    if (maps.length > 0) {
      throw ArgumentError("Duplicate Entry");
    }
    if (keyStore.teamType == "main") {
      maps = await db.query(TABLE_NAME, where: "$TEAM_TYPE = ?", whereArgs: ["main"]);
      if (maps.length > 0) {
        throw ArgumentError("Duplicate Main Team Entry");
      }
    }
    keyStore.id = await db.insert(TABLE_NAME, keyStore.toMap(), conflictAlgorithm: ConflictAlgorithm.fail);
  }

  static Future<TeamData> getKeyStore(String publicKey) async {
    List<Map> maps = await db.query(TABLE_NAME, where: "$PUBLIC_KEY = ?", whereArgs: [publicKey]);
    if (maps.length > 0) {
      return TeamData.fromMap(maps.first);
    }
    return TeamData(id: -1, privateKey: "-1", publicKey: "-1");
  }

  static Future<TeamData> getMain() async {
    List<Map> maps = await db.query(TABLE_NAME, where: "$TEAM_TYPE = ?", whereArgs: ["main"]);
    if (maps.length > 0) {
      return TeamData.fromMap(maps.first);
    }
    return TeamData(id: -1);
  }

  static Future<int> deleteMain() async {
    return await db.delete(TABLE_NAME, where: "$TEAM_TYPE = ?", whereArgs: ["main"]);
  }

  static Future<List<TeamData>> getAll() async {
    List<Map> maps = await db.query(TABLE_NAME);
    return maps.map((e) => TeamData.fromMap(e)).toList();
  }

  static Future<int> update(TeamData keyStore) async {
    return await db.update(TABLE_NAME, keyStore.toMap(), where: '$ID = ?', whereArgs: [keyStore.id]);
  }

  static Future close() async {
    await db.close();
  }
}
