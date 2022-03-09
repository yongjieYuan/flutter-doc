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

