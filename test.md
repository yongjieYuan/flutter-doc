```dart
GestureDetector(
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
                                      imageUrl: '${Global.serviceUrl}${_shopList[index].thumbnail}',
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
```

