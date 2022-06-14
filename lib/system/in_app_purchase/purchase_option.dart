import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:lunasea/system/logger.dart';
import 'package:lunasea/vendor.dart';

const _DONATION_01_KEY = 'donation_01';
const _DONATION_03_KEY = 'donation_03';
const _DONATION_05_KEY = 'donation_05';
const _DONATION_10_KEY = 'donation_10';

class PurchaseOption {
  final String key;
  final String title;
  final IconData icon;
  final ProductDetails? product;

  static List<String> get keys {
    return [
      _DONATION_01_KEY,
      _DONATION_03_KEY,
      _DONATION_05_KEY,
      _DONATION_10_KEY,
    ];
  }

  PurchaseOption._({
    required this.key,
    required this.icon,
    required this.title,
    this.product,
  });

  factory PurchaseOption.donation01(ProductDetails? product) {
    return PurchaseOption._(
      key: _DONATION_01_KEY,
      product: product,
      icon: Icons.local_drink_rounded,
      title: 'lunasea.BuyMeASoda'.tr(),
    );
  }

  factory PurchaseOption.donation03(ProductDetails? product) {
    return PurchaseOption._(
      key: _DONATION_03_KEY,
      product: product,
      icon: Icons.local_cafe_rounded,
      title: 'lunasea.BuyMeACoffee'.tr(),
    );
  }

  factory PurchaseOption.donation05(ProductDetails? product) {
    return PurchaseOption._(
      key: _DONATION_05_KEY,
      product: product,
      icon: Icons.local_bar_rounded,
      title: 'lunasea.BuyMeABeer'.tr(),
    );
  }

  factory PurchaseOption.donation10(ProductDetails? product) {
    return PurchaseOption._(
      key: _DONATION_10_KEY,
      product: product,
      icon: Icons.fastfood_rounded,
      title: 'lunasea.BuyMeABurger'.tr(),
    );
  }
}

extension ProductDetailsExtension on ProductDetails {
  PurchaseOption? toPurchaseOption() {
    switch (this.id) {
      case _DONATION_01_KEY:
        return PurchaseOption.donation01(this);
      case _DONATION_03_KEY:
        return PurchaseOption.donation03(this);
      case _DONATION_05_KEY:
        return PurchaseOption.donation05(this);
      case _DONATION_10_KEY:
        return PurchaseOption.donation10(this);
      default:
        LunaLogger().warning('Unknown id: ${this.id}');
        return null;
    }
  }
}
