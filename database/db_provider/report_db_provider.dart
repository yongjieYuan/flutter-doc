import 'package:chili/chili.dart';
import 'package:sqflite/sqflite.dart';
import 'package:yali_fitness_app/database/database_manager.dart';
import 'package:yali_fitness_app/database/db_provider/device_db_provider.dart';
import 'package:yali_fitness_app/database/db_provider/user_db_provider.dart';
import 'package:yali_fitness_app/models/model.dart';

class ReportDBProvider {
  static final ReportDBProvider _singleton = ReportDBProvider._internal();
  factory ReportDBProvider() {
    return _singleton;
  }
  ReportDBProvider._internal();

  static Database? _db;

  Future<Database> get db async {
    if (_db != null && _db!.isOpen) {
      return _db!;
    }
    _db = await DatabaseManager().db;
    return _db!;
  }

  // Future<Database> _initDB() async {
  //   Directory documentsDirectory = await getApplicationDocumentsDirectory();
  //   String path = join(documentsDirectory.path, DatabaseManager.report_table);
  //   return await openDatabase(path, version: 1, onCreate: (db, version) {
  //     return db.execute(CreateTableSqls.report_table_sql);
  //   });
  // }

  /// 保存报告
  Future<int?> saveReport({
    required Report report,
    required Device device,
    required User owner,
  }) async {
    _db = await db;
    try {
      if (owner.id == null) {
        return Future.error("报告的用户id不能为空");
      }
      report.id = DatabaseManager.generateId();
      report.creationTime = DateTime.now();
      print('报告时间；${report.creationTime}');
      report.owner = owner;
      report.device = device;
      Map<String,dynamic> data = toMap(report);
      print('转换后的数据： $data');
      await _db!.insert(DatabaseManager.report_table, toMap(report));
      return report.id;
    } finally {
      _db!.close();
    }
  }

  /// 获取报告详情
  Future<Report> get({required int id}) async{
    print('报告id: $id');
    _db = await db;
    try {
      List<Map<String, dynamic>> data = await _db!.rawQuery("select r.repId as reportId, r.*, u.userId,u.phone,u.nickname,u.gender,u.height,u.targetWeight,u.age,u.birthday,u.creationTime as u_creationTime  from REPORT r join USER as u on r.owner_id = u.userId and r.repId = $id");
      print('查询到的数据：$data');
      return fromMap(data.first);
    }catch(err){
      print('cuowu:');
      print(err);
      print(err);
      return Report();
    }finally {
      _db!.close();
    }
  }

  /// 获取收藏的报告列表
  Future<List<Report>> findFavorite(Pageable pageable) async{
    _db = await db;
    int size = pageable.size!;
    int page = pageable.size! * (pageable.page! - 1);
    try {
      List<Map<String, dynamic>> data = await _db!.rawQuery(
          '''select u.*,score,r.creationTime,fatMass,weight,r.repId as reportId,percentBodyFat,favorite,muscleMass from REPORT r inner join USER u on r.owner_id = u.userId where favorite = 'true' limit $size offset $page''');
      return data.map((e) => fromMap(e)).toList();
    } finally {
      _db!.close();
    }
  }

  /// 获取报告列表
  Future<List<Report>> getReportList(Pageable pageable) async {
    _db = await db;
    int size = pageable.size!;
    int page = pageable.size! * (pageable.page! - 1);
    try {
      List<Map<String, dynamic>> data = await _db!.rawQuery(
          '''select u.*,score,r.creationTime,fatMass,weight,r.repId as reportId,r.owner_id,percentBodyFat,favorite,muscleMass from REPORT r inner join USER u on r.owner_id = u.userId limit $size offset $page''');
      print('查询到的数据： $data');
      return data.map((e) => fromMap(e)).toList();
    } finally {
      _db!.close();
    }
  }

  /// 获取报告总数
  Future<void> getReportCount() async{
    _db = await db;
    try {
      List<Map> res = await _db!.rawQuery("select count(*) from report");
      print(res);
    } finally {
      _db!.close();
    }
  }

  /// 根据用户手机号查询报告列表
  Future<List<Report>> getReportByPhone({required String phone}) async{
    _db = await db;
    try {
      List<Map<String,dynamic>> data = await _db!.rawQuery('''select u.*, r.owner_id, r.repId as reportId ,r.score,r.creationTime, r.fatMass, r.weight, r.muscleMass, 
          r.favorite, r.percentBodyFat from USER u join REPORT r on r.owner_id = u.userId and u.phone = $phone''');
      print("查询结果");
      data.forEach((element) {
        print('时间');
        print(element['creationTime']);
      });
      return data.map((e) => fromMap(e)).toList();
    }finally {
      _db!.close();
    }
  }

