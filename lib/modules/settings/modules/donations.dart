import 'dart:async';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsDonationsRouter extends LunaPageRouter {
    SettingsDonationsRouter() : super('/settings/donations');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsDonationsRoute());
}

class _SettingsDonationsRoute extends StatefulWidget {
    @override
    State<_SettingsDonationsRoute> createState() => _State();
}

class _State extends State<_SettingsDonationsRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    static StreamSubscription<List<PurchaseDetails>> purchaseStream;

    @override
    void initState() {
        super.initState();
        purchaseStream = LunaInAppPurchases.connection.purchaseUpdatedStream.listen(_purchasedCallback);
    }

    @override
    void dispose() {
        purchaseStream?.cancel();
        super.dispose();
    }

    Future<void> _purchasedCallback(List<PurchaseDetails> purchases) async {
        for(var purchase in purchases) {
            if(purchase.pendingCompletePurchase) {
                switch(purchase.status) {
                    case PurchaseStatus.error: _purchaseFailed(); break;
                    case PurchaseStatus.purchased: _purchasedSuccess(); break;
                    default: break;
                }
            }
        }
    }

    void _purchasedSuccess() => SettingsDonationsThankYouRouter().navigateTo(context);

    void _purchaseFailed() => showLunaErrorSnackBar(
        context: context,
        title: 'Transaction Failure',
        message: 'The transaction has failed, please try again',
    );

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LunaAppBar(
        context: context,
        title: 'Donations',
    );

    Widget get _body => LunaInAppPurchases.available && LunaInAppPurchases.products.length != 0
        ? LSListViewBuilder(
            itemCount: LunaInAppPurchases.products.length,
            itemBuilder: (context, index) => _iapTile(LunaInAppPurchases.products[index]),
        )
        : LSGenericMessage(text: 'In-App Purchases Unavailable');

    Widget _iapTile(ProductDetails product) {
        Future<void> _execute() async {
            final PurchaseParam _parameters = PurchaseParam(productDetails: product, sandboxTesting: false);
            await LunaInAppPurchases.connection.buyConsumable(purchaseParam: _parameters, autoConsume: true);
        }
        return LSCardTile(
            title: LSTitle(text: product.ls_Name),
            subtitle: LSSubtitle(text: product.ls_Description),
            trailing: LSIconButton(icon: product.ls_Icon),
            onTap: _execute,
        );
    }
}
