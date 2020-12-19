import 'dart:async';
import 'package:in_app_purchase/in_app_purchase.dart';

class LunaInAppPurchases {
    // Donation IAP IDs
    static const IAP_ID_DONATION_01 = 'donation_01';
    static const IAP_ID_DONATION_03 = 'donation_03';
    static const IAP_ID_DONATION_05 = 'donation_05';
    static const IAP_ID_DONATION_10 = 'donation_10';
    static const IAP_DONATION_IDS = [
        IAP_ID_DONATION_01,
        IAP_ID_DONATION_03,
        IAP_ID_DONATION_05,
        IAP_ID_DONATION_10,
    ];

    // Upgrade IAP IDs
    static const IAP_UPGRADE_PRO = 'upgrade_01';
    static const IAP_UPGRADE_IDS = [
        IAP_UPGRADE_PRO,
    ];

    static InAppPurchaseConnection get connection => InAppPurchaseConnection.instance;
    static StreamSubscription<List<PurchaseDetails>> _purchaseStream;
    static List<ProductDetails> donationIAPs = [];
    static List<ProductDetails> upgradeIAPs = [];
    static bool isAvailable = false;
    
    /// Initialize the in-app purchases connection.
    /// 
    /// - Enables pending purchase
    /// - Attach [InAppPurchaseConnection.instance.purchaseUpdateStream] listener for automatically completing IAP purchases
    /// - Fetch and store donation IAPs
    static Future<void> initialize() async {
        InAppPurchaseConnection.enablePendingPurchases();
        isAvailable = await connection.isAvailable();
        if(isAvailable) {
            // Open listener
            _purchaseStream = connection.purchaseUpdatedStream.listen((data) => LunaInAppPurchases._purchasedCallback(data));
            // Load donation IAPs
            ProductDetailsResponse donation = await connection.queryProductDetails(Set.from(IAP_DONATION_IDS));
            donationIAPs = donation?.productDetails ?? [];
            donationIAPs.sort((a, b) => a?.id?.compareTo(b?.id) ?? 0);
            // Load upgrade IAPs
            ProductDetailsResponse upgrade = await connection.queryProductDetails(Set.from(IAP_UPGRADE_IDS));
            upgradeIAPs = upgrade?.productDetails ?? [];
            upgradeIAPs.sort((a, b) => a?.id?.compareTo(b?.id) ?? 0);
        }
    }

    /// Deinitialize the in-app purchases connection.
    /// 
    /// - Cleanly cancel/close the [InAppPurchaseConnection.instance.purchaseUpdateStream] listener
    static Future<void> deinitialize() async => _purchaseStream?.cancel();

    /// Callback function for [purchaseUpdatedStream].
    /// 
    /// **Donations**:
    /// - Automatically completes the purchase, as there is no actual product to deliver
    /// 
    /// **Account Upgrade**:
    /// - Create a listener to the user's account in Firestore
    /// - Upgrade their account
    /// - Validate upgrade
    /// - Mark as completed, close listener
    static Future<void> _purchasedCallback(List<PurchaseDetails> purchases) async {
        for(var purchase in purchases) {
            /// Handle donations by always completing the purchase
            if(IAP_DONATION_IDS.contains(purchase.productID)) {
                if(purchase.pendingCompletePurchase) await connection.completePurchase(purchase);
            }
            /// Handle account upgrades
            if(IAP_UPGRADE_IDS.contains(purchase.productID)) {}
        }
    }
}
