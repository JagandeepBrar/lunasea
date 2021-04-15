import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

extension ProductDetailsExtension on ProductDetails {
    /// Returns [IconData] icon corresponding to the IAP
    IconData get lunaIcon {
        switch(id) {
            case LunaInAppPurchases.DONATION_01: return Icons.local_drink;
            case LunaInAppPurchases.DONATION_03: return Icons.local_cafe;
            case LunaInAppPurchases.DONATION_05: return Icons.local_bar;
            case LunaInAppPurchases.DONATION_10: return Icons.fastfood;
            default: return Icons.attach_money;
        }
    }

    /// Returns a readable name for the corresponding IAP
    String get lunaName {
        switch(id) {
            case LunaInAppPurchases.DONATION_01: return 'Buy Me A Soda';
            case LunaInAppPurchases.DONATION_03: return 'Buy Me A Coffee';
            case LunaInAppPurchases.DONATION_05: return 'Buy Me A Beer';
            case LunaInAppPurchases.DONATION_10: return 'Buy Me A Burger';
            default: return 'Unknown In-App Purchase';
        }
    }
}