  /// 根据日期范围获取报告列表
  Future<List<Report>> getReportByDateTime({required Between between}) async{
    String begin = TimeUtils.formatDataTime(between.start!)!;
    String end = TimeUtils.formatDataTime(between.end!)!;
    print('时间范围： $begin ---- $end');
    _db = await db;
    try {
      List<Map<String,dynamic>> data = await _db!.rawQuery('''select u.*, r.owner_id, r.repId as reportId ,r.score,r.creationTime, r.fatMass, r.weight, r.muscleMass,r.favorite, r.percentBodyFat 
from USER u join REPORT r on r.owner_id = u.userId where r.creationTime between "$begin" and "$end";''');
      print("查询结果");
      print(data);
      return data.map((e) => fromMap(e)).toList();
    }finally {
      _db!.close();
    }
  }

  /// 通过用户id获取报告列表
  Future<List<Report>> getReportByUserId({required int userId,required Pageable pageable}) async{
    _db = await db;
    int size = pageable.size!;
    int page = pageable.size! * (pageable.page! - 1);
    try {
      List<Map<String, dynamic>> data = await _db!.rawQuery(
          '''select u.*, r.owner_id, r.repId as reportId ,r.score,r.creationTime, r.fatMass, r.weight, r.muscleMass, 
          r.favorite, r.percentBodyFat from USER u join REPORT r on r.owner_id = $userId and u.userId = $userId limit $size offset $page;''');
      print("查询结果");
      print(data);
      return data.map((e) => fromMap(e)).toList();
    } finally {
      _db!.close();
    }
  }

