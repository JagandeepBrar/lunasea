import 'dart:async';
import 'package:in_app_purchase/in_app_purchase.dart';

class InAppPurchases {
    static const IAP_ID_DONATION_01 = 'donation_01';
    static const IAP_ID_DONATION_03 = 'donation_03';
    static const IAP_ID_DONATION_05 = 'donation_05';
    static const IAP_ID_DONATION_10 = 'donation_10';
    
    static const IAP_IDS = [
        IAP_ID_DONATION_01,
        IAP_ID_DONATION_03,
        IAP_ID_DONATION_05,
        IAP_ID_DONATION_10,
    ];

    static final InAppPurchaseConnection connection = InAppPurchaseConnection.instance;
    static StreamSubscription<List<PurchaseDetails>> purchaseStream;
    static List<ProductDetails> products = [];
    static bool available = true;
    
    static Future<void> initialize() async {
        InAppPurchaseConnection.enablePendingPurchases();
        purchaseStream = connection.purchaseUpdatedStream.listen((data) => InAppPurchases._purchasedCallback(data));
        available = await connection.isAvailable();
        ProductDetailsResponse _resp = await connection.queryProductDetails(Set.from(IAP_IDS));
        products = _resp.productDetails;
        products.sort((a, b) => a.id.compareTo(b.id));
    }

    static Future<void> deinitialize() async {
        purchaseStream?.cancel();
    }

    static Future<void> _purchasedCallback(List<PurchaseDetails> purchases) async {
        for(var purchase in purchases) {
            if(purchase.pendingCompletePurchase) await connection.completePurchase(purchase);
        }
    }
}

