# App更新

## 插件：安卓内部更新

  **ota_update: 2.4.1**

```dart
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

```dart
import 'dart:io';

import 'package:com.qianjinshijue.app/base/common/commonInsert.dart';
import 'package:com.qianjinshijue.app/network/Address.dart';
import 'package:com.qianjinshijue.app/network/model/application_find_latest_entity.dart';
import 'package:ota_update/ota_update.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateApp extends StatefulWidget{
  final ApplicationFindLatestData data;

  const UpdateApp({Key key, this.data}) : super(key: key);
  @override
  _UpdateAppState createState() => _UpdateAppState();
}

class _UpdateAppState extends State<UpdateApp>{
  String progress;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: (){
        return Future.value(false);
      },
      child: Material(
        color: MyColors.transparent,
        child: Center(
          child: Container(
            height: 200,
            width: MediaQuery.of(context).size.width - 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white),
            child: progress==null?Column(
              children: [
                SizedBox(
                  height: 24,
                ),
                Text(
                  "发现新版本V${widget.data?.name ?? ""}",
                  style: TextStyle(
                      fontSize: 17,
                      color: MyColors.text_font_35,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: Text(
                    "${widget.data?.description ?? ""}",
                    style: TextStyle(fontSize: 12, color: MyColors.grey_66),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  height: 1,
                  color: MyColors.divider_dd,
                ),
                Container(
                  height: 46,
                  child: !widget.data.optional?Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        child: Text(
                          '以后再说',
                          style: TextStyle(
                              fontSize: 17, color: MyColors.grey_33),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      Container(
                        width: 1,
                        height: 34,
                        color: MyColors.divider_dd,
                      ),
                      InkWell(
                        child: Text(
                          '立即升级',
                          style: TextStyle(
                              fontSize: 17, color: MyColors.grey_F16),
                        ),
                        onTap: () {
                          _updateVersion();
                        },
                      )
                    ],
                  ):InkWell(
                    child: Center(
                      child: Container(
                        height: 34,
                        child: Text(
                          '立即升级',
                          style: TextStyle(
                              fontSize: 17, color: MyColors.grey_F16),
                        ),
                      ),
                    ),
                    onTap: () {
                      _updateVersion();
                    },
                  ),
                )
              ],
            ):
            Center(
              child: Text(progress??''),
            ),
          ),
        ),
      ),
    );
  }

  void _updateVersion() async{
    if (Platform.isIOS){
      String url = '${Address.BASE_ATTACHMENT}${widget.data.url}'; // 这是微信的地址，到时候换成自己的应用的地址
      if (await canLaunch(url)){
        await launch(url);
      }else {
        throw 'Could not launch $url';
      }
    }else if (Platform.isAndroid){
      String url = '${Address.BASE_ATTACHMENT}${widget.data.url}';
      print('下载的链接：${Address.BASE_ATTACHMENT}${widget.data.url}');
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
}
```

