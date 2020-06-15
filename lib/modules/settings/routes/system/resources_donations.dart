import 'dart:async';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

const _MESSAGE = '''Thank you to everyone who has or will support the development of LunaSea!\n
Donations are not required to unlock any features within LunaSea.''';

class SettingsSystemDonations extends StatefulWidget {
    static const ROUTE_NAME = '/settings/system/donations';
    
    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<SettingsSystemDonations> {
    static StreamSubscription<List<PurchaseDetails>> purchaseStream;

    @override
    Widget build(BuildContext context) => Scaffold(
        appBar: LSAppBar(title: 'Donations'),
        body: LSListView(
            children: [
                LSHeader(
                    text: 'Donate to the Developer',
                    subtitle: _MESSAGE),
                if(InAppPurchases.available) ..._optionsAvailable,
                if(!InAppPurchases.available) ..._optionsUnavailable,
            ],
        ),
    );

    @override
    void initState() {
        super.initState();
        purchaseStream = InAppPurchases.connection.purchaseUpdatedStream.listen(_purchasedCallback);
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

    void _purchasedSuccess() => Navigator.of(context).pushNamed(SettingsSystemDonationsThankYou.ROUTE_NAME);

    void _purchaseFailed() => LSSnackBar(
        context: context,
        title: 'Transaction Failure',
        message: 'The transaction has failed, please try again',
        type: SNACKBAR_TYPE.failure,
    );


    List<Widget> get _optionsAvailable => [
        if(InAppPurchases.products.length == 0) ..._optionsUnavailable,
        for(var i =0; i < InAppPurchases.products.length; i++) LSCardTile(
            title: LSTitle(text: InAppPurchases.products[i].ls_Name),
            subtitle: LSSubtitle(text: InAppPurchases.products[i].ls_Description),
            leading: LSIconButton(icon: InAppPurchases.products[i].ls_Icon, color: LSColors.list(i)),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async => await _purchase(InAppPurchases.products[i]),
        ),
    ];

    List<Widget> get _optionsUnavailable => [LSGenericMessage(text: 'In-App Purchases Unavailable')];

    Future<void> _purchase(ProductDetails product) async {
        final PurchaseParam _parameters = PurchaseParam(productDetails: product, sandboxTesting: false);
        await InAppPurchases.connection.buyConsumable(purchaseParam: _parameters, autoConsume: true);
    }
}
