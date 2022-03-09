# Android 学习（Kotlin）

## 1.最外层目录下的build.gradle文件

```dart
buildscript {
 ext.kotlin_version = '1.3.61'
 repositories {
 google()
 jcenter()
 }
 dependencies {
 classpath 'com.android.tools.build:gradle:3.5.2'
 classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
 }
}
allprojects {
 repositories {
 google()
 jcenter()
 }
}
```

两处repositories的闭包中都声明了google()和jcenter()这两行配置，分别对应了一个代码仓库，google仓库中包含的主要是Google自家的扩展依赖库，而jcenter仓库中包含的大多是一些第三方的开源库。