  static Map<String, dynamic> toMap(Report report) => {
        'repId': report.id,
        'favorite': (report.favorite != null && report.favorite!) ? "true" : "false",
        // 'shape': report.shape?.id,
        'bodyShape': report.bodyShape,
        'score': report.score,
        'weight': report.weight,
        'weightMinValue': report.weightMinValue,
        'weightMaxValue': report.weightMaxValue,
        'leanBodyWeight': report.leanBodyWeight,
        'leanBodyWeightMinValue': report.leanBodyWeightMinValue,
        'leanBodyWeightMaxValue': report.leanBodyWeightMaxValue,
        'heartRate': report.heartRate,
        'heartRateMinValue': report.heartRateMinValue,
        'heartRateMaxValue': report.heartRateMaxValue,
        'bloodPressure': report.bloodPressure,
        'bloodPressureMinValue': report.bloodPressureMinValue,
        'bloodPressureMaxValue': report.bloodPressureMaxValue,
        'fatMass': report.fatMass,
        'fatMassMinValue': report.fatMassMinValue,
        'fatMassMaxValue': report.fatMassMaxValue,
        'muscleMass': report.muscleMass,
        'muscleMassMinValue': report.muscleMassMinValue,
        'muscleMassMaxValue': report.muscleMassMaxValue,
        'protein': report.protein,
        'proteinMinValue': report.proteinMinValue,
        'proteinMaxValue': report.proteinMaxValue,
        'inorganicSalt': report.inorganicSalt,
        'inorganicSaltMinValue': report.inorganicSaltMinValue,
        'inorganicSaltMaxValue': report.inorganicSaltMaxValue,
        'bodyMoisture': report.bodyMoisture,
        'bodyMoistureMinValue': report.bodyMoistureMinValue,
        'bodyMoistureMaxValue': report.bodyMoistureMaxValue,
        'percentBodyFat': report.percentBodyFat,
        'percentBodyFatMinValue': report.percentBodyFatMinValue,
        'percentBodyFatMaxValue': report.percentBodyFatMaxValue,
        'visceralFat': report.visceralFat,
        'visceralFatMinValue': report.visceralFatMinValue,
        'visceralFatMaxValue': report.visceralFatMaxValue,
        'waistToHipRatio': report.waistToHipRatio,
        'waistToHipRatioMinValue': report.waistToHipRatioMinValue,
        'waistToHipRatioMaxValue': report.waistToHipRatioMaxValue,
        'intracellularFluid': report.intracellularFluid,
        'intracellularFluidMinValue': report.intracellularFluidMinValue,
        'intracellularFluidMaxValue': report.intracellularFluidMaxValue,
        'extracellularFluid': report.extracellularFluid,
        'extracellularFluidMinValue': report.extracellularFluidMinValue,
        'extracellularFluidMaxValue': report.extracellularFluidMaxValue,
        'bodyMassIndex': report.bodyMassIndex,
        'bodyMassIndexMinValue': report.bodyMassIndexMinValue,
        'bodyMassIndexMaxValue': report.bodyMassIndexMaxValue,
        'totalEnergyExpenditure': report.totalEnergyExpenditure,
        'totalEnergyExpenditureMinValue': report.totalEnergyExpenditureMinValue,
        'totalEnergyExpenditureMaxValue': report.totalEnergyExpenditureMaxValue,
        'physicalAge': report.physicalAge,
        'physicalAgeMinValue': report.physicalAgeMinValue,
        'physicalAgeMaxValue': report.physicalAgeMaxValue,
        'skeletalMuscle': report.skeletalMuscle,
        'skeletalMuscleMinValue': report.skeletalMuscleMinValue,
        'skeletalMuscleMaxValue': report.skeletalMuscleMaxValue,
        'basalMetabolism': report.basalMetabolism,
        'basalMetabolismMinValue': report.basalMetabolismMinValue,
        'basalMetabolismMaxValue': report.basalMetabolismMaxValue,
        'segmentalMuscleTrunk': report.segmentalMuscleTrunk,
        'segmentalMuscleTrunkMinValue': report.segmentalMuscleTrunkMinValue,
        'segmentalMuscleTrunkMaxValue': report.segmentalMuscleTrunkMaxValue,
        'segmentalMuscleLeftArm': report.segmentalMuscleLeftArm,
        'segmentalMuscleLeftArmMinValue': report.segmentalMuscleLeftArmMinValue,
        'segmentalMuscleLeftArmMaxValue': report.segmentalMuscleLeftArmMaxValue,
        'segmentalMuscleRightArm': report.segmentalMuscleRightArm,
        'segmentalMuscleRightArmMinValue': report.segmentalMuscleRightArmMinValue,
        'segmentalMuscleRightArmMaxValue': report.segmentalMuscleRightArmMaxValue,
        'segmentalMuscleLeftLeg': report.segmentalMuscleLeftLeg,
        'segmentalMuscleLeftLegMinValue': report.segmentalMuscleLeftLegMinValue,
        'segmentalMuscleLeftLegMaxValue': report.segmentalMuscleLeftLegMaxValue,
        'segmentalMuscleRightLeg': report.segmentalMuscleRightLeg,
        'segmentalMuscleRightLegMinValue': report.segmentalMuscleRightLegMinValue,
        'segmentalMuscleRightLegMaxValue': report.segmentalMuscleRightLegMaxValue,
        'segmentalFatTrunk': report.segmentalFatTrunk,
        'segmentalFatTrunkMinValue': report.segmentalFatTrunkMinValue,
        'segmentalFatTrunkMaxValue': report.segmentalFatTrunkMaxValue,
        'segmentalFatLeftArm': report.segmentalFatLeftArm,
        'segmentalFatLeftArmMinValue': report.segmentalFatLeftArmMinValue,
        'segmentalFatLeftArmMaxValue': report.segmentalFatLeftArmMaxValue,
        'segmentalFatRightArm': report.segmentalFatRightArm,
        'segmentalFatRightArmMinValue': report.segmentalFatRightArmMinValue,
        'segmentalFatRightArmMaxValue': report.segmentalFatRightArmMaxValue,
        'segmentalFatLeftLeg': report.segmentalFatLeftLeg,
        'segmentalFatLeftLegMinValue': report.segmentalFatLeftLegMinValue,
        'segmentalFatLeftLegMaxValue': report.segmentalFatLeftLegMaxValue,
        'segmentalFatRightLeg': report.segmentalFatRightLeg,
        'segmentalFatRightLegMinValue': report.segmentalFatRightLegMinValue,
        'segmentalFatRightLegMaxValue': report.segmentalFatRightLegMaxValue,
        'boneMineralQuantity': report.boneMineralQuantity,
        'boneMineralQuantityMinValue': report.boneMineralQuantityMinValue,
        'boneMineralQuantityMaxValue': report.boneMineralQuantityMaxValue,
        'increaseWight': report.increaseWight,
        'increaseMuscleMass': report.increaseMuscleMass,
        'increaseFatMass': report.increaseFatMass,
        'targetWight': report.targetWight,
        'targetMuscleMass': report.targetMuscleMass,
        'targetFatMass': report.targetFatMass,
        'creationTime': TimeUtils.formatDataTime(report.creationTime),
        'owner_id': report.owner?.id,
        'receiver_id': report.receiver?.id,
        'device_number': report.device?.number,
        'deviceUserId': report.owner?.id,
        'uploaded': (report.uploaded != null && report.uploaded!) ? 'true' : 'false'
      };

