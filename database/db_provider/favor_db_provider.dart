import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:yali_fitness_app/database/create_table_sqls.dart';
import 'package:yali_fitness_app/database/database_manager.dart';
import 'package:yali_fitness_app/models/favorite.dart';
import 'package:yali_fitness_app/models/pageable.dart';


class FavorDBProvider {
  static final FavorDBProvider _singleton = FavorDBProvider._internal();
  factory FavorDBProvider() {
    return _singleton;
  }
  FavorDBProvider._internal();

  static Database? _db;

  Future<Database> get db async {
    if (_db != null && _db!.isOpen) {
      return _db!;
    }
    _db = await DatabaseManager().db;
    return _db!;
  }

  /// 收藏报告
  /// isFavor：true: 已收藏；false: 未收藏
  /// reportId 报表id
  /// 报表的用户id
  Future<dynamic> save( bool isFavor,{required int reportId,required int userId}) async{
    _db = await db;
    int favorId = DatabaseManager.generateId();
    String param = isFavor ? "false" : "true";
    try {
      return await _db!.transaction((txn) async{
        final batch = txn.batch();
        batch.rawInsert("insert into FAVORITE (favorId,report_id,user_id,device_id) values ($favorId,$reportId,$userId,(select deviceId from DEVICE));");
        batch.update(DatabaseManager.report_table, {"favorite": "$param"},whereArgs: [reportId], where: "repId=?");
        return await batch.commit();
      });
    }finally {
      _db!.close();
    }
  }


}