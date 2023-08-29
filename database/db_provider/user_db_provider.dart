import 'dart:io';
import 'dart:math';
import 'package:chili/chili.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:yali_fitness_app/database/create_table_sqls.dart';
import 'package:yali_fitness_app/database/database_manager.dart';
import 'package:yali_fitness_app/models/pageable.dart';
import 'package:yali_fitness_app/models/user.dart';
import 'package:logger/logger.dart';

/// 用户表操作类
class UserDBProvider {
  static final UserDBProvider _singleton = UserDBProvider._internal();
  factory UserDBProvider() {
    return _singleton;
  }
  UserDBProvider._internal();

  static Database? _db;

  static const String allChars = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890_";

  Future<Database> get db async {
    if (_db != null && _db!.isOpen) {
      return _db!;
    }
    _db = await DatabaseManager().db;
    return _db!;
  }


  // Future<Database> _initDB() async {
  //   Directory documentsDirectory = await getApplicationDocumentsDirectory();
  //   String path = join(documentsDirectory.path, DatabaseManager.db_name);
  //   return await openDatabase(path, version: 1, onCreate: (db, version) {
  //     db.execute(CreateTableSqls.user_table_sql);
  //   });
  // }

  /// 更新体重
  Future<int> updateUser({required User user}) async{
    _db = await db;
    if(user.id == null) {
      return Future.error("用户id不能为空");
    }
    try {
      return _db!.update(DatabaseManager.user_table, toMap(user),where: "userId=?",whereArgs: ["${user.id}"]);
    } finally {
      _db!.close();
    }
  }

  /// 根据手机号模糊搜索匹配的用户手机号
  Future<List<String>> matchPhone([String? phone]) async{
    _db = await db;
    try {
      List<Map<String, dynamic>> data = [];
      if(phone != null && phone.isNotEmpty) {
        data = await _db!.query(DatabaseManager.user_table,columns: ['phone'],where: "phone LIKE ?",whereArgs: ['%$phone%']);
      } else {
        data = await _db!.query(DatabaseManager.user_table,columns: ['phone']);
      }
      return data.map((e) => e['phone'] as String).toList();
    }finally {
      _db!.close();
    }
  }

  /// 根据id查询指定的用户信息
  Future<User> getUser({required int id}) async{
   _db = await db;
   try {
     List<Map<String, dynamic>> data = await _db!.query(DatabaseManager.user_table, where: "userId=?",whereArgs: [id]);
     return fromMap(data.first);
   }finally {
     _db!.close();
   }
  }

  /// 根据用户手机号phone查询到用户信息
  Future<User> getUserInfoByPhone({required String phone}) async {
    _db = await db;
    try {
      List<Map<String, dynamic>> data = await _db!.query(DatabaseManager.user_table,where: "phone=?",whereArgs: [phone]);
      return fromMap(data.first);
    }finally {
      _db!.close();
    }
  }

  /// 删除会员
  Future<dynamic> deleteMember({required int userId}) async{
    _db = await db;
    try {
      return await _db!.transaction((txn) async{
        final batch = txn.batch();
       // batch.delete(DatabaseManager.user_table, where: "id=?", whereArgs: [userId]);
       // batch.delete(DatabaseManager.report_table, where: "owner_id=?", whereArgs: [userId]);
       // batch.commit();
        batch.delete(DatabaseManager.user_table, where: "userId=?", whereArgs: [userId]);
        batch.delete(DatabaseManager.report_table, where: "owner_id=?", whereArgs: [userId]);
        return await batch.commit();
      },exclusive: true);
    } finally {
      _db!.close();
    }
  }

  /// 查询会员
  Future<List<User>> findMember({Pageable? pageable}) async{
    _db = await db;
    int? size;
    int? page;
    String sql = '''select * from USER u left join (select r.owner_id as ownerId,count(*) as reportQuantity from  REPORT as r group by r.owner_id) on u.userId = ownerId''';
    if(pageable != null) {
      size = pageable.size!;
      page = pageable.size! * (pageable.page! - 1);
      sql += " limit $size offset $page";
    }
    try {
      List<Map<String,dynamic>> data = await _db!.rawQuery(sql);
      return data.map((e) => fromMap(e)).toList();
    } finally {
      _db!.close();
    }
  }