  static Report fromMap(Map<String, dynamic> map) => Report(
      id: map['reportId'] ?? map['repId'],
      favorite: (map['favorite'] == "false" || map['favorite'] == null) ? false : true,
      bodyShape: map['bodyShape'],
      score: map['score'],
      weight: map['weight'],
      weightMinValue: map['weightMinValue'],
      weightMaxValue: map['weightMaxValue'],
      leanBodyWeight: map['leanBodyWeight'],
      leanBodyWeightMinValue: map['leanBodyWeightMinValue'],
      leanBodyWeightMaxValue: map['leanBodyWeightMaxValue'],
      heartRate: map['heartRate'],
      heartRateMinValue: map['heartRateMinValue'],
      heartRateMaxValue: map['heartRateMaxValue'],
      bloodPressure: map['bloodPressure'],
      bloodPressureMinValue: map['bloodPressureMinValue'],
      bloodPressureMaxValue: map['bloodPressureMaxValue'],
      fatMass: map['fatMass'],
      fatMassMinValue: map['fatMassMinValue'],
      fatMassMaxValue: map['fatMassMaxValue'],
      muscleMass: map['muscleMass'],
      muscleMassMinValue: map['muscleMassMinValue'],
      muscleMassMaxValue: map['muscleMassMaxValue'],
      protein: map['protein'],
      proteinMinValue: map['proteinMinValue'],
      proteinMaxValue: map['proteinMaxValue'],
      inorganicSalt: map['inorganicSalt'],
      inorganicSaltMinValue: map['inorganicSaltMinValue'],
      inorganicSaltMaxValue: map['inorganicSaltMaxValue'],
      bodyMoisture: map['bodyMoisture'],
      bodyMoistureMinValue: map['bodyMoistureMinValue'],
      bodyMoistureMaxValue: map['bodyMoistureMaxValue'],
      percentBodyFat: map['percentBodyFat'],
      percentBodyFatMinValue: map['percentBodyFatMinValue'],
      percentBodyFatMaxValue: map['percentBodyFatMaxValue'],
      visceralFat: map['visceralFat'],
      visceralFatMinValue: map['visceralFatMinValue'],
      visceralFatMaxValue: map['visceralFatMaxValue'],
      waistToHipRatio: map['waistToHipRatio'],
      waistToHipRatioMinValue: map['waistToHipRatioMinValue'],
      waistToHipRatioMaxValue: map['waistToHipRatioMaxValue'],
      intracellularFluid: map['intracellularFluid'],
      intracellularFluidMinValue: map['intracellularFluidMinValue'],
      intracellularFluidMaxValue: map['intracellularFluidMaxValue'],
      extracellularFluid: map['extracellularFluid'],
      extracellularFluidMinValue: map['extracellularFluidMinValue'],
      extracellularFluidMaxValue: map['extracellularFluidMaxValue'],
      bodyMassIndex: map['bodyMassIndex'],
      bodyMassIndexMinValue: map['bodyMassIndexMinValue'],
      bodyMassIndexMaxValue: map['bodyMassIndexMaxValue'],
      totalEnergyExpenditure: map['totalEnergyExpenditure'],
      totalEnergyExpenditureMinValue: map['totalEnergyExpenditureMinValue'],
      totalEnergyExpenditureMaxValue: map['totalEnergyExpenditureMaxValue'],
      physicalAge: map['physicalAge'],
      physicalAgeMinValue: map['physicalAgeMinValue'],
      physicalAgeMaxValue: map['physicalAgeMaxValue'],
      skeletalMuscle: map['skeletalMuscle'],
      skeletalMuscleMinValue: map['skeletalMuscleMinValue'],
      skeletalMuscleMaxValue: map['skeletalMuscleMaxValue'],
      basalMetabolism: map['basalMetabolism'],
      basalMetabolismMinValue: map['basalMetabolismMinValue'],
      basalMetabolismMaxValue: map['basalMetabolismMaxValue'],
      segmentalMuscleTrunk: map['segmentalMuscleTrunk'],
      segmentalMuscleTrunkMinValue: map['segmentalMuscleTrunkMinValue'],
      segmentalMuscleTrunkMaxValue: map['segmentalMuscleTrunkMaxValue'],
      segmentalMuscleLeftArm: map['segmentalMuscleLeftArm'],
      segmentalMuscleLeftArmMinValue: map['segmentalMuscleLeftArmMinValue'],
      segmentalMuscleLeftArmMaxValue: map['segmentalMuscleLeftArmMaxValue'],
      segmentalMuscleRightArm: map['segmentalMuscleRightArm'],
      segmentalMuscleRightArmMinValue: map['segmentalMuscleRightArmMinValue'],
      segmentalMuscleRightArmMaxValue: map['segmentalMuscleRightArmMaxValue'],
      segmentalMuscleLeftLeg: map['segmentalMuscleLeftLeg'],
      segmentalMuscleLeftLegMinValue: map['segmentalMuscleLeftLegMinValue'],
      segmentalMuscleLeftLegMaxValue: map['segmentalMuscleLeftLegMaxValue'],
      segmentalMuscleRightLeg: map['segmentalMuscleRightLeg'],
      segmentalMuscleRightLegMinValue: map['segmentalMuscleRightLegMinValue'],
      segmentalMuscleRightLegMaxValue: map['segmentalMuscleRightLegMaxValue'],
      segmentalFatTrunk: map['segmentalFatTrunk'],
      segmentalFatTrunkMinValue: map['segmentalFatTrunkMinValue'],
      segmentalFatTrunkMaxValue: map['segmentalFatTrunkMaxValue'],
      segmentalFatLeftArm: map['segmentalFatLeftArm'],
      segmentalFatLeftArmMinValue: map['segmentalFatLeftArmMinValue'],
      segmentalFatLeftArmMaxValue: map['segmentalFatLeftArmMaxValue'],
      segmentalFatRightArm: map['segmentalFatRightArm'],
      segmentalFatRightArmMinValue: map['segmentalFatRightArmMinValue'],
      segmentalFatRightArmMaxValue: map['segmentalFatRightArmMaxValue'],
      segmentalFatLeftLeg: map['segmentalFatLeftLeg'],
      segmentalFatLeftLegMinValue: map['segmentalFatLeftLegMinValue'],
      segmentalFatLeftLegMaxValue: map['segmentalFatLeftLegMaxValue'],
      segmentalFatRightLeg: map['segmentalFatRightLeg'],
      segmentalFatRightLegMinValue: map['segmentalFatRightLegMinValue'],
      segmentalFatRightLegMaxValue: map['segmentalFatRightLegMaxValue'],
      boneMineralQuantity: map['boneMineralQuantity'],
      boneMineralQuantityMinValue: map['boneMineralQuantityMinValue'],
      boneMineralQuantityMaxValue: map['boneMineralQuantityMaxValue'],
      increaseWight: map['increaseWight'],
      increaseMuscleMass: map['increaseMuscleMass'],
      increaseFatMass: map['increaseFatMass'],
      targetWight: map['targetWight'],
      targetMuscleMass: map['targetMuscleMass'],
      targetFatMass: map['targetFatMass'],
      creationTime: TimeUtils.parseDateTime(map['creationTime']),
      deviceUserId: map['deviceUserId'],
      owner: UserDBProvider.fromMap({
              "birthday": map["birthday"],
              "gender": map["gender"],
              "phone": map["phone"],
              "nickname": map["nickname"],
              "userId": (map["userId"]),
              "age": map["age"],
              "height": map["height"]
            }),
      device: map['device_number'] == null ? null : DeviceDBProvider.fromMap({"number":map['device_number']}),/// 查询的时候需要把设备的number column 重命名为device_number
      uploaded: map['uploaded'] == "true" ? true : false);

