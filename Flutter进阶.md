## 1.provider

https://blog.csdn.net/lpfasd123/article/details/101573980

## 2.InheritedWidget

```dart

```

## 3.provider

Provider，Google 官方推荐的一种 Flutter 页面状态管理组件，它的实质其实就是对 InheritedWidget 的包装，使它们更易于使用和重用。

- **创建一个ChangeNotifier**

  ```dart
  class Model1 extends ChangeNotifier {
    int _count = 1;
    int get value => _count;
    set value(int value) {
      _count = value;
      notifyListeners();
    }
  }
  ```

  

- **创建一个ChangeNotifier（方式一）**

  这里通过 ChangeNotifierProvider 的 create 把 ChangeNotifier（即 Model1）建立联系，作用域的范围在 child 指定的 MaterialApp，这里我们将 SingleStatsView 作为首页，SingleStatsView 里面使用了 Model1 作为数据源。需要注意的是，不要把所有状态的作用域都放在 MaterialApp，根据实际业务需求严格控制作用域范围，全局状态多了会严重影响应用的性能。

  ```dart
  return ChangeNotifierProvider(
        create: (context) {
          return Model1();
        },
        child: MaterialApp(
          theme: ArchSampleTheme.theme,
          home: SingleStatsView(),
        ),
  );
  
  class SingleStatsView extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              color: Colors.blue,
              child: Text('Model1 count++'),
              onPressed: () {
                Provider.of<Model1>(context, listen: false).count++;
              },
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text('Model count值变化监听',
                  style: Theme.of(context).textTheme.title),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text('Model1 count:${Provider.of<Model1>(context).count}',
                  style: Theme.of(context)
                      .textTheme
                      .subhead
                      .copyWith(color: Colors.green)),
            ),
          ],
        ),
      );
    }
  }
  ```

- **创建一个ChangeNotifierProvider.value（方式二）**

  ```dart
  return ChangeNotifierProvider.value(
          value: Model1(),
          child: MaterialApp(
            theme: ArchSampleTheme.theme,
            home: SingleStatsView(),
       ));
  ```

- **在页面中监听状态变更，其他使用方式**

  ValueListenableBuilder


# Stream 的相关案例
```dart
import 'dart:async';

class DataBloc {

  factory DataBloc() => _instance;

  static final DataBloc _instance = DataBloc._init();

  ///定义一个Controller
  StreamController<String> _dataController = StreamController.broadcast(
    onListen: (){
      print('databloc listen');
    },
    onCancel: (){
      print('databloc cancel');
    }
  );
  ///获取 StreamSink 做 add 入口
  StreamSink<String> get dataSink => _dataController.sink;
  ///获取 Stream 用于监听
  Stream<String> get dataStream => _dataController.stream;
  ///事件订阅对象
  late StreamSubscription _dataSubscription;

  DataBloc._init() {
    ///监听事件
    _dataSubscription = dataStream.listen((value){
      ///do change
    });

  }

  close() {
    ///关闭
    _dataSubscription.cancel();
    _dataController.close();
  }
}
```

