part of 'snowflake_base.dart';

abstract class Config {
  factory Config(int machine, int dataCenter, int epoch) =>
      DataConfig._(machine: machine, dataCenter: dataCenter, epoch: epoch);
}

class DataConfig implements Config {
  final int machine;
  final int dataCenter;
  final int epoch;
  DataConfig._({required this.machine,required this.dataCenter,required this.epoch});
}

