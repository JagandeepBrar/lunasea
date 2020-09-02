import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:lunasea/core.dart';

class SettingsDonationsIAPTile extends StatelessWidget {
    final ProductDetails product;

    SettingsDonationsIAPTile({
        Key key,
        @required this.product,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: product.ls_Name),
        subtitle: LSSubtitle(text: product.ls_Description),
        trailing: LSIconButton(icon: product.ls_Icon),
        onTap: () async => await _purchase(),
    );

    Future<void> _purchase() async {
        final PurchaseParam _parameters = PurchaseParam(productDetails: product, sandboxTesting: false);
        await InAppPurchases.connection.buyConsumable(purchaseParam: _parameters, autoConsume: true);
    }
}