```dart
import 'dart:async';
import 'dart:async';
import 'dart:io';
import 'package:logger/logger.dart';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';

var logger = Logger(
  printer: PrettyPrinter(methodCount: 1, printEmojis: false, colors: false),
);
/// 基于定位设计的Bloc
class LocationBloc {
  /// 实现单例模式
  factory LocationBloc() => _instance;

  static final LocationBloc _instance = LocationBloc._init();

  // static LocationBloc get instance => _instance;

  LocationBloc._init() {
    if (Platform.isIOS) {
      _requestAccuracyAuthorization();
    }
    ///监听事件
    _dataSubscription = _locationPlugin.onLocationChanged().listen((Map<String, Object>? result) {
        _dataController.sink.add(result);
    });
    _startLocation();


  }

  static AMapFlutterLocation _locationPlugin = new AMapFlutterLocation();
  ///定义一个Controller
  StreamController<Map<String, Object>?> _dataController = StreamController.broadcast();
  ///获取 StreamSink 做 add 入口
  // StreamSink<List<String>> get _dataSink => _dataController.sink;
  ///获取 Stream 用于监听
  Stream<Map<String, Object>?> get dataStream => _dataController.stream;
  ///事件订阅对象
  late StreamSubscription _dataSubscription;

  ///设置定位参数
  static void _setLocationOption() {
    if (null != _locationPlugin) {
      AMapLocationOption locationOption = new AMapLocationOption();

      ///是否单次定位
      locationOption.onceLocation = false;

      ///是否需要返回逆地理信息
      locationOption.needAddress = true;

      ///逆地理信息的语言类型
      locationOption.geoLanguage = GeoLanguage.DEFAULT;

      locationOption.desiredLocationAccuracyAuthorizationMode =
          AMapLocationAccuracyAuthorizationMode.ReduceAccuracy;

      locationOption.fullAccuracyPurposeKey = "AMapLocationScene";

      ///设置Android端连续定位的定位间隔(源码里面默认应该是2秒)
      locationOption.locationInterval = 10000;

      ///设置Android端的定位模式<br>
      ///可选值：<br>
      ///<li>[AMapLocationMode.Battery_Saving]</li>
      ///<li>[AMapLocationMode.Device_Sensors]</li>
      ///<li>[AMapLocationMode.Hight_Accuracy]</li>
      locationOption.locationMode = AMapLocationMode.Hight_Accuracy;

      ///设置iOS端的定位最小更新距离<br>
      locationOption.distanceFilter = -1;

      ///设置iOS端期望的定位精度
      /// 可选值：<br>
      /// <li>[DesiredAccuracy.Best] 最高精度</li>
      /// <li>[DesiredAccuracy.BestForNavigation] 适用于导航场景的高精度 </li>
      /// <li>[DesiredAccuracy.NearestTenMeters] 10米 </li>
      /// <li>[DesiredAccuracy.Kilometer] 1000米</li>
      /// <li>[DesiredAccuracy.ThreeKilometers] 3000米</li>
      locationOption.desiredAccuracy = DesiredAccuracy.Best;

      ///设置iOS端是否允许系统暂停定位
      locationOption.pausesLocationUpdatesAutomatically = false;

      ///将定位参数设置给定位插件
      _locationPlugin.setLocationOption(locationOption);
    }
  }

  ///获取iOS native的accuracyAuthorization类型
  static void _requestAccuracyAuthorization() async {
    AMapAccuracyAuthorization currentAccuracyAuthorization =
    await _locationPlugin.getSystemAccuracyAuthorization();
    if (currentAccuracyAuthorization ==
        AMapAccuracyAuthorization.AMapAccuracyAuthorizationFullAccuracy) {
      print("精确定位类型");
    } else if (currentAccuracyAuthorization ==
        AMapAccuracyAuthorization.AMapAccuracyAuthorizationReducedAccuracy) {
      print("模糊定位类型");
    } else {
      print("未知定位类型");
    }
  }

  ///开始定位
  static void _startLocation() {
    if (null != _locationPlugin) {
      ///开始定位之前设置定位参数
      _setLocationOption();
      _locationPlugin.startLocation();
    }
  }

  close() {
    ///关闭
    logger.d('移除定位订阅');
    _dataSubscription.cancel();
    _dataController.close();
  }
}

```

文章：https://cloud.tencent.com/developer/article/1511980

  https://cloud.tencent.com/developer/article/1610790
```dart
class StateSubject {
  static final StateSubject _instance = StateSubject._();

  factory StateSubject() => StateSubject._instance;

  StreamController<int> streamController;

  StateSubject._() {
    streamController = StreamController.broadcast();
  }

  void update(int num) {
    streamController.sink.add(num);
  }
}
```