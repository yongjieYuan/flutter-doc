class CreateTableSqls {
  /// 创建用户表
  static String user_table_sql = '''CREATE TABLE USER(
    userId BIGINT(20) NOT NULL,
    enabled TEXT,
    phone TEXT NOT NULL,
    nickname TEXT,
    gender TEXT,
    height INTEGER,
    currentWeight REAL,
    targetWeight REAL,
    age INTEGER,
    birthday TEXT,
    creationTime TEXT,
    reportQuantity INTEGER,
    uploaded TEXT,
    primary key(userId, phone));''';

  /// 体型
  // static String bodyshape_table_sql = '''CREATE TABLE BODY_SHAPE(
  //   id BIGINT(20) primary key NOT NULl,
  //   name TEXT,
  //   maleImage TEXT,
  //   femaleImage TEXT,
  //   minFatMass REAL,
  //   maxFatMass REAL,
  //   minMuscleMass REAL,
  //   maxMuscleMass REAL);''';

  /// 机器
  static String device_table_sql = '''CREATE TABLE DEVICE(
    deviceId BIGINT(20) NOT NULl,
    enabled TEXT,
    activated TEXT,
    number TEXT NOT NULL,
    name TEXT,
    phone TEXT,
    brand TEXT,
    province TEXT,
    city TEXT,
    district TEXT,
    address TEXT,
    activationTime TEXT,
    creationTime TEXT,
    primary key(deviceId, number));''';

  /// 报告
  static String report_table_sql = ''' CREATE TABLE REPORT(
    repId BIGINT(20) primary key NOT NULL,
    favorite TEXT,
    shape_id BIGINT(20),
    bodyShape TEXT,
    score INTEGER,
    weight REAL,
    weightMinValue REAL,
    weightMaxValue REAL,
    leanBodyWeight REAL,
    leanBodyWeightMinValue REAL,
    leanBodyWeightMaxValue REAL,
    heartRate INTEGER,
    heartRateMinValue REAL,
    heartRateMaxValue REAL,
    bloodPressure INTEGER,
    bloodPressureMinValue REAL,
    bloodPressureMaxValue REAL,
    fatMass REAL,
    fatMassMinValue REAL,
    fatMassMaxValue REAL,
    muscleMass REAL,
    muscleMassMinValue REAL,
    muscleMassMaxValue REAL,
    protein REAL,
    proteinMinValue REAL,
    proteinMaxValue REAL,
    inorganicSalt REAL,
    inorganicSaltMinValue REAL,
    inorganicSaltMaxValue REAL,
    bodyMoisture REAL,
    bodyMoistureMinValue REAL,
    bodyMoistureMaxValue REAL,
    percentBodyFat REAL,
    percentBodyFatMinValue REAL,
    percentBodyFatMaxValue REAL,
    visceralFat REAL,
    visceralFatMinValue REAL,
    visceralFatMaxValue REAL,
    waistToHipRatio REAL,
    waistToHipRatioMinValue REAL,
    waistToHipRatioMaxValue REAL,
    intracellularFluid REAL,
    intracellularFluidMinValue REAL,
    intracellularFluidMaxValue REAL,
    extracellularFluid REAL,
    extracellularFluidMinValue REAL,
    extracellularFluidMaxValue REAL,
    bodyMassIndex REAL,
    bodyMassIndexMinValue REAL,
    bodyMassIndexMaxValue REAL,
    totalEnergyExpenditure REAL,
    totalEnergyExpenditureMinValue REAL,
    totalEnergyExpenditureMaxValue REAL,
    physicalAge REAL,
    physicalAgeMinValue REAL,
    physicalAgeMaxValue REAL,
    skeletalMuscle REAL,
    skeletalMuscleMinValue REAL,
    skeletalMuscleMaxValue REAL,
    basalMetabolism REAL,
    basalMetabolismMinValue REAL,
    basalMetabolismMaxValue REAL,
    segmentalMuscleTrunk REAL,
    segmentalMuscleTrunkMinValue REAL,
    segmentalMuscleTrunkMaxValue REAL,
    segmentalMuscleLeftArm REAL,
    segmentalMuscleLeftArmMinValue REAL,
    segmentalMuscleLeftArmMaxValue REAL,
    segmentalMuscleRightArm REAL,
    segmentalMuscleRightArmMinValue REAL,
    segmentalMuscleRightArmMaxValue REAL,
    segmentalMuscleLeftLeg REAL,
    segmentalMuscleLeftLegMinValue REAL,
    segmentalMuscleLeftLegMaxValue REAL,
    segmentalMuscleRightLeg REAL,
    segmentalMuscleRightLegMinValue REAL,
    segmentalMuscleRightLegMaxValue REAL,
    segmentalFatTrunk REAL,
    segmentalFatTrunkMinValue REAL,
    segmentalFatTrunkMaxValue REAL,
    segmentalFatLeftArm REAL,
    segmentalFatLeftArmMinValue REAL,
    segmentalFatLeftArmMaxValue REAL,
    segmentalFatRightArm REAL,
    segmentalFatRightArmMinValue REAL,
    segmentalFatRightArmMaxValue REAL,
    segmentalFatLeftLeg REAL,
    segmentalFatLeftLegMinValue REAL,
    segmentalFatLeftLegMaxValue REAL,
    segmentalFatRightLeg REAL,
    segmentalFatRightLegMinValue REAL,
    segmentalFatRightLegMaxValue REAL,
    boneMineralQuantity REAL,
    boneMineralQuantityMinValue REAL,
    boneMineralQuantityMaxValue REAL,
    increaseWight REAL,
    increaseMuscleMass REAL,
    increaseFatMass REAL,
    targetWight REAL,
    targetMuscleMass REAL,
    targetFatMass REAL,
    creationTime TEXT,
    owner_id BIGINT(20) NOT NULL,
    receiver_id BIGINT(20),
    device_number TEXT,
    deviceUserId BIGINT(20),
    uploaded TEXT);''';

  /// 收藏
  static String favorite_table_sql = '''CREATE TABLE FAVORITE(
  favorId BIGINT(20) primary key NOT NULL,
  report_id BIGINT(20),
  user_id BIGINT(20),
  device_id BIGINT(20));''';

  static String operation_step_sql = '''CREATE TABLE OPERATION(
   id INTEGER primary key NOT NULL,
   position INTEGER,
   name TEXT,
   description TEXT,
   image TEXT,
   audio TEXT);''';

  static String inspectionTable ='''CREATE TABLE INSPECTION(
   id INTEGER primary key NOT NULL,
   name TEXT,
   content TEXT
   );''';

  static String musicTable = '''CREATE TABLE MUSIC(
  id INTEGER primary key NOT NULL,
  title TEXT,
  file TEXT
  );
  ''';
}
