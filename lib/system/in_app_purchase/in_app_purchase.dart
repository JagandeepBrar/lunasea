// ignore: always_use_package_imports
import 'package:lunasea/system/in_app_purchase/purchase_option.dart';

// ignore: always_use_package_imports
import 'platform/in_app_purchase_stub.dart'
    if (dart.library.io) 'platform/in_app_purchase_io.dart'
    if (dart.library.html) 'platform/in_app_purchase_html.dart';

abstract class LunaInAppPurchase {
  static bool get isSupported => isPlatformSupported();
  factory LunaInAppPurchase() => getInAppPurchase();

  Future<void> initialize();
  Future<void> deinitialize();
  Future<bool> isAvailable();
  Future<List<PurchaseOption>> getOptions();
  Future<void> purchaseOption(PurchaseOption option);
}
