import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:lunasea/core.dart';

extension ProductDetailsExtension on ProductDetails {
    IconData get lunaIcon {
        switch(this.id) {
            case LunaInAppPurchases.IAP_ID_DONATION_01: return Icons.local_drink;
            case LunaInAppPurchases.IAP_ID_DONATION_03: return Icons.local_cafe;
            case LunaInAppPurchases.IAP_ID_DONATION_05: return Icons.local_bar;
            case LunaInAppPurchases.IAP_ID_DONATION_10: return Icons.fastfood;
            case LunaInAppPurchases.IAP_UPGRADE_PRO: return Icons.upgrade;
            default: return Icons.attach_money;
        }
    }

    String get lunaName {
        switch(this.id) {
            case LunaInAppPurchases.IAP_ID_DONATION_01: return 'Buy Me A Soda';
            case LunaInAppPurchases.IAP_ID_DONATION_03: return 'Buy Me A Coffee';
            case LunaInAppPurchases.IAP_ID_DONATION_05: return 'Buy Me A Beer';
            case LunaInAppPurchases.IAP_ID_DONATION_10: return 'Buy Me A Burger';
            case LunaInAppPurchases.IAP_UPGRADE_PRO: return 'Upgrade to LunaSea Pro';
            default: return 'Unknown In-App Purchase';
        }
    }

    String get lunaDescription => '${this.price}';
}
