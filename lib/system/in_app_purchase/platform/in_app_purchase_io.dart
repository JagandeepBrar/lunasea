import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:lunasea/core/state/state.dart';
import 'package:lunasea/modules/settings/routes/donations/pages/thank_you.dart';
import 'package:lunasea/system/in_app_purchase/purchase_option.dart';
import 'package:lunasea/system/in_app_purchase/in_app_purchase.dart';
import 'package:lunasea/system/logger.dart';
import 'package:lunasea/system/platform.dart';
import 'package:lunasea/vendor.dart';
import 'package:lunasea/widgets/ui.dart';

bool isPlatformSupported() {
  return LunaPlatform.isMobile;
}

LunaInAppPurchase getInAppPurchase() {
  if (LunaPlatform.isMobile) return _Mobile();
  throw UnsupportedError('LunaInAppPurchase unsupported');
}

class _Mobile implements LunaInAppPurchase {
  static StreamSubscription<List<PurchaseDetails>>? _purchaseStream;

  static Future<void> _purchaseCallback(List<PurchaseDetails> purchases) async {
    for (final purchase in purchases) {
      if (purchase.pendingCompletePurchase) {
        await InAppPurchase.instance.completePurchase(purchase);

        switch (purchase.status) {
          case PurchaseStatus.error:
            showLunaErrorSnackBar(
              title: 'lunasea.TransactionFailure'.tr(),
              message: 'lunasea.PleaseTryAgain'.tr(),
            );
            break;
          case PurchaseStatus.purchased:
            final context = LunaState.navigatorKey.currentContext!;
            SettingsDonationsThankYouRouter().navigateTo(context);
            break;
          default:
            break;
        }
      }
    }
  }

  InAppPurchase get _instance => InAppPurchase.instance;

  @override
  Future<void> initialize() async {
    final available = await isAvailable();
    if (available) {
      _purchaseStream = _instance.purchaseStream.listen(_purchaseCallback);
      await getOptions();
    } else {
      LunaLogger().debug('In-app purchasing disabled - unavailable');
    }
  }

  @override
  Future<void> deinitialize() async {
    await _purchaseStream?.cancel();
  }

  @override
  Future<bool> isAvailable() async {
    return _instance.isAvailable();
  }

  @override
  Future<List<PurchaseOption>> getOptions() async {
    final keys = Set<String>.from(PurchaseOption.keys);
    final query = await _instance.queryProductDetails(keys);

    final donations =
        query.productDetails.map((p) => p.toPurchaseOption()!).toList();
    donations.sort((a, b) => a.key.compareTo(b.key));
    return donations;
  }

  @override
  Future<void> purchaseOption(PurchaseOption option) async {
    final params = PurchaseParam(productDetails: option.product!);
    await _instance.buyConsumable(purchaseParam: params, autoConsume: true);
  }
}
