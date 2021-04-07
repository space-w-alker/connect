import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String DB_PATH = "key_store_path.db";
const String TABLE_NAME = "key_store_table";
const String ID = "_id";
const String PUBLIC_KEY = "public_key";
const String PRIVATE_KEY = "private_key";

class KeyStore {
  int id;
  final String publicKey;
  final String privateKey;

  KeyStore({this.id, this.privateKey, this.publicKey});
  KeyStore.fromMap(Map<dynamic, dynamic> map)
      : id = map[ID],
        publicKey = map[PUBLIC_KEY],
        privateKey = map[PRIVATE_KEY];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      ID: id,
      PUBLIC_KEY: publicKey,
      PRIVATE_KEY: privateKey
    };
  }
}

class KeyStoreProvider {
  Database db;
  Future open() async {
    String dbPath = join(await getDatabasesPath(), DB_PATH);
    db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
      create table $TABLE_NAME (
      $ID integer primary key autoincrement
      $PUBLIC_KEY text not null
      $PRIVATE_KEY text not null
      )
      ''');
      },
    );
  }

  Future insert(KeyStore keyStore) async {
    keyStore.id = await db.insert(TABLE_NAME, keyStore.toMap(), conflictAlgorithm: ConflictAlgorithm.fail);
  }

  Future<KeyStore> getKeyStore(int id) async{
    List<Map> maps = await db.query(TABLE_NAME, where: "$ID = ?", whereArgs: [id]);
    if(maps.length > 0){
      return KeyStore.fromMap(maps.first);
    }
    return KeyStore(id: -1, privateKey: "-1", publicKey: "-1");
  }

  Future<List<KeyStore>> getAll()async{
    List<Map> maps = await db.query(TABLE_NAME);
    return maps.map((e) => KeyStore.fromMap(e));
  }

  Future<int> update(KeyStore keyStore) async {
    return await db.update(TABLE_NAME, keyStore.toMap(),
      where: '$ID = ?', whereArgs: [keyStore.id]);
  }

  Future close() async{
    await db.close();
  }
}