  /// 获取未上传的报告
  Future<List<Report>> getunUploadedReportList() async{
    _db = await db;
    try {
      List<Map<String,dynamic>> data = await _db!.query(DatabaseManager.report_table,where: "uploaded=?",whereArgs: ['false']);
      print('未上传报告：${data.length}');
      print(data);
      return data.map((e) => fromMap(e)).toList();
    } finally {
      await _db!.close();
    }
  }

  /// 上传完报告
 Future<void> uploadReportDone(List<Report> data) async {
    _db = await db;
    try {
      final Batch batch = _db!.batch();
      data.forEach((element) {
        batch.rawUpdate("update REPORT set uploaded = 'true' where REPORT.repId = ${element.id};");
      });
      await batch.commit(continueOnError: true).then((value) {
        value.forEach((element) {
          print(element);
        });
      }).catchError((err){
        print('报错：$err');
      });
      print('报告更新成功');
    } finally {
      await _db!.close();
    }
 }

 /// 获取某个人的报告列表
 Future<List<Report>> getOwnerReportList({required User owner,required Pageable pageable}) async{
    _db = await db;
    try {
      int size = pageable.size!;
      int page = pageable.size! * (pageable.page! - 1);
      List<Map<String,dynamic>> data = await _db!.query(DatabaseManager.report_table,whereArgs: [owner.id],where: "owner_id=?",limit: size,offset: page);
      return data.map((e) => fromMap(e)).toList();
    }finally {
      await _db!.close();
    }

 }



}
