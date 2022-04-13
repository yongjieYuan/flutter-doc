# Flutter常用组件

## 1.圆角按钮

```dart
            TextButton(
                onPressed: (){
                  print('取消订单');
                },
                style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        side: BorderSide(width: 1.0, color: Color(0xFFC4C8CC)) /// 外边框
                    ),
                    minimumSize: Size.zero
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 5.0),
                  child: Text('取消订单', style: TextStyle(color: Color(0xFFA8ADB3), fontSize: 12.0)),
                )
            ),
```

```dart
            ClipRRect(
              borderRadius: BorderRadius.circular(16.5),
              child: ElevatedButton(
                onPressed: () {
                  Nav.push((context) => CheckoutCounter());
                },
                style: ButtonStyle(
                  textStyle: MaterialStateProperty.all(TextStyle(fontSize: 12.0)),
                  backgroundColor: MaterialStateProperty.all(Color(0xFF3F5AFF)),
                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 8.0, horizontal: 26.0))
                ),
                child: Text("提交订单"),
              ),
            )
```

## 2.Text

```dart
                  Text('待发货', style: TextStyle(color: Color(0xFF223359), fontSize: 14.0)),
```

## 3.圆形Container

```dart
Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
          fit: BoxFit.cover,
        ),
        border: Border.all(
          color: Colors.blue,
          width: 2,
        ),
        shape: BoxShape.circle, /// 一般这个属性就够了
      ),
    )
```

## 4. 圆形按钮

