# Flutter 学习

## 1.2021/11/17

肖：

微信登录讲解；

----

Flutter 项目：

android / build.gradle

```dart
控制gradle版本
dependencies {
        classpath 'com.android.tools.build:gradle:4.0.1'
    }
```

android/gradle.properties

```dart
设置AndroidX
    android.useAndroidX=true
```

android/gradle/wrapper/gradle-wrapper.properties

控制gradle下载路径、版本

```dart
distributionUrl=https\://services.gradle.org/distributions/gradle-6.1.1-all.zip
```

## 2.[flutter项目中闪退问题的分析与解决方案](https://blog.csdn.net/sdta25196/article/details/107102683)

## 3.flutter  Chili框架中，Locale('zh')  == Locale('zh') 为true

Locale是个对象类型，虽然传参相同，但实例出来的对象应该是不同的，所以正常来说不相等。但是按照标题的写法是相等的，Locale源码中有复写“==”的代码。好像是只比较languageCode的值，所以传参相同就会想相等。

## 4.关于Provider

1、[Flutter 状态管理(Provider)](https://juejin.cn/post/6940814394234241038)

## 5.关于Provider

关于版本的相关插件：

Package_info

1.0.0 + 1

version + buildNumber

版本名称 + 版本号

如果软件上架后，app每次打包一次，版本号就需要+1，版本名称可以不用变

++++

# 入门过程：



## 2021.8.3

快速浏览dart，flutter相关文档，接触项目实践。（X）----没看懂

### 1、在Dart中，数组等于列表list

var l1= [ ]
var l1 = <String>['','']
List list = new List( )

+ list 属性：

  ```dart
  length,isEmpty,isNotEmpty,reversed(翻转)list.add(val) // 添加元素
  list.remove(val) // 移除对应的第一个元素
  list.removeAt(index) // 移除对应索引号的元素
  list.fillRange(start, end, val) // 将索引号 start 至 (end-1)的值替换成val
  list.getRange(start, end) // 获取start  至 （end-1）之间的元素
  list.contains(val) // list是否包含val，返回布尔值
  list.indexOf(val) // 返回第一个val的索引值
  list.indexWhere((test) => test == 5); //从前往后查找，返回数组中满足 test==5的第一个元素的索引
  list.lastIndexWhere ((test) => test == 5)；//从后往前查找，返回数组中满足 test==5的第一个元素的索引
  list.sort() // 排序  可传递一个函数 类似js的sort； 从小到大：sort((a ,b) => a -b ) ; 从大到小：sort((a,b) => b-a)；
  list.shuffle(); // 洗牌（打乱顺序）
  list.sublist(start, end); //截取list，从索引号start -  (end-1)，返回截取的子list
  list1 + list2 //可拼接两个(多个) list
  ```

  

### 2、Map

```dart
var map = {'apple': 'red', 'peach': 'pink'};
var map2 = {'apple': 'red', 'peach': 'pink'}; //不可变

//构造创建
var map3 =  new Map();

map.keys // 输出所有key
map.values // 输出所有value

map.containsKey("first") // 返回布尔值, 是否包含对应的key
map.containsValue("C") // 返回布尔值, 是否包含对应的value

map.remove(key) // 移除对应的key
```



### 3、set几种属性

常用方法：

```dart
名称	说明
addAll	添加
contains	查询单个
containsAll	查询多个
difference	集合不同
intersection	交集
union	联合
lookup	按对象查询到返回对象
remove	删除单个
removeAll	删除多个
clear	清空
firstWhere	按条件正向查询
lastWhere	按条件反向查询
removeWhere	按条件删除
retainAll	只保留几个
retainWhere	按条件只保留几个
```

### 4、常见操作符

```dart
?.    // 它的意思是左边如果为空返回 null，否则返回右边的值。
??    // AA ?? "9999" 如果AA为空，返回999
??=   // AA ??= "999" 表示如果 AA 为空，给 AA 设置成 999
```

## 2021.8.4

入门dart，flutter，可以上手简单的案例以及实操。

dart 中的对象操作符

？ 条件运算符
as 类型转换
is 类型判断
..  级联操作（连缀）

## 2021.8.5

学习flutter,熟悉chili框架;

MaterialApp
scaffold
StatefulWidget和State是单独的对象这两种类型的对象具有不同的生命周期： Widget是临时对象，用于构建当前状态下的应用程序，而State对象在多次调用build()之间保持不变，允许它们记住信息(状态)。



## 2021.8.6

熟悉flutter组建，公司框架，学会事件传递，生命周期，路由等知识，看完flutter中文文档，尝试制作简单的案例。

```dart
Nav.push((context) => RegisterScreen(i: 1,)).then((value){ });  // 打开新的页面， then代表：新的页面关闭后，接收来自新页面传的参数
Nav.pushReplacement((context) => null)  // 关闭当前页，打开新的页面
Nav.pushAndRemoveAll((context) => null)  // 关闭所有页面， 打开新的页面
Nav.pop('1111');   //关闭当前页面
```

## 8.9

完成‘紫鲸书苑’首页，商品详情，和‘个人中心’模块

问题：‘紫鲸书苑’的勾选，UI上的切图要下载几个大小的

EdgeInsets.only(top: MediaQuery.of(context).padding.top) // 屏幕信息

## 8.10

完成‘紫鲸书苑’剩余内容

有关背景图片： https://www.cnblogs.com/qianxiaox/p/14025693.html
问题：RenderFlex children have non-zero flex but incoming height constraints are unbounded.

## 8.11

完成‘紫鲸书苑’剩余内容
有时间再修改主管提出的问题，不需要提出来的类写一起即可

flutter-swiper详解：https://blog.csdn.net/u011272795/article/details/82776861

① 登录页 整体一个container, center包裹或者align

② 超出定位的话，就用container，试着把外层的Positioned去掉

③ 按钮撑满父元素, SizedBox.expand( ) ；Expended是用来撑满父元素的，所以一般外层要有个高度，否则无法得知撑满多少高度，会报错，尤其是在Column布局中；一般搭配epxend中嵌套listView

④ 自定义dialog以及路由之间传值

⑤ Center  和 Align 似乎只对行内元素有用

⑥ 可以把 flutter-swiper 中的分页器封装出来

⑦ 底部固定按钮 可以用bottomNavgationBar

⑧ 圆角图片外层可以套个ClipRRect

⑨ 初始化TextButton的样式:

```dart
TextButton.styleFrom(
                        primary: Colors.white,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: EdgeInsets.zero,
                        minimumSize: Size(0, 0)
                      ),
```

## 8.12

完成 紫鲸书苑项目，并完成优化！

封装的组件方法外层需要return

Container 中嵌套column 无法撑开宽度？？？？？？ 但是加个Row就可以

## 2021.8.17

```dart
1、阴影设置：          boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0.0, 15.0), //阴影xy轴偏移量
                            blurRadius: 15.0, //阴影模糊程度
                            spreadRadius: 1.0 //阴影扩散程度
                            )
                      ]),
```

## 2021.8.21

https://www.jianshu.com/p/e753012ba245
使用 ListWheelScrollView 搭配FixedExtentScrollPhysics属性可实现滚动的值具有吸附的效果

## 2021.8.25

碰到这个问题记得观察是否有类冲突：Try using 'as prefix' for one of the import directives, or hiding the name from all but one of the imports.

## 2021.8.31

https://www.cnblogs.com/dengxiaoning/p/11870974.html 关于性能，渲染的讲解

1、Widget 大部分时候，其实只是轻量级的配置，对于性能问题，你更需要关心的是 Clip 、Overlay 、透明合成等行为，因为它们会需要产生 saveLayer 的操作，因为 saveLayer 会清空GPU绘制的缓存。

ListView 不更新。但是使用add放即可，有点类似vue
我们直接把List换一个引用，创建一个新的List。

++++

获取版本信息

dependencies:
  package_info: ^0.4.0+4

 PackageInfo packageInfo = await PackageInfo.fromPlatform();

    //APP名称
    String appName = packageInfo.appName;
    //包名
    String packageName = packageInfo.packageName;
    //版本名
    String  version = packageInfo.version;
    //版本号
    String buildNumber = packageInfo.buildNumber;

  print("$appName=$packageName=$version=$buildNumber");

Android：
android文件下的local.properties 文件。在正式上架之前，需要手动在这个地方修改版本信息；获取版本信息的插件也是从这个地方获取的。

++++

碰到类似的问题，通过重启as试一下：
could not download builder-3.3.1.jar (com.android.tools.build:builder:3.3.1)

listview 嵌套gridview ，gridview 设置shrinkWrap: true; 不滚动

++++

2021.9.1
使用smartrefresh滚动，可使用其控制器的方法控制底部显示无更多内容，_controller.xxxx

++++

2021.9.2
踩坑：https://www.cnblogs.com/ljx20180807/p/12200503.html

++++

## 关于stream:

1. stream可以接收另一个stream

2. ```dart
   1. // 初始化一个单订阅的Stream controller
        final StreamController ctrl = StreamController();
   
     // 初始化一个监听
   
     final StreamSubscription subscription = ctrl.stream.listen((data) => print('$data'));
   
     // 往Stream中添加数据
   ctrl.sink.add('my name');
     ctrl.sink.add(1234);
     ctrl.sink.add({'a': 'element A', 'b': 'element B'});
   
   
     // StreamController用完后需要释放
   
     ctrl.close();
   ```

3. ```dart
   1. StreamTransformer
   
    // 初始化一个int类型的广播Stream controller
     final StreamController<int> ctrl = StreamController<int>.broadcast();
   
     // 初始化一个监听，同时通过transform对数据进行简单处理
     final StreamSubscription subscription = ctrl.stream
                             .where((value) => (value % 2 == 0))
                             .listen((value) => print('$value'));
   
     // 往Stream中添加数据
     for(int i=1; i<11; i++){
       ctrl.sink.add(i);
     }
   ```

4. ```dart
   StreamBuilder
   StreamBuilder<T>(
       key: ...可选...
       stream: ...需要监听的stream...
       initialData: ...初始数据，否则为空...
       builder: (BuildContext context, AsyncSnapshot<T> snapshot){
           if (snapshot.hasData){
               return ...基于snapshot.hasData返回的控件
           }
           return ...没有数据的时候返回的控件
       },
   )
   ```

   git clone 报错： https://www.cnblogs.com/setout/p/11320383.html

   ++++

   ```dart
   /// 时间类型：
   
   new DateTime( )
   new DateTime( ).now( )
   
   /// 创建UTC时间：new DateTime.utc(2019, 10, 10, 9, 30);
   /// 解析时间：new DateTime.parse( )
   /// 时间增减量：
   var d1 = new DateTime.now( )
   d1.add(new Duration(minutes: 5) ) /// 加五分钟
   
   var d2 = new DateTime.now( )
   
   /// 时间差：
   var difference = d1.difference( d2 )
   difference.inDays // 相差的天数
   difference.inHours // 相差的小时
   
   /// 时间戳
   var now = new DateTime.now();
   print(now.millisecondsSinceEpoch);//单位毫秒，13位时间戳
   print(now.microsecondsSinceEpoch);//单位微秒,16位时间戳
   ```

   ++++

   如果页面初始化时运行了动画，查看页面初始化中有无controller.forward

   ++++

   Execution failed for task ':tobias:compileDebugKotlin'.
   如果报了有关kotlin版本的问题
   在android 下的 build 文件中，找到ext.kotlin_version = '1.3.50'， 进行更改

++++

## [ios上架](https://www.jianshu.com/p/b75f1af55f29)

## Flutter的生命周期(交互) & WidgetsBindingObserver

```dart
abstract class WidgetsBindingObserver {

   //路由弹出Future
  Future<bool> didPopRoute() => Future<bool>.value(false);

    //新的路由Future
  Future<bool> didPushRoute(String route) => Future<bool>.value(false);

    //系统窗口相关改变回调，例如旋转
  void didChangeMetrics() { }

    //文字系数变化
  void didChangeTextScaleFactor() { }

    //本地化语言变化
  void didChangeLocales(List<Locale> locale) { }

    //生命周期变化
  void didChangeAppLifecycleState(AppLifecycleState state) { }

    //低内存回调
  void didHaveMemoryPressure() { }

    //当前系统改变了一些访问性活动的回调
  void didChangeAccessibilityFeatures() {}
}

作者：hzz9600
链接：https://juejin.cn/post/6844903794883444743
来源：稀土掘金
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
```

#### 生命周期回调（didChangeAppLifecycleState）

```dart
enum AppLifecycleState {
  resumed,
  inactive,
  paused,
  suspending,
}
```

创建期: initState

进入后台: inactive -> paused

从后台恢复: inactive -> resumed

resumed:应用可见并可响应用户操作

inactive:用户可见，但不可响应用户操作
paused:已经暂停了，用户不可见、不可操作
suspending：应用被挂起，此状态IOS永远不会回调

+++

#### StatefulWidget 生命周期

- **createState**：该函数为 StatefulWidget 中创建 State 的方法，当 StatefulWidget 被创建时会立即执行 createState。createState 函数执行完毕后表示当前组件已经在 Widget 树中，此时有一个非常重要的属性 mounted 被置为 true。
- **initState**：该函数为 State 初始化调用，只会被调用一次，因此，通常会在该回调中做一些一次性的操作，如执行 State 各变量的初始赋值、订阅子树的事件通知、与服务端交互，获取服务端数据后调用 setState 来设置 State。
- **didChangeDependencies**：该函数是在该组件依赖的 State 发生变化时会被调用。这里说的 State 为全局 State，例如系统语言 Locale 或者应用主题等，Flutter 框架会通知 widget 调用此回调。类似于前端 Redux 存储的 State。该方法调用后，组件的状态变为 dirty，立即调用 build 方法。
- **build**：主要是返回需要渲染的 Widget，由于 build 会被调用多次，因此在该函数中只能做返回 Widget 相关逻辑，避免因为执行多次而导致状态异常。
- **reassemble**：主要在开发阶段使用，在 debug 模式下，每次热重载都会调用该函数，因此在 debug 阶段可以在此期间增加一些 debug 代码，来检查代码问题。此回调在 release 模式下永远不会被调用。
- **didUpdateWidget**：该函数主要是在组件重新构建，比如说热重载，父组件发生 build 的情况下，子组件该方法才会被调用，其次该方法调用之后一定会再调用本组件中的 build 方法。
- **deactivate**：在组件被移除节点后会被调用，如果该组件被移除节点，然后未被插入到其他节点时，则会继续调用 dispose 永久移除。
- **dispose**：永久移除组件，并释放组件资源。调用完 dispose 后，mounted 属性被设置为 false，也代表组件生命周期的结束

作者：百瓶技术
链接：https://juejin.cn/post/7056646298073563166
来源：稀土掘金
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。



#### 不是生命周期但是却非常重要的几个概念

下面这些并不是生命周期的一部分，但是在生命周期中起到了很重要的作用。

- **mounted**：是 State 中的一个重要属性，相当于一个标识，用来表示当前组件是否在树中。在 createState 后 initState 前，mounted 会被置为 true，表示当前组件已经在树中。调用 dispose 时，mounted 被置为 false，表示当前组件不在树中。
- **dirty**：表示当前组件为脏状态，下一帧时将会执行 build 函数，调用 setState 方法或者执行 didUpdateWidget 方法后，组件的状态为 dirty。
- **clean**：与 dirty 相对应，clean 表示组件当前的状态为干净状态，clean 状态下组件不会执行 build 函数。


作者：百瓶技术
链接：https://juejin.cn/post/7056646298073563166
来源：稀土掘金
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

___

![](https://gitee.com/littleJshao/figure-bed/raw/master/images/533b6573ae124afca6104529b799f5e3_tplv-k3u1fbpfcp-zoom-in-crop-mark_1304_0_0_0.awebp)

上图为 flutter 生命周期流程图

#### 大致分为四个阶段

1. 初始化阶段，包括两个生命周期函数 createState 和 initState；
2. 组件创建阶段，包括 didChangeDependencies 和 build；
3. 触发组件多次 build ，这个阶段有可能是因为 didChangeDependencies、 setState 或者 didUpdateWidget 而引发的组件重新 build ，在组件运行过程中会多次触发，这也是优化过程中需要着重注意的点；
4. 最后是组件销毁阶段，deactivate 和 dispose。

作者：百瓶技术
链接：https://juejin.cn/post/7056646298073563166
来源：稀土掘金
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。





```java
class FlutterLifeCycleState extends State<FlutterLifeCycle>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); //添加观察者
  }

  ///生命周期变化时回调
//  resumed:应用可见并可响应用户操作
//  inactive:用户可见，但不可响应用户操作
//  paused:已经暂停了，用户不可见、不可操作
//  suspending：应用被挂起，此状态IOS永远不会回调
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print("@@@@@@@@@  didChangeAppLifecycleState: $state");
  }

  ///当前系统改变了一些访问性活动的回调
  @override
  void didChangeAccessibilityFeatures() {
    super.didChangeAccessibilityFeatures();
    print("@@@@@@@@@ didChangeAccessibilityFeatures");
  }

  /// Called when the system is running low on memory.
  ///低内存回调
  @override
  void didHaveMemoryPressure() {
    super.didHaveMemoryPressure();
    print("@@@@@@@@@ didHaveMemoryPressure");
  }

  /// Called when the system tells the app that the user's locale has
  /// changed. For example, if the user changes the system language
  /// settings.
  ///用户本地设置变化时调用，如系统语言改变
  @override
  void didChangeLocales(List<Locale> locale) {
    super.didChangeLocales(locale);
    print("@@@@@@@@@ didChangeLocales");
  }

  /// Called when the application's dimensions change. For example,
  /// when a phone is rotated.
  ///应用尺寸改变时回调，例如旋转
  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    Size size = WidgetsBinding.instance.window.physicalSize;
    print("@@@@@@@@@ didChangeMetrics  ：宽：${size.width} 高：${size.height}");
  }

  /// {@macro on_platform_brightness_change}
  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    print("@@@@@@@@@ didChangePlatformBrightness");
  }

  ///文字系数变化
  @override
  void didChangeTextScaleFactor() {
    super.didChangeTextScaleFactor();
    print(
        "@@@@@@@@@ didChangeTextScaleFactor  ：${WidgetsBinding.instance.window.textScaleFactor}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("flutter"),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this); //销毁观察者
  }
}
```

## 页面加载完成的回调：

WidgetsBinding.instance.addPostFrameCallback

## 监视页面的切换：

1. AppStateLifeRecycle ；
2. RouteAware；

#### [RouteAware](https://blog.csdn.net/sinat_17775997/article/details/106417967)

经常性的，我们需要监视页面的切换，用以在合适的时候对控件进行动画暂停或者资源释放。

注：

1. <u>路由观察者添加订阅与取消订阅必须成对出现；</u>
2. <u>一些对象在使用后一定要记得及时释放资源。</u>

```dart
///假如有3个页面，分别是A、B、C，跳转逻辑由A->B->C，而RouteAware使用with混淆在B中。
didPopNext：在C页面关闭后，B页面调起该方法；
didPush: 当由A打开B页面时，B页面调起该方法；
didPop: 当B页面关闭时，B页面调起该方法；
didPushNext: 当从B页面打开C页面时，该方法被调起
```

## 关于Future的执行

```dart
void main() {
  Test t = Test();
  t.testFuture().then((value) {
    print("结果是：=$value");
  });
}

class Test {
  Future<String> testFuture() => Future.delayed(Duration(seconds: 2), () {
        print("输出");
        return "hahah";
      }).then((value) {
        print("输出结束");
        return value;
      });
}

// 结果:
// 1.输出
// 2.输出结束
// 3.结果是：=hahah
```

## 使用Xocde调试较新系统的真机时

出现的问题：
Failed to prepare device for development

解决办法：

https://github.com/filsv/iPhoneOSDeviceSupport

找到对应iPhone系统版本的导进去，重启Xcode就可以了



