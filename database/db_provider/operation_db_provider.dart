import 'dart:io';
import 'package:chili/chili.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:yali_fitness_app/database/create_table_sqls.dart';
import 'package:yali_fitness_app/database/database_manager.dart';
import 'package:yali_fitness_app/models/operation.dart';
import 'package:yali_fitness_app/models/model.dart';

class OperationDBProvider {
  static final OperationDBProvider _singleton = OperationDBProvider._internal();
  factory OperationDBProvider() {
    return _singleton;
  }
  OperationDBProvider._internal();

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

  /// 获取操作表
  Future<List<OperationStep>> getOpertaionStep() async{
    _db = await db;
    try {
      List<Map<String, dynamic>> list = await _db!.query(DatabaseManager.operation_table);
      logger.d('测试步骤：',list);
      if(list.isEmpty) {
        return [];
      } else {
        return list.map((e) => fromMap(e)).toList();
      }
    }finally {
      await _db!.close();
    }
  }

  /// 更新数据
  Future<dynamic> updateOperationStep(List<OperationStep> data) async{
    _db = await db;
    try {
      return await _db!.transaction((txn) async{
        final batch = txn.batch();
        batch.delete(DatabaseManager.operation_table);
        data.forEach((element) {
          batch.insert(DatabaseManager.operation_table, toMap(element));
        });
        logger.d('更新操作表');
        return await batch.commit();
      });
    }finally {
      await _db!.close();
    }
  }

  static Map<String, dynamic> toMap(OperationStep operation) => {
        'id': operation.id,
        'position': operation.position,
        'name': operation.name,
        'description': operation.description,
        'image': operation.image,
        'audio': operation.audio,
      };

  static OperationStep fromMap(Map<String, dynamic> map) => OperationStep(
      id: map['id'],
      position: map['position'],
      name: map['name'],
      description: map['description'],
      image: map['image'],
      audio: map['audio']);
}
