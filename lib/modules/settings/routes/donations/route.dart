import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsDonationsRouter extends SettingsPageRouter {
  SettingsDonationsRouter() : super('/settings/donations');

  @override
  _Widget widget() => _Widget();

  @override
  void defineRoute(FluroRouter router) =>
      super.noParameterRouteDefinition(router);
}

class _Widget extends StatefulWidget {
  @override
  State<_Widget> createState() => _State();
}

class _State extends State<_Widget> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static StreamSubscription<List<PurchaseDetails>> purchaseStream;

  @override
  void initState() {
    super.initState();
    if (LunaInAppPurchases.isAvailable) {
      purchaseStream = LunaInAppPurchases.connection.purchaseStream
          .listen(_purchasedCallback);
    }
  }

  @override
  void dispose() {
    purchaseStream?.cancel();
    super.dispose();
  }

  Future<void> _purchasedCallback(List<PurchaseDetails> purchases) async {
    for (var purchase in purchases) {
      if (purchase.pendingCompletePurchase) {
        switch (purchase.status) {
          case PurchaseStatus.error:
            _purchaseFailed();
            break;
          case PurchaseStatus.purchased:
            _purchasedSuccess();
            break;
          default:
            break;
        }
      }
    }
  }

  void _purchasedSuccess() =>
      SettingsDonationsThankYouRouter().navigateTo(context);

  void _purchaseFailed() => showLunaErrorSnackBar(
        title: 'Transaction Failure',
        message: 'The transaction has failed, please try again',
      );

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar(),
      body: _body(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'Donations',
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    if (!LunaInAppPurchases.isAvailable ||
        (LunaInAppPurchases.donationIAPs?.length ?? 0) == 0)
      return LunaMessage.goBack(
        context: context,
        text: 'Not Available',
      );
    return LunaListViewBuilder(
      controller: scrollController,
      itemCount: LunaInAppPurchases.donationIAPs.length,
      itemBuilder: (context, index) =>
          _iapTile(LunaInAppPurchases.donationIAPs[index]),
    );
  }

  Widget _iapTile(ProductDetails product) {
    return LunaBlock(
      title: product.lunaName,
      body: [TextSpan(text: product.price)],
      trailing: LunaIconButton(icon: product.lunaIcon),
      onTap: () async {
        final PurchaseParam _parameters = PurchaseParam(
          productDetails: product,
        );
        await LunaInAppPurchases.connection.buyConsumable(
          purchaseParam: _parameters,
          autoConsume: true,
        );
      },
    );
  }
}