  /// 根据用户手机号查询是否是新用户
  /// 返回null 代表未查到用户
  Future<User?> authenticateByPhone({required String phone}) async{
    _db = await db;
    try {
      if(phone.length != 11) {
        return Future.error("手机号格式不正确");
      }
      return await _db!.query(DatabaseManager.user_table,where: "phone=?", whereArgs: ["$phone"]).then((value) {
        if(value.isEmpty) {
          return null;
        }
        Map<String, dynamic> data = value.first;
        Logger().d("查询指定的用户：$phone",data);
        return fromMap(data);
      }); 
    } finally {
      await _db!.close();
    }
  }

  /// 保存用户
  /// 返回用户id
  Future<int> initFirstUser(User user)  async{
    _db = await db;
    try {
      user.id = DatabaseManager.generateId();
      user.nickname = generateRandomNickname();
      await _db!.insert(DatabaseManager.user_table, toMap(user));
      return user.id!;
    } finally {
      await _db!.close();
    }
  }


  static User fromMap(Map<String, dynamic> map) {
    return User(
      id: map['userId'],
      enabled: map['enabled'] == "true" ? true : false,
      openedReport: map['openedReport'],
      phone: map['phone'],
      nickname: map['nickname'],
      gender: map['gender'],
      height: map['height'],
      currentWeight: map['currentWeight'],
      targetWeight: map['targetWeight'],
      age: map['age'],
      birthday: TimeUtils.parseDate(map['birthday']),
      creationTime: TimeUtils.parseDateTime(map['creationTime']),
      reportQuantity: map['reportQuantity'],
      deviceUserId: map['userId'],
      uploaded: map['uploaded'] == 'true' ? true : false
    );
  }

  /// enabled 是String类型的，数据库没有
  static Map<String,dynamic> toMap(User user) => {
    'userId': user.id,
    'enabled': (user.enabled != null && user.enabled!) ? "true" : "false",
    'phone': user.phone,
    'nickname': user.nickname,
    'gender': user.gender,
    'height': user.height,
    'currentWeight': user.currentWeight,
    'targetWeight': user.targetWeight,
    'age': user.age,
    'birthday': TimeUtils.formatDataTime(user.birthday),
    'creationTime': TimeUtils.formatDataTime(user.creationTime),
    'reportQuantity': user.reportQuantity,
    'uploaded': (user.uploaded != null && user.uploaded!) ? 'true' : 'false'
  };

  /// 随机生成用户名
  String generateRandomNickname() {
    String nickname = "用户";
    String randomString = List.generate(6, (index) => allChars[Random().nextInt(allChars.length)]).join();
    return "$nickname$randomString";
  }
  
  /// 获取未上传的用户数据
  Future<List<User>> getunUploadedUserList() async{
    _db = await db;
    try {
      List<Map<String, dynamic>> data = await _db!.query(DatabaseManager.user_table,whereArgs: ["false"],where: "uploaded=?");
      return data.map((e) => fromMap(e)).toList();
    } finally {
      _db!.close();
    }
  }

  /// 批量更新用户表uploaded状态
 Future<void> uploadedDone(List<User> userList) async{
    _db = await db;
    try {
      final Batch batch = _db!.batch();
      userList.forEach((element) {
        batch.rawUpdate("update USER set uploaded = 'true' where USER.userId = ${element.id}");
      });
      await batch.commit(continueOnError: true);
    }finally {
      _db!.close();
    }
 }

  /// 更新体重(测试用的)
  Future<int> updateStatus({required int id}) async{
    _db = await db;
    if(id == null) {
      return Future.error("用户id不能为空");
    }
    try {
      return _db!.rawUpdate("update USER set uploaded = 'false' where USER.userId = $id");
    } finally {
      _db!.close();
    }
  }
}