import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:lunasea/core.dart';

extension ProductDetailsExtension on ProductDetails {
    //ignore: non_constant_identifier_names
    IconData get ls_Icon {
        switch(this.id) {
            case InAppPurchases.IAP_ID_DONATION_01: return Icons.local_drink;
            case InAppPurchases.IAP_ID_DONATION_03: return Icons.local_cafe;
            case InAppPurchases.IAP_ID_DONATION_05: return Icons.local_bar;
            case InAppPurchases.IAP_ID_DONATION_10: return Icons.fastfood;
            default: return Icons.attach_money;
        }
    }

    //ignore: non_constant_identifier_names
    String get ls_Name {
        switch(this.id) {
            case InAppPurchases.IAP_ID_DONATION_01: return 'Buy Me A Soda';
            case InAppPurchases.IAP_ID_DONATION_03: return 'Buy Me A Coffee';
            case InAppPurchases.IAP_ID_DONATION_05: return 'Buy Me A Beer';
            case InAppPurchases.IAP_ID_DONATION_10: return 'Buy Me A Burger';
            default: return 'Unknown In-App Purchase';
        }
    }

    //ignore: non_constant_identifier_names
    String get ls_Description => '${this.price}';
}