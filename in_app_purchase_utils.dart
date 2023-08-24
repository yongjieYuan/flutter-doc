import 'dart:async';
import 'dart:io';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:flutter/cupertino.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

/// 适用于ios端的内购处理方法
class InAppPurchaseUtils {
  late final InAppPurchase _inAppPurchase;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  late final Stream<List<PurchaseDetails>> purchaseUpdated;
  /// 产品id
  static const List<String> productIds = [];
  List<ProductDetails> _products = <ProductDetails>[];

  /// 初始化
  InAppPurchaseUtils.init() {
    _inAppPurchase = InAppPurchase.instance;
    purchaseUpdated = _inAppPurchase.purchaseStream;
    initStoreInfo();
  }

  /// 查询产品信息
  /// 返回的数据类型是ProductDetailsResponse
  /// 获取详细的产品数据：productDetailResponse.productDetails
  /// Example:
  /// if (productDetailResponse.error != null) {
  //       setState(() {
  //         _queryProductError = productDetailResponse.error!.message;
  //         _isAvailable = isAvailable;
  //         _products = productDetailResponse.productDetails;
  //         _purchases = <PurchaseDetails>[];
  //         _notFoundIds = productDetailResponse.notFoundIDs;
  //         _consumables = <String>[];
  //         _purchasePending = false;
  //         _loading = false;
  //       });
  //       return;
  //     }
  Future<ProductDetailsResponse> queryProductDetails() async{
    return await _inAppPurchase.queryProductDetails(productIds.toSet());
  }

  List<ProductDetails> get products => _products;

  /// 初始化商品（ios端，未集成Android）
  Future<void> initStoreInfo() async{
    if(await isAvailable) {
      if (Platform.isIOS) {
        final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
        _inAppPurchase
            .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
        await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
      }
      queryProductDetails().then((value) {
        if(value.error != null) {
          _products = value.productDetails;
        }
      });
    }
  }

  /// 内购监听
  void addPurchaseListener({required PurchaseListener listener, ValueChanged? onError}) {
    _subscription = purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList, listener: listener);
    },onDone: (){
      _subscription.cancel();
    },onError: (Object err){
      if(onError != null) onError(err);
    });
  }

  /// 购买消耗产品（金币）
  void buyConsumable(ProductDetails productDetails){
    if(Platform.isIOS) {
      _inAppPurchase.buyConsumable(purchaseParam: PurchaseParam(productDetails: productDetails));
    }
  }

  /// 订阅
  void buyNonConsumable(ProductDetails productDetails){
    if(Platform.isIOS) {
      _inAppPurchase.buyNonConsumable(purchaseParam: PurchaseParam(productDetails: productDetails));
    }
  }

  /// 处理内购
  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList, {required PurchaseListener listener}) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        if(listener.onPending != null) listener.onPending!();
        // showPendingUI();
      } else {
        if(listener.onPendingComplete != null) listener.onPendingComplete!();
        if (purchaseDetails.status == PurchaseStatus.error) {
          if(listener.onError != null) listener.onError!(purchaseDetails.error);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          listener.onPurchased(purchaseDetails);
          // final bool valid = await _verifyPurchase(purchaseDetails);
          // if (valid) {
          //   deliverProduct(purchaseDetails);
          // } else {
          //   _handleInvalidPurchase(purchaseDetails);
          //   return;
          // }
        }
        // if (Platform.isAndroid) {
        //   if (!_kAutoConsume && purchaseDetails.productID == _kConsumableId) {
        //     final InAppPurchaseAndroidPlatformAddition androidAddition =
        //     _inAppPurchase.getPlatformAddition<
        //         InAppPurchaseAndroidPlatformAddition>();
        //     await androidAddition.consumePurchase(purchaseDetails);
        //   }
        // }
        if (purchaseDetails.pendingCompletePurchase) {
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    }
  }

  /// 内购服务是否可用
  Future<bool> get isAvailable async => await _inAppPurchase.isAvailable();

  /// 取消内购服务监听
  /// dispose 时可调用
  void cancel(){
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
      _inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
    _subscription.cancel();
  }
}

class PurchaseListener {
  /// 等待
  VoidCallback? onPending;
  ValueChanged? onError;
  /// 购买事件
  late ValueChanged<PurchaseDetails> onPurchased;
  ///等待结束
  VoidCallback? onPendingComplete;
  PurchaseListener({required this.onPurchased,this.onPending,this.onError,this.onPendingComplete});
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