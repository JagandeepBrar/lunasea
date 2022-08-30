import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/system/in_app_purchase/purchase_option.dart';
import 'package:lunasea/system/in_app_purchase/in_app_purchase.dart';

class DonationsRoute extends StatefulWidget {
  const DonationsRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<DonationsRoute> createState() => _State();
}

class _State extends State<DonationsRoute> with LunaScrollControllerMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _donationOptions = LunaInAppPurchase().getOptions();

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar() as PreferredSizeWidget?,
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
    return FutureBuilder(
      future: _donationOptions,
      builder: (context, AsyncSnapshot<List<PurchaseOption>> snapshot) {
        if (snapshot.hasData) {
          return LunaListViewBuilder(
            controller: scrollController,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) => _tile(snapshot.data![index]),
          );
        } else {
          return LunaMessage.goBack(
            context: context,
            text: 'Not Available',
          );
        }
      },
    );
  }

  Widget _tile(PurchaseOption option) {
    return LunaBlock(
      title: option.title,
      body: [TextSpan(text: option.product!.price)],
      trailing: LunaIconButton(icon: option.icon),
      onTap: () async => LunaInAppPurchase().purchaseOption(option),
    );
  }
}
