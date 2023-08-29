import 'dart:io';
import 'package:chili/chili.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:yali_fitness_app/database/create_table_sqls.dart';
import 'package:yali_fitness_app/database/snowflake/snowflake.dart';
import 'package:yali_fitness_app/global.dart';
import 'package:yali_fitness_app/port/constant.dart';
import 'dart:math' as math;

/// 数据库管理
class DatabaseManager {
  // static final DatabaseManager _singleton = DatabaseManager._internal();
  // factory DatabaseManager() {
  //   return _singleton;
  // }
  // DatabaseManager._internal();
  /// 数据库名称
  static String db_name = "yali_db";
  /// 用户表
  static String user_table = "USER";
  /// 报告表
  static String report_table = "REPORT";
  /// 设备（机器）表
  static String device_table = "DEVICE";
  /// 收藏表
  static String favorite_table = "FAVORITE";
  /// 测试操作表
  static String operation_table = "OPERATION";
  /// 检查项表
  static String inspection_table = "INSPECTION";
  /// 测试音乐表
  static String music_table = "MUSIC";
  /// 建表语句
  static List<Map<String, String>> dbList = [
    {user_table: CreateTableSqls.user_table_sql},
    {device_table: CreateTableSqls.device_table_sql},
    {report_table: CreateTableSqls.report_table_sql},
    {favorite_table: CreateTableSqls.favorite_table_sql},
    {operation_table: CreateTableSqls.operation_step_sql},
    {inspection_table: CreateTableSqls.inspectionTable},
    {music_table: CreateTableSqls.musicTable}
  ];

  /// 数据库实例
  static Database? _db;

  Future<Database> get db async {
    if (_db != null && _db!.isOpen) {
      return _db!;
    }
    _db = await _init();
    return _db!;
  }

  /// 初始化数据库
  static Future<Database> _init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, db_name);
    return await openDatabase(path,version: 1,onCreate: (db,version) async{
      Future.forEach(dbList, (Map<String, String>table) async{
        await db.execute(table.values.first).then((value) {
          print('创建${table.keys.first}');
        });
      });
    },onOpen: (Database db){
      
    },);
  }

  static int generateId() {
    if(Global.globalDevice.number == null) {
      Global.globalDevice.number = LocalStorage.getString(Constant.DeviceNumber);
    }
    int number = math.Random().nextInt(500);
    var cfg = Config(number, 2, 1665973400073);
    return idWorker(cfg as DataConfig).generate();
  }
  
  /// 从数据库中获取已创建的表
  Future<List<String>> getTables() async{
    _db = await db;
    try {
      List<Map> data = await _db!.rawQuery('''SELECT name FROM sqlite_master WHERE type = "table"''');
      return data.map((e) => e["name"] as String).toList();
    } finally {
      _db!.close();
    }
  }

  // 抹除所有数据
  Future<void> clearData() async{
    _db = await db;
    try {
      Batch batch = _db!.batch();
      batch.delete(DatabaseManager.user_table);
      batch.delete(DatabaseManager.report_table);
      batch.delete(DatabaseManager.favorite_table);
      await batch.commit();
    }finally {
      _db!.close();
    }
  }
}
