import 'dart:async';

import 'package:flutter/material.dart';
import 'package:chili/chili.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:talent_era_interview/models/invoice.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:flutter/services.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';

class MemberPurchaseByApple extends StatefulWidget {
  final int id;
  final double price;
  final Invoice invoice;
  MemberPurchaseByApple({required this.id,required this.price,required this.invoice});
  @override
  _MemberPurchaseByAppleState createState() => _MemberPurchaseByAppleState();
}

class _MemberPurchaseByAppleState extends State<MemberPurchaseByApple> {


  final InAppPurchase _inAppPurchase = InAppPurchase.instance;

  /// apple 内购产品
  Set<String> _appleProducts = Set();

  /// 内购产品
  List<ProductDetails> _products = [];

  /// 内购监听事件
  late StreamSubscription<List<PurchaseDetails>> _subscription;

  /// 内购支付是否可用
  late final bool _available;

  // 监听内购支付
  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      print('支付status：${purchaseDetails.status}');
      if (purchaseDetails.status == PurchaseStatus.pending) {
        Chili.showToast('loading'.i18n);
        Future.delayed(Duration(seconds: 1),(){
          Chili.showLoading();
        });
        // _showPendingUI();
      }else if(purchaseDetails.status == PurchaseStatus.canceled){
        await InAppPurchase.instance.completePurchase(purchaseDetails);
        Chili.dismissLoading();
        Chili.showToast('取消支付');
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          Chili.showToast('pay_fail'.i18n);
          Chili.dismissLoading();
          // _handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          print('内购支付参数');
          print(purchaseDetails.verificationData.serverVerificationData);
          print(purchaseDetails.purchaseID);
          print(purchaseDetails.transactionDate);
          print(purchaseDetails.productID);
          // JobService.appRechargeVerify(
          //     id: orderId, orderType: 1,key: purchaseDetails.verificationData.serverVerificationData)
          //     .then((e) {
          //   print('##################');
          //   print(e);
          //   Nav.pop(true);
          // });
          Chili.dismissLoading();
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await InAppPurchase.instance.completePurchase(purchaseDetails);
        }
      }
    });
  }

  /// 初始化内购商品
  Future<void> initStoreInfo() async {
    Future.delayed(const Duration(seconds: 0), () {
      Chili.showLoading();
    });
    _available = await InAppPurchase.instance.isAvailable();

    final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
    _inAppPurchase
        .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
    await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());

    final ProductDetailsResponse response = await InAppPurchase.instance
        .queryProductDetails(_appleProducts);
    if (response.notFoundIDs.isNotEmpty && _available) {
      Chili.showToast('暂无此内购产品');
      // Handle the error.
    }
    Chili.dismissLoading();
    _products = response.productDetails;
    print('ios的商品-------${_products[0].price}');
  }

  /// 苹果支付
  void _applePay() {
    if (!_available) {
      Chili.showToast('not_support_apple_pay'.i18n);
      return;
    }
    if (_products.isEmpty) {
      Chili.showToast('暂无此内购产品');
      return;
    }
    final PurchaseParam purchaseParam =
    PurchaseParam(productDetails: _products[0]);
    try {
      InAppPurchase.instance.buyConsumable(purchaseParam: purchaseParam);
    }on PlatformException catch(e) {

    }
  }

  @override
  void initState() {
    super.initState();
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        InAppPurchase.instance.purchaseStream;
    _subscription =
        purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
          _listenToPurchaseUpdated(purchaseDetailsList);
        }, onDone: () {
          _subscription.cancel();
        }, onError: (Object error) {
          Chili.showToast('Something error occured');
          // handle error here.
        });
    print('id----${widget.id.toString()}');

    _appleProducts.add(widget.id.toString());

    initStoreInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff00C9C8),
        leading: IconButton(
          onPressed: () {
            Nav.pop();
          },
          icon: Image.asset(
            'nav_ic_back_white'.webp,
            width: 24,
            height: 24,
          ),
        ),
        title: Text(
          '会员购买',
          style: TextStyle(fontSize: 17, color: Color(0xffFFFFFF)),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 16,right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //支付宝支付
                Container(
                  padding: EdgeInsets.only(top: 12,bottom: 12),
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1,color: Color(0xffE1E4E8)))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset('pay_ic_zhifubao'.webp,width: 32,height: 32,),
                          SizedBox(width: 12,),
                          Text(
                            '苹果支付',
                            style: TextStyle(fontSize: 14,color: Color(0xff333333)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 8,bottom: 10),
                  child: Text(
                    '需支付：￥${widget.price}',
                    style:
                    TextStyle(fontSize: 12, color: Color(0xff999999)),
                  ),
                ),
              ],
            ),
          ),
          //按钮
          Container(
            width: double.infinity,
            height: 44,
            margin: EdgeInsets.only(top: 50, right: 30, left: 30),
            decoration: BoxDecoration(
              color: Color(0xff00C9C8),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: TextButton(
              onPressed: () {
                _applePay();
              },
              child: Text(
                '支付',
                style:
                TextStyle(fontSize: 16, color: Color(0xffFFFFFF)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
      SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}