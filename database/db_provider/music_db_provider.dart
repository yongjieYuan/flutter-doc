import 'package:sqflite/sqflite.dart';
import 'package:yali_fitness_app/database/database_manager.dart';
import 'package:yali_fitness_app/models/music.dart';

class MusicDBProvider {
  static final MusicDBProvider _singleton = MusicDBProvider._internal();
  factory MusicDBProvider() {
    return _singleton;
  }
  MusicDBProvider._internal();

  static Database? _db;

  /// 可作为数据库连接的方法，每次执行数据库的操作
  /// 都需要打开，完成后关闭数据库
  Future<Database> get db async {
    if (_db != null && _db!.isOpen) {
      return _db!;
    }
    _db = await DatabaseManager().db;
    return _db!;
  }

  Future<List<Music>> getMusic() async {
    _db = await db;
    try {
      List<Map<String, dynamic>> list = await _db!.query(DatabaseManager.music_table);
      if (list.isEmpty) {
        return [];
      } else {
        return list.map((e) => fromMap(e)).toList();
      }
    } finally {
      await _db!.close();
    }
  }

  Future<dynamic> updateMusic(List<Music> data) async {
    _db = await db;
    try {
      return await _db!.transaction((txn) async{
        final batch = txn.batch();
        batch.delete(DatabaseManager.music_table);
        data.forEach((element) {
          batch.insert(DatabaseManager.music_table,toMap(element));
        });
        return await batch.commit();
      });
    } finally {
      _db!.close();
    }
  }

  static Map<String, dynamic> toMap(Music item) =>
      {"id": item.id, "title": item.title, "file": item.file};

  static Music fromMap(Map<String, dynamic> map) => Music(
        id: map["id"],
        title: map['title'],
        file: map['file'],
      );
}
