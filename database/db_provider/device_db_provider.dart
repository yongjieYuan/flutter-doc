import 'dart:io';
import 'package:chili/chili.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:yali_fitness_app/database/create_table_sqls.dart';
import 'package:yali_fitness_app/database/database_manager.dart';
import 'package:yali_fitness_app/models/device.dart';

class DeviceDBProvider {
  static final DeviceDBProvider _singleton = DeviceDBProvider._internal();
  factory DeviceDBProvider() {
    return _singleton;
  }
  DeviceDBProvider._internal();

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

  /// 初始化数据库，
  // Future<Database> _initDB() async {
  //   Directory documentsDirectory = await getApplicationDocumentsDirectory();
  //   String path = join(documentsDirectory.path, DatabaseManager.device_table);
  //   return await openDatabase(path, version: 1, onCreate: (db, version) {
  //     return db.execute(CreateTableSqls.device_table_sql);
  //   });
  // }

  /// 更新本地的设备信息
  Future<int?> updateDevice(Device device) async{
    _db = await db;
    try {
      return await getDevice(deviceNumber: device.number!).then((value) async{
        _db = await db;
        if(value != null) {/// 查找到设备并更新
          int res = await _db!.update(DatabaseManager.device_table, toMap(device), where: "number=?",whereArgs: [device.number]);
          return res;
        }
        return await _db!.transaction((txn) async{
          await txn.delete(DatabaseManager.device_table);
          return await txn.insert(DatabaseManager.device_table, toMap(device));
        });
      });
    } finally {
      await _db!.close();
    }
  }

  /// 通过机器编号查询本地是否存在在这台机器，返回null则代表没有
  Future<Device?> getDevice({required String deviceNumber}) async{
    _db = await db;
    try {
      List<Map<String, dynamic>> list =  await _db!.query(DatabaseManager.device_table, where: "number=?",whereArgs: [deviceNumber]);
      if(list.isEmpty) {
        return null;
      } else {
        Map<String,dynamic> map = list.first;
        return fromMap(map);
      }
    }finally {
      await _db!.close();
    }
  }

  static Device fromMap(Map<String, dynamic> map) => Device(
        id: map['deviceId'],
        enabled: (map['enabled'] != null && map['enabled'] == 'true') ? true : false,
        activated: (map['activated'] != null && map['activated'] == 'true') ? true : false,
        number: map['number'],
        name: map['name'],
        phone: map['phone'],
        brand: map['brand'],
        province: map['province'],
        city: map['city'],
        district: map['district'],
        address: map['address'],
        activationTime: TimeUtils.parseDateTime(map['activationTime']),
        creationTime: TimeUtils.parseDateTime(map['creationTime']),
      );

  static Map<String, dynamic> toMap(Device device) => {
    'deviceId': device.id,
    'enabled': device.enabled.toString(),
    'activated': device.activated.toString(),
    'number': device.number,
    'name': device.name,
    'phone': device.phone,
    'brand': device.brand,
    'province': device.province,
    'city': device.city,
    'district': device.district,
    'address': device.address,
    'activationTime': TimeUtils.formatDataTime(device.activationTime),
    'creationTime': TimeUtils.formatDataTime(device.creationTime),
  };

}