[CSDN：关于Flutter的button的按钮ElevatedButton](https://blog.csdn.net/qq_41619796/article/details/115658314)

```
InviteNumScreen
```

```dart
ElevatedButton(
          child: Text('button'),
          onPressed: (){},
          style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.all(20.0)),
              textStyle: MaterialStateProperty.all(TextStyle(fontSize: 20)),
              shape: MaterialStateProperty.all(
                CircleBorder(
                  side: BorderSide(
                    color: Colors.deepOrangeAccent,
                    width: 1.0
                  )
                )
              )
          )
        ) 
```

## 5.自定义对话框

1. 调用方式

   ```dart
   bool result = await showDialog(context: context, builder: (context) => CustomDialog('确定退出紫鲸书苑？'));
   ```

   

2. 自定义的对话框

   ```dart
         return Dialog(
           child: Container(
             decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.circular(10.0)
             ),
             height: 123.0,
             child: Column(
               children: [
                 Container(
                   padding: EdgeInsets.symmetric(vertical: 30.0),
                   child: Center(
                     child: Text(_message, style: TextStyle(color: Color(0xFF223359), fontSize: 16.0)),
                   ),
                 ),
                 Expanded(
                     child: Row(
                       children: [
                         Flexible(
                           child: Container(
                             decoration: BoxDecoration(
                               border: Border(
                                   top: BorderSide(width: 1.0, color: Color(0xFFEBEDF0)),
                                   right: BorderSide(width: 1.0, color: Color(0xFFEBEDF0))
                               ),
                             ),
                             child: SizedBox.expand(
                               child: TextButton(
                                 onPressed: (){
                                   Nav.pop(false);
                                 },
                                 child: Text('取消', style: TextStyle(fontSize: 14.0 ,color: Color(0xFFA8ADB3))),
                               ),
                             ),
                           ),
                         ),
                         Flexible(
                           child: Container(
                             decoration: BoxDecoration(
                               border: Border(
                                   top: BorderSide(width: 1.0, color: Color(0xFFEBEDF0))
                               ),
                             ),
                             child: SizedBox.expand(
                               child: TextButton(
                                 onPressed: (){
                                   Nav.pop(true);
                                 },
                                 child: Text('确定', style: TextStyle(fontSize: 14.0 ,color: Color(0xFF223359))),
                               ),
                             ),
                           ),
                         )
                       ],
                     )
                 )],
             ),
           ),
         );
   ```

   

## 6.圆角按钮

```dart
ElevatedButton(
                      onPressed: (){
                        print('保存');
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                           RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0))
                        ),
                      ),
                      child: Text('保存')
                  )
    
    
    ElevatedButton(
                onPressed: (){

                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                  padding: EdgeInsets.symmetric(horizontal: 27.0, vertical: 7.0),
                ),
                child: Text('确定')
            )
```

## 7.独占一行TextFormField

```dart
          TextFormField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.0),
              filled: true,
              fillColor: Colors.white,
              hintText: '请输入',
              hintStyle: TextStyle(color: Color(0xFFA8ADB3), fontSize: 14.0),
              helperText: '请不要超过16个字符，支持中英文、数字',
              helperStyle: TextStyle(color: Color(0xFFC4C8CC), fontSize: 13.0),
              border: InputBorder.none
            ),
            style: TextStyle(fontSize: 14.0),
          ),
```

## 8.独占一行的圆角按钮

```dart
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: (){
                        print('保存');
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(0xFF3F5AFF)),
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 12.0)),
                        shape: MaterialStateProperty.all(
                           RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0))
                        ),
                      ),
                      child: Text('保存', style: TextStyle(fontSize: 14.0))
                  ),
                ),
              ],
            ),
          )
```

## 9.文本输入框不限制行数，类似富文本

```dart
TextFormField(
                      maxLines: null,
                      expands: true,
                      style: TextStyle(fontSize: 13.0),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          hintText: '填写详细地址',
                          hintStyle: TextStyle(fontSize: 13.0, color: Color(0xFFA8ADB3)),
                          border: InputBorder.none
                      ),
                    )
```



```
                  separatorBuilder: (BuildContext context, int index){
                    return Divider(height: 2.0, color: Color(0xFFEBEBEB));
                  },
                  itemCount: _linkList.length,
```

## 10.有关圆角设置

```dart
                   decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0)
                            ),
                            color: Colors.white,
                          ),
```

## 11.[有关showModalBottomSheet](https://blog.csdn.net/cpcpcp123/article/details/97660036)

[解决圆角底部弹窗](https://blog.csdn.net/qq_35317752/article/details/103813196)

在showModalBottomSheet里面的根容器设置成SingleChildScrollView，即可实现高度根据内容自适应

```dart
showModalBottomSheet(/// 底部弹窗
                      context: context,
                      enableDrag: false,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                          )
                      ),
                      builder: (BuildContext context) {
                        return SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                            child: Column(
                              children: [
                                Text('The cancellation of account', style: TextStyle(color: Color(0xFF333333), fontSize: 16.0)),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                                  child: Text('Please note: Once your account is logged out,'
                                      ' you will not be able to log in and use your account, '
                                      'and your rights and interests will be cleared and cannot be restored.'
                                      ' Are you sure to cancel your account?',
                                    style: TextStyle(color: Color(0xFF999999), fontSize: 12.0),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
                                        onPressed: (){
                                          print('取消订单');
                                        },
                                        style: TextButton.styleFrom(
                                          backgroundColor: Color(0xFF5BCD49),
                                            padding: EdgeInsets.zero,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(13.5)/// 外边框
                                            ),
                                            minimumSize: Size.zero
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 13.0, vertical: 5.0),
                                          child: Text('confirm', style: TextStyle(color: Colors.white, fontSize: 12.0)),
                                        )
                                    ),
                                    TextButton(
                                        onPressed: (){
                                          print('取消订单');
                                        },
                                        style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(13.5),
                                                side: BorderSide(width: 0.5, color: Color(0xFF999999)) /// 外边框
                                            ),
                                            minimumSize: Size.zero
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 13.0, vertical: 5.0),
                                          child: Text('cancel', style: TextStyle(color: Color(0xFF999999), fontSize: 12.0)),
                                        )
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
```

## 12.列表展示

```dart
              /// 列表展示
              ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    height: 1.0,
                  );
                },
                itemBuilder: (context, index) {
                  return ShopItem(_list[index]);
                },
                itemCount: _list.length,
              )
```

## 13.Container阴影

```dart
boxShadow: [
    BoxShadow(
        color: Colors.black12,
        offset: Offset(0.0, 15.0), //阴影xy轴偏移量
        blurRadius: 15.0, //阴影模糊程度
        spreadRadius: 1.0 //阴影扩散程度
    )
],
```

## 14.[TextFormField属性](https://blog.csdn.net/chen1234219/article/details/105047845/)

## 15.[Flutter的showModalBottomSheet 输入框被弹出的键盘挡住](https://zhuanlan.zhihu.com/p/370424176)

## 16.页面滚动，性能优越的结构

1. Column -> Expanded -> ListView.builder

## 17.圆角TextFormField

```dart
                          TextFormField(
                            cursorColor: Color(0xFF5BCD49),
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none
                                ),
                                hintText: 'Enter a new binding mailbox',
                                hintStyle: TextStyle(
                                    color: Color(0xFFD6D9DD), fontSize: 14.0)),
                          ),
```

## 18.固定在界面上的时间选择器

相关链接：

https://blog.csdn.net/mengks1987/article/details/104580596

https://segmentfault.com/a/1190000020205762

## 19.ListWheelScrollView.useDelegate

```dart
ListWheelScrollView.useDelegate(
          itemExtent: 50.0,
          diameterRatio: .5,
          childDelegate: ListWheelChildBuilderDelegate(
              builder: (context, index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.primaries[index % 10],
                  child: Text('$index'),
                );
              }
          ),
    /// 选中事件
        onSelectedItemChanged: (val){
            print(val);
        },
      )
```

## 20.TextFormField文章

```dart
http://www.ptbird.cn/flutter-form-textformfield.html
```

```dart
Column(
        children: [
          Flexible(
            child: ListView(
              shrinkWrap: true,
              children: _links.map((item) =>
                  GestureDetector(
                    onTap: (){
                      Nav.push((context) => item['link']);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 5.0),
                      height: 50.0,
                      padding: EdgeInsets.only(left: 15.0, right: 17.0),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(item['title'], style: TextStyle(color: Color(0xFF333333), fontSize: 14.0)),
                          Image.asset('arrow_click'.webp, width: 6.0, height: 12.0, fit: BoxFit.cover)
                        ],
                      ),
                    ),
                  )
              ).toList(),
            ),
          ),
        ],
      )

```

## 21.Entry name ‘classes.dex‘ collided

有效的解决方案是把 release 文件夹下之前生成的 apk 删除，然后再次生成 apk。

## 22.flutter textformfield失去焦点

https://www.cnblogs.com/lude1994/p/14218014.html



```dart
Text('Exhaust Fan 1')
```

## 23.InkWell 使用无效

在外层嵌套个inkwell，如果还是不行就在inkwell外面套一个Material

```dart
Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onLongPress : (){
                            print('fff');
                          },
                          child: Container(child: Text('Exhaust Fan 1'))
                        ),
                      ),
```

## 24.瀑布流布局

```dart
StaggeredGridView.countBuilder(
                      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      primary: true,
                      //滑动方向
                      scrollDirection: Axis.vertical,
                      //纵轴方向被划分的个数
                      crossAxisCount: 2,
                      //item的数量
                      itemCount: _shopList.length,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                      itemBuilder: (BuildContext context, int index) => GestureDetector(
                        onTap: () async{
                          final _app = 'amzn://'; /// 跳转到亚马逊app
                          final _url = _shopList[index].url;
                          if(await canLaunch(_app)) {
                            await launch(_app);
                          } else {
                            await canLaunch(_url) ? await launch(_url) : Chili.showToast('Could not launch amazon');
                          }
                        },
                        child: Container(/// 商品
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(196, 208, 226, 0.15),
                                  offset: Offset(6.0, 6.0),
                                  blurRadius: 6.0,
                                )
                              ]
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width: 151.0,
                                    height: 151.0,
                                    /// 商品图片
                                    child: CachedNetworkImage(
                                      imageUrl: '${Global.imgPath}${_shopList[index].thumbnail}',
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                    )
                                ),
                                /// 名称
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                                  child: Text(_shopList[index].name, textAlign: TextAlign.center,style: TextStyle(color: Color(0xFF333333), fontSize: 12.0)),
                                ),
                                /// 价格
                                Text('\$${_shopList[index].price}', style: TextStyle(color: Color(0xFFFF89B6), fontSize: 14.0, letterSpacing: -0.01))
                              ],
                            ),
                          ),
                        ),
                      )
                  ),
```

## 25.解决基线对齐

1. 

```dart
Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text('反反复复:', style: TextStyle(fontSize: 40.0),),
            SizedBox(width: 10.0,),
            Text('ff', style: TextStyle(fontSize: 40.0),)
          ],
        )
```

2. 给Text设置高度

## 26.图片裁剪

```dart
/// ----------------------------主要逻辑----------------------------
final cropKey = GlobalKey<CropState>(); 
/// 处理图片
  Future _handleImage(File originalImage) async{
    final crop = cropKey.currentState;
    final scale = crop?.scale;
    final area = crop?.area;
    late File handeledImg;
    if(area == null ) {
      Chili.showToast('Save failed');
      return;
    }
    /// 请求访问照片的权限
    bool result =  await ImageCrop.requestPermissions();
    if (result) {
      try {
        handeledImg = await ImageCrop.cropImage(
            file: originalImage,
            scale: scale,
            area: area
        );
      } catch(e) {
        Chili.showToast(e.toString());
        Nav.pop();
      }
    }else {
      handeledImg = originalImage; /// 失败则获取原来的图片路径
    }
    return handeledImg.path;
  }


/// 返回处理完图片的路径
                            _imgPath = await _handleImage(File(widget.image));
```

## 27. 选取图片

```dart
/// ----------------------------主要逻辑----------------------------
final ImagePicker _picker = ImagePicker();			
XFile? image; /// 定义图片类型变量
              bool result = await ShowModal.showText(
                  context,
                  title: 'Select your operation',
                  confirm: 'Camera',
                  cancel: 'Album'
              );
              if(result) {
                image = await _picker.pickImage(source: ImageSource.camera, imageQuality: 40);
              } else {
                image = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 40);
              }
              /// 如果用户有选取图片则路由到截图
              if(image != null) {
                Nav.push((context) =>  CropImageScreen(image!.path));
                print('path: ${image.path}');
              }
```



## 28. flutter_blue

1. flutter_blue api

   ```dart
   flutterBlue = FlutterBlue.instance.state
       
   flutterBlue.state
   flutterBlue.startScan()
   flutterBlue.connectedDevices
   flutterBlue.scanResults
   flutterBlue.isScanning
   flutterBlue.stopScan()
   ```

2. BluetoothState api

   ```dart
   enum BluetoothState {
     unknown,
     unavailable,
     unauthorized,
     turningOn,
     on,
     turningOff,
     off
   }
   ```

3. BluetoothDeviceState

   ```dart
   enum BluetoothDeviceState { disconnected, connecting, connected, disconnecting }
   ```

## 29.自定义底部弹框

```dart
import 'package:flutter/material.dart';
import 'package:chili/chili.dart';

class ShowModal {
 static Future<bool> showText(context, {title = '', text = '', confirm: 'confirm', cancel = 'cancel'}) async{
 return showModalBottomSheet(
      context: context,
      enableDrag: false,
      isDismissible: false,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          )
      ),
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            child: Column(
              children: [
                /// 标题
                Text(title, style: TextStyle(color: Color(0xFF333333), fontSize: 16.0)),
                /// 文本
                text.isNotEmpty ? Container(
                  margin: EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(text, textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF999999), fontSize: 12.0),
                  ),
                ) : Container(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    /// 确认
                    TextButton(
                        onPressed: (){
                          Nav.pop(true);
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: Color(0xFF5BCD49),
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13.5)/// 外边框
                            ),
                            minimumSize: Size.zero
                        ),
                        child: Container(
                          width: 70.0,
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Center(child: Text(confirm, style: TextStyle(color: Colors.white, fontSize: 12.0))),
                        )
                    ),
                    /// 取消
                    TextButton(
                        onPressed: (){
                          Nav.pop(false);
                        },
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13.5),
                                side: BorderSide(width: 0.5, color: Color(0xFF999999)) /// 外边框
                            ),
                            minimumSize: Size.zero
                        ),
                        child: Container(
                          width: 70.0,
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Center(child: Text(cancel, style: TextStyle(color: Color(0xFF999999), fontSize: 12.0))),
                        )
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    ).then((value) => value);
  }
}



/// 调用
              bool result = await ShowModal.showText(
                  context,
                  title: 'Select your operation',
                  confirm: 'Camera',
                  cancel: 'Album'
              );
```

## 30.常用正则表达式

```dart
/// 常用正则验证
/// @author [Huangch]
class CommonRegular {

  ///手机号
  static bool isPhone(String input) {
    RegExp mobile = new RegExp(r"1[0-9]\d{9}$");
    return mobile.hasMatch(input);
  }

  ///6~16位数字和字符组合
  static bool isLoginPassword(String input) {
    RegExp password = new RegExp(r"(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$");
    return password.hasMatch(input);
  }

  ///手机号屏蔽中间4位
  static String shieldPhone(String phoneNUm) {
    return phoneNUm.replaceFirst(RegExp(r"\d{4}"), "****",3);
  }

  ///身份证
  static bool isNationalId(String input) {
    RegExp id = RegExp(r'^(^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$)|(^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])((\d{4})|\d{3}[Xx])$)$');
    return id.hasMatch(input);
  }


}
```

## 31.关于 ?.

```dart
slide[index]?.image != null  // ?. 如果slide[index]为null，则前半部分都为null
```

## 32.常用的登录表单布局

```dart
child: Form(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                              prefixIconConstraints: BoxConstraints(
                                maxWidth: 15.0,
                                maxHeight: 18.0
                              ),
                              prefixIcon: Image.asset('icon_login_phone'.webp,
                                 fit: BoxFit.cover),
                              hintStyle: TextStyle(
                                  color: Color(0xFFBFBFBF), fontSize: 14.0),
                              hintText: '请输入手机号/邮箱'),
                        ),
                        TextFormField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 20.0),
                                prefixIconConstraints: BoxConstraints(
                                    maxWidth: 15.0,
                                    maxHeight: 18.0
                                ),
                                prefixIcon: Image.asset(
                                  'icon_login_yanzhengma'.webp,
                                  fit: BoxFit.cover,
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFF5F6F7)
                                  )
                                ),
                                hintText: '请输入验证码'))
                      ],
                    ),
                  )
```

## 32.网络图片缓存组件

```dart
CachedNetworkImage(
                width: 78.0,
                height: 78.0,
                imageUrl: 'https://gitee.com/littleJshao/figure-bed/raw/master/images/dragon-1.jpg',
                progressIndicatorBuilder:
                    (context, url, downloadProgress) =>
                    CupertinoActivityIndicator(),
                fit: BoxFit.cover,
                errorWidget: (context, url, error) =>
                    Icon(Icons.error),
              )
```

## 33.解决华为手机在连接Android Studio调试时出现异常：Error while Launching activity

百思不得其解，查找多方原因后才发现原来的应用被我从手机上卸载了，但是 Android Studio 却发现你的应用没卸载干净，导致两个应用签名不一致，所以在安装应用的时候会报出无法找到 MainActivity 入口的异常。

在终端中输入以下命令：

adb uninstall yourPakageName

[博客地址](https://blog.csdn.net/qq_44214671/article/details/109614908)

## 34.CustomScrollView 之 Sliver 家族的 Widget

```dart
CustomScrollView buildCustomScrollView() {
   return CustomScrollView(
     ///反弹效果
     physics: BouncingScrollPhysics(),
     ///Sliver 家族的 Widget
     slivers: <Widget>[
       ///复杂的标题
       buildSliverAppBar(),
       ///间距
       SliverPadding(
         padding: EdgeInsets.all(5),
       ),

       ///九宫格
       buildSliverGrid(),
       ///间距
       SliverPadding(
         padding: EdgeInsets.all(5),
       ),
       ///列表
       buildSliverFixedExtentList()
     ],
   );
 }
```

## 35.Flutter Wrap流式布局嵌套循环Row导致占据一行问题

项目中我们在使用Wrap去循环数据的时候，有一些UI需要使用到Row布局来进行展示，但是众所周知的是，Row布局会占满一行，这就导致我们的Wrap失效了，如何解决呢？

```dart
Wrap(
     spacing:ScreenAdapter.setWidth(20),// 主轴(水平)方向间距
     runSpacing:ScreenAdapter.setHeight(13), // 纵轴（垂直）方向间距
     // alignment: WrapAlignment.start, //沿主轴方向居中
     direction:Axis.horizontal,
     children: tagList.map<Widget>((item){
       return InkWell(
         child: Container(
             padding: EdgeInsets.symmetric(horizontal:ScreenAdapter.setWidth(20), vertical:ScreenAdapter.setHeight(10)),
             decoration: BoxDecoration(
               color:Color(0xffEEEEEE),
               borderRadius: BorderRadius.circular(20)
             ),
             child:
             RichText(
               text: TextSpan(
                 style: TextStyle(fontSize: 25, color: Colors.black, fontWeight:FontWeight.w500),
                 children: [
                   WidgetSpan(
                     child: Container(
                       width: 30,
                       child: AspectRatio(
                         aspectRatio: 1/1,
                         child: ClipRRect(
                           borderRadius: BorderRadius.circular(20),
                           child: Container(
                             color:Colors.white,
                             child:Icon(Icons.add, size: 20, color:Color(0xffDB4739))
                           ),
                         ),
                       ),
                     ),
                   ),
                   TextSpan(text:'${item['title']}')
                 ]
               ),
             )
         ),
         onTap: (){
           Navigator.pushNamed(context, '/themeDetails', arguments: {'id':'3RDOl99mWb'});
         },
       );
     }).toList()
   )
```

## 36.[flutter输入框TextField设置高度以及背景色等样式的正确姿势](https://www.cnblogs.com/yongfengnice/p/14143805.html)

## 37.Row 中 使用Text，并实现超出隐藏

```dart
Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: Text(
                        '${(value?.toString()?.isEmpty ?? true) ? '请选择' : value.toString()}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14.0, color: Color(0xFF999999))),
                  ),
                  Image.asset('btn_common_right'.webp,
                      width: 28.0, height: 28.0, fit: BoxFit.cover)
                ],
              )
```

## 38.DropdownButton

```dart
 DropdownButton(
                          alignment: AlignmentDirectional.centerEnd,
                          items: List.generate(
                            _goodsType.length,
                            (index) => DropdownMenuItem(
                              child: Text(_goodsType[index].name!),
                              value: _goodsType[index].id,
                            ),
                          ),
                          value: goodsCategory.id,
                          isDense: true,
                          style: TextStyle(
                              fontSize: 14.0, color: Color(0xFF333333)),
                          onChanged: (val) {
                            setter(() {
                              goodsCategory.id = val as int;
                            });
                          },
                          icon: Image.asset(
                            'btn_common_down'.webp,
                            width: 28.0,
                            height: 29.0,
                            fit: BoxFit.cover,
                          ),
                          underline: Container(),
                        )
```

## 39.复杂列表的使用，并保持销毁，初始化

```dart
CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                  GoogleMapScreen(
                      latitude: 2.0, longitude: 2.0, onTap: (pos) {})
                ]),
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      List<String> images = _list[index].images!.split(';');
                      return DataCard(
                        info: [
                          labelText('仓库名称：', '${_list[index].name}'),
                          labelText('仓库地址：', '${_list[index].address}'),
                          labelText('仓库电话：', '${_list[index].contactsPhone}'),
                          labelText('当前距离：：', '${_list[index].distance}'),
                        ],
                        imageWrap: images,
                        btnGroup: [
                          customButton(text: '一键导航', callback: () {}),
                          customButton(text: '拨打电话', callback: () {}),
                        ],
                      );
                    },
                    childCount: _list.length,
                  ))
            ],
          )
```

## 40.类似label标签，带有外边框

```dart
Container(
      margin: EdgeInsets.only(right: 8.0),
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
      decoration: BoxDecoration(
          color: Color.fromRGBO(255, 159, 33, 0.08),
          border: Border.all(color: Color(0xFFFF9F21)),
          borderRadius: BorderRadius.all(Radius.circular(4.0))),
      child: Text('${text}',
          style: TextStyle(color: Color(0xFFFF9F21), fontSize: 12.0)),
    )
```

## 41.安卓内部更新ota_update

```dart
  void _updateVersion() async{
    if (Platform.isIOS){
      String url = '${widget.data.url}'; // 这是微信的地址，到时候换成自己的应用的地址
      if (await canLaunch(url)){
        await launch(url);
      }else {
        throw 'Could not launch $url';
      }
    }else if (Platform.isAndroid){
      String url = '${widget.data.url}';
      print('下载的链接：${widget.data.url}');
      try {
        // destinationFilename 是对下载的apk进行重命名
        OtaUpdate().execute(url, destinationFilename: 'news.apk').listen(
              (OtaEvent event) {
            print('status:${event.status},value:${event.value}');
            switch(event.status){
              case OtaStatus.DOWNLOADING:// 下载中
                setState(() {
                  progress = '下载进度:${event.value}%';
                });
                break;
              case OtaStatus.INSTALLING: //安装中
                print('安装中');
                progress=null;
                setState(() {});
                break;
              case OtaStatus.PERMISSION_NOT_GRANTED_ERROR: // 权限错误
                print('更新失败，请稍后再试');
                break;
              default: // 其他问题
                print('其他问题');
                break;
            }
          },
        );
      } catch (e) {
        print('更新失败，请稍后再试');
      }
    }
  }	


///api--版本更新检查
  ApplicationFindLatestData data;
  _applicationFindLatest(String platform) async {
    await RequestUtil.applicationFindLatest(
      NoActionIntercept(this),
      platform,
    ).then((res) {
      if(res.code==200){
        data = res.data;
        Commons.isCheckUpData = true;
        print('现在版本号：${LocalStorage.get(Commons.VERSION)}  目标：${data.name}');
        if (data.name != LocalStorage.get(Commons.VERSION)) {
//        Commons.isShowUpData = true;
          showDialog(context: context,builder: (context){
            return UpdateApp(data: data,);
          });
        }else{
          showToast('已是最新版本');
        }
        setState(() {});
      }
    }).catchError((e) {});
  }
```

## 43.打开外部链接url_launcher

1. android配置

```dart
<queries>
  <!-- If your app opens https URLs -->
  <intent>
    <action android:name="android.intent.action.VIEW" />
    <data android:scheme="https" />
  </intent>
  <!-- If your app makes calls -->
  <intent>
    <action android:name="android.intent.action.DIAL" />
    <data android:scheme="tel" />
  </intent>
  <!-- If your app emails -->
  <intent>
    <action android:name="android.intent.action.SEND" />
    <data android:mimeType="*/*" />
  </intent>
</queries>

```

2. ios 配置

   ```dart
   <key>LSApplicationQueriesSchemes</key>
   <array>
     <string>https</string>
     <string>http</string>
   </array>
   ```

3. 使用

   ```dart
   void _launchURL() async =>
       await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
   ```

==使用注意：url要加特定的前缀；例如：‘tel’+url 调用拨号界面==

## 44.flutter 打包的app 闪退

在app下面的build.gradle中：

```dart
//关闭混淆, 否则在运行release包后可能出现运行崩溃， TODO后续进行混淆配置
minifyEnabled false //删除无用代码
shrinkResources false //删除无用资源
    
    
    
    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig signingConfigs.release
            minifyEnabled false //删除无用代码
            shrinkResources false //删除无用资源
        }
    }
```

## 46. ios 加载（loading）

```dart
CupertinoActivityIndicator()
```

## 47.flutter 查看pdf文件

```dart
#A package to show Native PDF View for iOS and Android, support Open from a different resource like Path, Asset or Url and Cache it.
flutter_cached_pdfview
```

## 48.轮播

```dart
 CarouselSlider(
                          /// 轮播
                          carouselController: _controller,
                          options: CarouselOptions(
                              autoPlay: true,
                              viewportFraction: 1,
                              height: 281.0,
                            onPageChanged: (index, res) {
                                setState(() {
                                  _currBanner = index;
                                });
                            }
                          ),
                          items: bannerList
                              .map((data) =>
                                  Builder(builder: (BuildContext context) {
                                    return GestureDetector(
                                      onTap: () {
                                        if(data.link!.isNotEmpty) {
                                          Utils.openUrl(data.link!);
                                          return;
                                        }
                                        Nav.push(
                                            (context) => BannerDetailScreen(
                                                  title: data.title!,
                                                  bannerId: data.id!,
                                                ));
                                      },
                          ///控制图片显示的尺寸主要正对下面的CachedNetworkImage修改即可，例如图片无法撑开宽度则设置width:double.maxFinite,
                                      child: CachedNetworkImage(
                                        width: double.maxFinite,
                                        imageUrl:
                                            '${Global.baseImageUrl}${data.image}',
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                                CupertinoActivityIndicator(),
                                        height: 281.0,
                                        fit: BoxFit.cover,
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    );
                                  }))
                        )
```

## 49.谷歌路线图

```dart
import 'package:flutter/material.dart';
import 'package:chili/chili.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// 查看司机位置
class CheckDriverPosition extends StatefulWidget {
  const CheckDriverPosition({required this.destLocation, required this.originLocation, Key? key}) : super(key: key);

  final Map originLocation;
  final Map destLocation;

  @override
  State<CheckDriverPosition> createState() => _CheckDriverPositionState();
}

class _CheckDriverPositionState extends State<CheckDriverPosition> {

  GoogleMapController? _mapController;

  /// 标记点列表
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  ///初始化视野 的经纬度
  double centerLat = 0 ;
  double centerLong = 0;

  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleApiKey = 'AIzaSyAEF80-c_mLIj7PxKi6XU8qlkAvvH3fbhM';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // /// origin marker
    _addMarker(LatLng(widget.originLocation["lat"], widget.originLocation["long"]), "origin",
        BitmapDescriptor.defaultMarker);
    /// destination marker
    _addMarker(LatLng(widget.destLocation["lat"], widget.destLocation["long"]), "destination",
        BitmapDescriptor.defaultMarker);
    _getPolyline();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF9F9F9),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Nav.pop();
            },
            icon: Image.asset('btn_common_left'.webp,
                width: 28.0, fit: BoxFit.cover),
          ),
          title: Text(
            '查看司机位置'.i18n,
            style: TextStyle(fontSize: 18),
          ),
        ),
        body: GoogleMap(
          zoomControlsEnabled: false,
          polylines: Set<Polyline>.of(polylines.values),
          initialCameraPosition: CameraPosition(
            zoom: 10.0,
            target: LatLng(widget.originLocation['lat'], widget.originLocation['long']),
          ),
          onMapCreated: _onMapCreated,
          myLocationEnabled: true,
          // markers: Set<Marker>.of(markers.values),
          tiltGesturesEnabled: true,
          compassEnabled: true,
        ));
  }

  void _onMapCreated(GoogleMapController controller) async {
    _mapController = controller;
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
    Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Color(0xFFFF9F21),
      points: polylineCoordinates,
      width: 5,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    await polylinePoints
        .getRouteBetweenCoordinates(
      googleApiKey,
      PointLatLng(widget.originLocation['lat'], widget.originLocation['long']),
      PointLatLng(widget.destLocation['lat'], widget.destLocation['long']),
      wayPoints: [
        PolylineWayPoint(location: "22.802306,113.164728"),
        PolylineWayPoint(location: "22.557069, 113.429766"),
      ],
      travelMode: TravelMode.driving,
    ) .then((value) {
      if (value.points.isNotEmpty) {
        value.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
      } else {}
      _addPolyLine();
    });
  }

  ///获取起点与终点之间 中间的经纬度坐标
  // void getCenterLonLat(){
  //   centerLat = widget.originLocation['lat'] - widget.destLocation['lat'];
  //   centerLong = widget.originLocation['long'] - widget.destLocation['long'];
  //   //Math.abs()绝对值
  //   if( centerLong > 0){
  //     centerLong = widget.originLocation['long'] - centerLong.abs()   / 2;
  //   }else{
  //     centerLong = widget.destLocation['long'] - centerLong.abs() / 2;
  //   }
  //   if( centerLat > 0){
  //     centerLat = widget.originLocation['lat'] -  centerLat.abs() / 2;
  //   }else{
  //     centerLat = widget.destLocation['lat'] - centerLat.abs() / 2;
  //   }
  // }

}

```

## 50.下载文件的demo(不能正常运行，相关方法只做参考)

```dart
import 'dart:isolate';
import 'dart:ui';
import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chili/chili.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ting_hui_wu_liu_user_app/global.dart';

class DownloadFileWidget extends StatefulWidget {
  const DownloadFileWidget({required this.link, Key? key}) : super(key: key);

  /// 下载链接
  final String link;

  @override
  _DownloadFileWidgetState createState() => _DownloadFileWidgetState();
}

class _DownloadFileWidgetState extends State<DownloadFileWidget> {

  /// 当前的任务
  late TaskInfo _task;

  /// 侦听器
  ReceivePort _port = ReceivePort();

  /// 保存路径
  late String _localPath;

  /// 绑定前台和后台之间的通信
  void _bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) {
      // if (debug) {
      //   print('UI Isolate Callback: $data');
      // }
      String? id = data[0];
      DownloadTaskStatus? status = data[1];
      int? progress = data[2];

      // if (_tasks != null && _tasks!.isNotEmpty) {
      //   final task = _tasks!.firstWhere((task) => task.taskId == id);
      //   setState(() {
      //     task.status = status;
      //     task.progress = progress;
      //   });
      // }
    });
  }
  /// 检查权限
  Future<bool> _checkPermission() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (Theme.of(context).platform == TargetPlatform.android &&
        androidInfo.version.sdkInt! <= 28) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  /// 设置保存路径
  Future<String?> _findLocalPath() async {
    var externalStorageDirPath;
    if (Platform.isAndroid) {
      final directory = await getExternalStorageDirectory();
      externalStorageDirPath = directory?.path;
    } else if (Platform.isIOS) {
      externalStorageDirPath =
          (await getApplicationDocumentsDirectory()).absolute.path;
    }
    // print('externalStorageDirPath:\n$externalStorageDirPath');
    return externalStorageDirPath;
  }

  Future<void> _prepareSaveDir() async {
    _localPath = (await _findLocalPath())!;
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  /// 初始化存储路径，存储权限，获取本地所有任务信息
  Future<void> _prepare() async{
    /// 获取本地的所有任务信息
    final List<DownloadTask> ?tasks = await FlutterDownloader.loadTasks();
    tasks!.forEach((item) {
      if(item.url == _task.link) {
        _task.taskId = item.taskId;
        _task.status = item.status;
        _task.progress = item.progress;
      }
    });

    if(await _checkPermission()) {
      await _prepareSaveDir();
    }
  }

  /// 下载的回调
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    // if (debug) {
    //   print(
    //       'Background Isolate Callback: task ($id) is in status ($status) and process ($progress)');
    // }
    final SendPort send =
    IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  /// 销毁前后台之间的通信
  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  /// 请求下载
  void _requestDownload(TaskInfo task) async {
    task.taskId = await FlutterDownloader.enqueue(
      url: task.link!,
      headers: {"auth": "test_for_sql_encoding"},
      savedDir: _localPath,
      showNotification: true,
      openFileFromNotification: true,
      saveInPublicStorage: true,
    );
  }

  /// 重新下载
  void _retryDownload(TaskInfo task) async {
    String? newTaskId = await FlutterDownloader.retry(taskId: task.taskId!);
    task.taskId = newTaskId;
  }

  /// 打开文件
  Future<bool> _openDownloadedFile(TaskInfo? task) {
    if (task != null) {
      return FlutterDownloader.open(taskId: task.taskId!);
    } else {
      return Future.value(false);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _task = TaskInfo(link: "${Global.baseImageUrl}${widget.link}");
    _bindBackgroundIsolate();

    FlutterDownloader.registerCallback(downloadCallback);

    _prepare();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
              color: const Color(0xFFFF9F21),
              borderRadius: BorderRadius.circular(5.0)
          ),
          padding: const EdgeInsets.symmetric(horizontal: 42.0, vertical: 5.0),
          child: const Text('付款请求书.pdf', style: TextStyle(color: Colors.white, fontSize: 14.0),),
        ),
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: (){

          },
          child: _buildActionForTask(_task),
        )
      ],
    );
  }

  Widget _buildActionForTask(TaskInfo task) {
    if(task.status == DownloadTaskStatus.running) {/// 下载中
      return CircularProgressIndicator(
        value: task.progress! / 100,
        backgroundColor: Colors.white,
        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF9F21)),
      );
    } else if(task.status == DownloadTaskStatus.failed) {/// 下载失败
      return IconButton(
          onPressed: () => _retryDownload(task),
          icon: Icon(Icons.refresh_rounded, size: 16.0,)
      );
    } else if(task.status == DownloadTaskStatus.complete) {
      return TextButton(
          onPressed: () => _openDownloadedFile(task),
          child: Text('打开', style: TextStyle(color: Color(0xFFFF9F21), fontSize: 14.0))
      );
    } else if (task.status == DownloadTaskStatus.enqueued) {/// 等待
      return CupertinoActivityIndicator();
    }
    return TextButton(
        onPressed: () => _retryDownload(task),
        child: Text('下载', style: TextStyle(color: Color(0xFFFF9F21), fontSize: 14.0))
    );
  }
}

/// 自定义任务类型数据
class TaskInfo {
  /// 下载链接
  final String? link;

  String? taskId;
  int? progress = 0;
  DownloadTaskStatus? status = DownloadTaskStatus.undefined;

  TaskInfo({this.link});
}
import 'dart:isolate';
import 'dart:ui';
import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chili/chili.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ting_hui_wu_liu_user_app/global.dart';

class DownloadFileWidget extends StatefulWidget {
  const DownloadFileWidget({required this.link, Key? key}) : super(key: key);

  /// 下载链接
  final String link;

  @override
  _DownloadFileWidgetState createState() => _DownloadFileWidgetState();
}

class _DownloadFileWidgetState extends State<DownloadFileWidget> {

  /// 当前的任务
  late TaskInfo _task;

  /// 侦听器
  ReceivePort _port = ReceivePort();

  /// 保存路径
  late String _localPath;

  /// 绑定前台和后台之间的通信
  void _bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) {
      // if (debug) {
      //   print('UI Isolate Callback: $data');
      // }
      String? id = data[0];
      DownloadTaskStatus? status = data[1];
      int? progress = data[2];

      // if (_tasks != null && _tasks!.isNotEmpty) {
      //   final task = _tasks!.firstWhere((task) => task.taskId == id);
      //   setState(() {
      //     task.status = status;
      //     task.progress = progress;
      //   });
      // }
    });
  }
  /// 检查权限
  Future<bool> _checkPermission() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (Theme.of(context).platform == TargetPlatform.android &&
        androidInfo.version.sdkInt! <= 28) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  /// 设置保存路径
  Future<String?> _findLocalPath() async {
    var externalStorageDirPath;
    if (Platform.isAndroid) {
      final directory = await getExternalStorageDirectory();
      externalStorageDirPath = directory?.path;
    } else if (Platform.isIOS) {
      externalStorageDirPath =
          (await getApplicationDocumentsDirectory()).absolute.path;
    }
    // print('externalStorageDirPath:\n$externalStorageDirPath');
    return externalStorageDirPath;
  }

  Future<void> _prepareSaveDir() async {
    _localPath = (await _findLocalPath())!;
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  /// 初始化存储路径，存储权限，获取本地所有任务信息
  Future<void> _prepare() async{
    /// 获取本地的所有任务信息
    final List<DownloadTask> ?tasks = await FlutterDownloader.loadTasks();
    tasks!.forEach((item) {
      if(item.url == _task.link) {
        _task.taskId = item.taskId;
        _task.status = item.status;
        _task.progress = item.progress;
      }
    });

    if(await _checkPermission()) {
      await _prepareSaveDir();
    }
  }

  /// 下载的回调
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    // if (debug) {
    //   print(
    //       'Background Isolate Callback: task ($id) is in status ($status) and process ($progress)');
    // }
    final SendPort send =
    IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  /// 销毁前后台之间的通信
  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  /// 请求下载
  void _requestDownload(TaskInfo task) async {
    task.taskId = await FlutterDownloader.enqueue(
      url: task.link!,
      headers: {"auth": "test_for_sql_encoding"},
      savedDir: _localPath,
      showNotification: true,
      openFileFromNotification: true,
      saveInPublicStorage: true,
    );
  }

  /// 重新下载
  void _retryDownload(TaskInfo task) async {
    String? newTaskId = await FlutterDownloader.retry(taskId: task.taskId!);
    task.taskId = newTaskId;
  }

  /// 打开文件
  Future<bool> _openDownloadedFile(TaskInfo? task) {
    if (task != null) {
      return FlutterDownloader.open(taskId: task.taskId!);
    } else {
      return Future.value(false);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _task = TaskInfo(link: "${Global.baseImageUrl}${widget.link}");
    _bindBackgroundIsolate();

    FlutterDownloader.registerCallback(downloadCallback);

    _prepare();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
              color: const Color(0xFFFF9F21),
              borderRadius: BorderRadius.circular(5.0)
          ),
          padding: const EdgeInsets.symmetric(horizontal: 42.0, vertical: 5.0),
          child: const Text('付款请求书.pdf', style: TextStyle(color: Colors.white, fontSize: 14.0),),
        ),
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: (){

          },
          child: _buildActionForTask(_task),
        )
      ],
    );
  }

  Widget _buildActionForTask(TaskInfo task) {
    if(task.status == DownloadTaskStatus.running) {/// 下载中
      return CircularProgressIndicator(
        value: task.progress! / 100,
        backgroundColor: Colors.white,
        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF9F21)),
      );
    } else if(task.status == DownloadTaskStatus.failed) {/// 下载失败
      return IconButton(
          onPressed: () => _retryDownload(task),
          icon: Icon(Icons.refresh_rounded, size: 16.0,)
      );
    } else if(task.status == DownloadTaskStatus.complete) {
      return TextButton(
          onPressed: () => _openDownloadedFile(task),
          child: Text('打开', style: TextStyle(color: Color(0xFFFF9F21), fontSize: 14.0))
      );
    } else if (task.status == DownloadTaskStatus.enqueued) {/// 等待
      return CupertinoActivityIndicator();
    }
    return TextButton(
        onPressed: () => _retryDownload(task),
        child: Text('下载', style: TextStyle(color: Color(0xFFFF9F21), fontSize: 14.0))
    );
  }
}

/// 自定义任务类型数据
class TaskInfo {
  /// 下载链接
  final String? link;

  String? taskId;
  int? progress = 0;
  DownloadTaskStatus? status = DownloadTaskStatus.undefined;

  TaskInfo({this.link});
}
```

## 51.WidgetSpan

在文本中内嵌固定大小Widget。

```dart
RichText(
          text: TextSpan(
              children: [
                WidgetSpan(
                  child: Image.asset(
                    '${_currIndex == index ? 'btn_login_choose_s' : 'btn_login_choose_d'}'.webp,
                    width: 18.0,
                    height: 18.0,
                    fit: BoxFit.cover,
                  ),
                ),
                WidgetSpan(
                  child: Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Text('${widget.group[index]}'.i18n, style: TextStyle(fontSize: 14.0),),
                  ),
                )
              ]
          ),
        )
```

## 52.[打开google应用的相关api](https://developers.google.com/maps/documentation/urls/get-started?hl=zh-CN)



## 53.聚焦

关于焦点事件：https://www.freesion.com/article/4272635917/

```dart
///输入框的焦点
FocusNode _focusNode = FocusNode(); 
FocusScope.of(context).requestFocus(FocusNode());
```

## 54.[Flutter文本输入框TextField属性](https://blog.csdn.net/yuzhiqiang_1993/article/details/88204031)

## 57.下拉刷新，上滑加载

```dart
import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:chili/chili.dart';
import 'package:ting_hui_wu_liu_user_app/models/model.dart';

/// 自定义下拉刷新
class PullDownRefresh<T> extends StatefulWidget {
  const PullDownRefresh({required this.controller, required this.future, required this.pageable, required this.builder, this.noDataText, this.noMoreDataText, Key? key}) : super(key: key);

  final Future<T> Function(Pageable pageable) future;
  final Widget Function(BuildContext context, T value) builder;
  final RefreshController controller;
  final Pageable pageable;
  /// 没有更多的数据
  final String? noMoreDataText;
  /// 没有数据
  final String? noDataText;

  @override
  _PullDownRefreshState<T> createState() => _PullDownRefreshState();
}

class _PullDownRefreshState<T> extends State<PullDownRefresh<T>> {
  /// 数据
  T? list;
  /// 列表是否为空
  bool isNoData = true;

  bool enableLoad = false;

  String err = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _handleError(dynamic e){
    String? message;
    widget.controller.refreshFailed();
    if (e is SocketException) {
      message = 'network.error'.i18n;
      logger.e(message, e);
    } else if (e is RpcCallException) {
      if (e.code == 401) {
        Nav.login();
      } else if(e.code == 600) {
        String language = LocalStorage.getLocale()?.languageCode ?? 'zh';
        message = e.fault?.variables[language];
      } else {
        message = e.message.i18n;
        logger.e(message, e);
      }
    } else if (e is HttpCallException) {
      message = 'http.error'.i18n;
      logger.e(message, e);
    } else if (e is TimeoutException) {
      message = 'request.timeout'.i18n;
      logger.e(message, e);
    } else {
      message = 'request.error'.i18n;
      logger.e(message, e);
    }
    if (message != null) {
      err = message;
      Chili.showToast(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: widget.controller,
      enablePullDown: true,
      enablePullUp: enableLoad,
      header: WaterDropMaterialHeader(
        color: Color(0xFFFF9F21),
      ),
      footer: ClassicFooter(
        noDataText: widget.noMoreDataText ?? "--没有更多的数据--",
        loadingIcon: CupertinoActivityIndicator(),
      ),
      onRefresh: () {
        widget.controller.loadComplete();
        err = '';
        widget.pageable.page = 1;
        widget.future(widget.pageable).then((value) {
          list = value;
          widget.controller.refreshCompleted();
          if(mounted) {
            setState(() {
              if ((list as List).isEmpty) {
                isNoData = true;
                enableLoad = false;
              } else {
                isNoData = false;
                enableLoad = true;
              }
            });
          }
        }).catchError((e) {
         _handleError(e);
        });
      },
      onLoading: () {
        widget.pageable.page = widget.pageable.page! + 1;
        widget.future(widget.pageable).then((value) {
          if ((value as List).isEmpty) {
            widget.controller.loadNoData();
          } else {
            if(mounted) setState(() {(list as List).addAll(value);});
            widget.controller.loadComplete();
          }
        }).catchError((err) {
          _handleError(err);
          widget.controller.loadFailed();
        });
      },
      child: isNoData ? Center(
        child: Text(
          err.isNotEmpty ? err : (widget.noDataText ?? '暂无数据'),
          style: TextStyle(color: Color(0xFFBFBFBF)),
        ),
      ) : widget.builder(context, list!)
    );
  }
}


```

## [IntrinsicHeight](http://laomengit.com/flutter/widgets/IntrinsicHeight.html)

将其子控件调整为该子控件的固有高度，举个例子来说，Row中有3个子控件，其中只有一个有高度，默认情况下剩余2个控件将会充满父组件，而使用IntrinsicHeight控件，则3个子控件的高度一致。

## 文字折叠

```dart
class TextWrapper extends StatefulWidget {
  const TextWrapper(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  State<TextWrapper> createState() => _TextWrapperState();
}

class _TextWrapperState extends State<TextWrapper>
    with TickerProviderStateMixin {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedSize(
          vsync: this,
          duration: Duration(microseconds: 300),
          child: ConstrainedBox(
            constraints:
                isExpanded ? BoxConstraints() : BoxConstraints(maxHeight: 70),
            child: Text(
              widget.text,
              style: TextStyle(fontSize: 16),
              softWrap: true,
              overflow: TextOverflow.fade,
            ),
          ),
        ),
        isExpanded
            ? Row(
                // 使用 Row 将 btn 显示在右边，如果不使用 Row，btn 就会显示在左边
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                      onPressed: () {
                        setState(() {
                          isExpanded = false;
                        });
                      },
                      child: Text("隐藏"))
                ],
              )
            : OutlinedButton(
                onPressed: () {
                  setState(() {
                    isExpanded = true;
                  });
                },
                child: Text("显示"))
      ],
    );
  }
}
```



```dart
class TextWrapperPage extends StatelessWidget {
  const TextWrapperPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("显示/折叠"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextWrapper(
                    "【摘要】 食品安全问题关系国计民生,一直是社会各界广泛关注的焦点。基于政策法规、主流期刊、权威媒体的三维视角,首先从\"是什么\"的角度对改革开放四十年以来我国食品安全问题关注重点的变化进行了系统梳理,总体上,我国食品安全问题关注重点的变化轨迹可描绘为\"食品数量安全→食品数量和卫生安全→食品质量安全→食品质量和营养安全\";其次进一步从\"为什么\"的角度剖析不同历史阶段我国食品安全问题关注重点变迁的内在逻辑,揭示导致以上变化的主要驱动因素;最后总结改革开放以来我国食品安全领域的重要成就,指明我国食品安全问题的发展方向。 "),
                Divider(
                  height: 30,
                ),
                TextWrapper(
                    "【摘要】 食品安全问题关系国计民生,一直是社会各界广泛关注的焦点。基于政策法规、主流期刊、权威媒体的三维视角,首先从\"是什么\"的角度对改革开放四十年以来我国食品安全问题关注重点的变化进行了系统梳理,总体上,我国食品安全问题关注重点的变化轨迹可描绘为\"食品数量安全→食品数量和卫生安全→食品质量安全→食品质量和营养安全\";其次进一步从\"为什么\"的角度剖析不同历史阶段我国食品安全问题关注重点变迁的内在逻辑,揭示导致以上变化的主要驱动因素;最后总结改革开放以来我国食品安全领域的重要成就,指明我国食品安全问题的发展方向。 "),
              ],
            ),
          )),
    );
  }
}
```
## 58.简单的单例模式写法
```dart
class TestEventBust {
  static TestEventBust _instance = TestEventBust._init();
  /// 命名构造函数
  TestEventBust._init();
  EventBus _eventBus = EventBus();
  EventBus get bus{
    return _eventBus;
  }
  /// 工厂构造函数
  factory TestEventBust() => _instance;
}
```

## 50.BackdropFilter高斯模糊/毛玻璃效果
Flutter自带的一个ui组件。

注意点：
官方文档：The filter will be applied to all the area within its parent or ancestor widget's clip. If there's no clip, the filter will be applied to the full screen.

译：过滤器将应用于其父控件或祖先控件剪辑中的所有区域。如果没有剪辑，过滤器将应用于全屏。

```dart
Stack(
  fit: StackFit.expand,
  children: <Widget>[
    Text('0' * 10000),
    Center(
      child: ClipRect(  // <-- clips to the 200x200 [Container] below
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(
            sigmaX: 5.0,
            sigmaY: 5.0,
          ),
          child: Container(
            alignment: Alignment.center,
            width: 200.0,
            height: 200.0,
            child: const Text('Hello World'),
          ),
        ),
      ),
    ),
  ],
)
```

## 51.显示SVG格式的Flutter 组件：flutter_svg 
```dart
ListView.builder(
           shrinkWrap: true,
             scrollDirection: Axis.vertical,
             itemCount: countries.length,
             physics: ScrollPhysics(),
             itemBuilder: (context, index){
               final Widget networkSvg = SvgPicture.network(
                   '${countries[index].flag}',
                   fit: BoxFit.fill,
                   semanticsLabel: 'A shark?!',
                   placeholderBuilder: (BuildContext context) => Container(
                       padding: const EdgeInsets.all(30.0),
                       child: const CircularProgressIndicator(
                         backgroundColor: Colors.redAccent,
                       )),);
               return
                 Column(
                   children: [
                     ListTile(
                       title: Text('${countries[index].name}'),
                       leading: CircleAvatar(
                         backgroundColor: Colors.white,
                         child: networkSvg,
                       ),
                     )
                   ],
                 );
             });
```