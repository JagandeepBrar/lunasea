import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

extension ProductDetailsExtension on ProductDetails {
  /// Returns [IconData] icon corresponding to the IAP
  IconData get lunaIcon {
    switch (this.id) {
      case LunaInAppPurchases.DONATION_01:
        return Icons.local_drink_rounded;
      case LunaInAppPurchases.DONATION_03:
        return Icons.local_cafe_rounded;
      case LunaInAppPurchases.DONATION_05:
        return Icons.local_bar_rounded;
      case LunaInAppPurchases.DONATION_10:
        return Icons.fastfood_rounded;
      default:
        return Icons.attach_money_rounded;
    }
  }

  /// Returns a readable name for the corresponding IAP
  String get lunaName {
    switch (this.id) {
      case LunaInAppPurchases.DONATION_01:
        return 'Buy Me A Soda';
      case LunaInAppPurchases.DONATION_03:
        return 'Buy Me A Coffee';
      case LunaInAppPurchases.DONATION_05:
        return 'Buy Me A Beer';
      case LunaInAppPurchases.DONATION_10:
        return 'Buy Me A Burger';
      default:
        return 'Unknown In-App Purchase';
    }
  }
}
