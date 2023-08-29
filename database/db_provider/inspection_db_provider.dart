import 'package:chili/chili.dart';
import 'package:sqflite/sqflite.dart';
import 'package:yali_fitness_app/database/database_manager.dart';
import 'package:yali_fitness_app/models/inspection_item.dart';

class InspectionDBProvider {
  static final InspectionDBProvider _singleton = InspectionDBProvider._internal();
  factory InspectionDBProvider() {
    return _singleton;
  }
  InspectionDBProvider._internal();

  static Database? _db;

  Future<Database> get db async {
    if (_db != null && _db!.isOpen) {
      return _db!;
    }
    _db = await DatabaseManager().db;
    return _db!;
  }

  Future<List<InspectionItem>> findAll() async {
    _db = await db;
    try {
      return await _db!.query(DatabaseManager.inspection_table).then((value) {
        return value.map((e) => fromMap(e)).toList();
      });
    } finally {
      await _db!.close();
    }
  }

  Future<void> update(List<InspectionItem> data) async {
    _db = await db;
    try {
      _db!.transaction((txn) async{
        final batch = txn.batch();
        batch.delete(DatabaseManager.inspection_table);
        data.forEach((element) {
          batch.insert(DatabaseManager.inspection_table, toMap(element));
        });
        print('更新完成');
        return await batch.commit();
      });
    } finally {
      await _db!.close();
    }
  }

  static Map<String, dynamic> toMap(InspectionItem item) =>
      {'id': item.id, 'name': item.name, 'content': item.content};

  static InspectionItem fromMap(Map<String, dynamic> map) =>
      InspectionItem(id: map['id'], name: map['name'], content: map['content']);
}
