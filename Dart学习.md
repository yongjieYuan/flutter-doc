# Dart学习

## （一）Duration是有正负之分

### 1、获取常用的参数：

```dart
import 'Test/Test.dart';

//Duration类型的使用demo
main() {
   //定义一个Duration
   Duration stim = Duration(
       days: 0, hours: 1, minutes: 0,
       seconds: 30, milliseconds: 000, microseconds: 00
   );
   //常用操作
   print("获取天数值：${stim.inDays}"); //获取days的值：0
   print("获取总的秒数值:${stim.inSeconds}"); //返回总的秒数，整个时间转换为秒数
   print("获取小时数值：${stim.inMinutes}"); //只会返回小时的值，小时后面的分钟会被忽略
   print(stim.toString()); //转换为字符串
   print(stim.isNegative); //返回此“Duration”是否为负
   print(stim.abs()); //获取Duration绝对值:abs()
}
```

2、比较两个Duration类型的大小，可以应用于比较两个视频的时间长短等等。

```dart
import 'Test/Test.dart';

main() {
   //定义一个Duration
   Duration stim = Duration(
       days: 0, hours: 1, minutes: 0,
       seconds: 30, milliseconds: 000, microseconds: 00
   );
    //定义一个Duration
   Duration stim1=Duration(
      days: 0,hours: 0,minutes: 0, seconds:30,milliseconds: 000,microseconds: 00
   );
   //将stim与stim1比较，等于则返回0，大于返回1，小于返回-1
   print(stim.compareTo(stim1));  //结果：1
}
```

### 3、Duration类型的常用比较，如两个Duration相加，相减等。

```dart
import 'Test/Test.dart';

//Duration类型的使用demo
main() {
   //定义一个Duration
   Duration stim = Duration(
       days: 0, hours: 0, minutes: 0,
       seconds: 30, milliseconds: 000, microseconds: 00
   );
   //定义一个Duration
    Duration stim1=Duration(
      days: 0,hours: 0,minutes: 0, seconds:30,milliseconds: 000,microseconds: 00
   );

   print(stim+stim1); //两个Duration相加，结果：0:01:00.000000
   print(stim-stim1); //两个Duration相减，结果：0:00:00.000000
   print(stim*2); //乘 ,结果：0:01:00.000000
   print(stim ~/100); //除，注意有个波浪号~,结果：0:00:00.003000
}
```

### 4、Duration类型截取指定部份显示。

通过上面的示例不难看出一个问题就是Duration显示的时间跨度是带有小数点的，如（0:01:00.000000）。而且显示的是小数点后面6位，在实际的应用中，我们只需要显示时:分: 秒的格式（如：0:01:30）。或者像视频进度条里显示的格式（01:30）。那么如何实现这种效果呢？实现方式如下

```dart
 获取Duration-->转为字符串-->利用字符串的截取方法截取指定的位置字符串。
     //Duration类型的使用demo
main() {
   //定义一个Duration
   Duration stim = Duration(
       days: 0, hours: 0, minutes: 60, seconds: 30, milliseconds: 40, microseconds: 50
   );
   print(stim); //结果：1:00:30.040050
   String str=stim.toString(); //原始数据转为字符串
   print(str.substring(2,7)); //截取指定位置的数据，结果：00:30
   print(str.substring(0,7)); //截取指定位置的数据，结果：1:00:30
}
```

## （二）Timer定时器

```dart
import 'dart:async';
```

```dart
Timer(
    Duration duration,
    void callback()
)
```

### 构造方法：

```dart
const timeout = const Duration(seconds: 5);
print('currentTime ='+DateTime.now().toString());
Timer(timeout, () {
    //5秒后执行
    print('after 5s Time ='+DateTime.now().toString());
});
```

**Timer.periodic**执行多次回调：
回调多次的定时器用法和回调一次的差不多，区别有下面两点：
  1、API 调用不同
  2、需要手动取消，否则会一直回调，因为是周期性的

```dart
z`t count = 0;
const period = const Duration(seconds: 1);
print('currentTime='+DateTime.now().toString());
Timer.periodic(period, (timer) {
  //到时回调
  print('afterTimer='+DateTime.now().toString());
  count++;
  if (count >= 5) {
    //取消定时器，避免无限回调
    timer.cancel();
    timer = null;
  }
});

```

```dart
import 'dart:async';

main() {
  int count = 0;
  Timer timer;
  Timer.periodic(Duration(seconds: 1), (timer) {
    if (count == 5) {
      timer.cancel();
      return;
    }
    count++;
    print(count);
  });
}

```

## （三）时间转换

```dart
  ///时间转换：
  void transformTime(int times) {
    int date = 0, hour = 0, minute = 0, second = 0;
    if (times > 0) {
      date = times ~/ 86400;
      hour = ((times - 86400 * date) ~/ 3600);
      minute = (times - 86400 * date - hour * 3600) ~/ 60;
      second =
          ((times - 86400 * date - hour * 3600 - minute * 60) % 60).toInt();
    }
    if (times < 60) {
      timer = times < 10 ? ('00:' + '0${second}') : ('00:' + '${second}');
    } else if (times > 3600) {
      timer = '${hour}:' + '${minute}:' + '${second}';
    }
  }
```

## （四）字符串

[Dart 的 String 字符串的常用方法](https://blog.csdn.net/qq_42351033/article/details/120721078?spm=1001.2014.3001.5502)

