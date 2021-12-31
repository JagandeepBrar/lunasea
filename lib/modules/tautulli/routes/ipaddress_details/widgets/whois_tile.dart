import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliIPAddressDetailsWHOISTile extends StatelessWidget {
  final TautulliWHOISInfo whois;

  const TautulliIPAddressDetailsWHOISTile({
    Key? key,
    required this.whois,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaTableCard(
      content: [
        LunaTableContent(title: 'host', body: whois.host ?? LunaUI.TEXT_EMDASH),
        ..._subnets(),
      ],
    );
  }

  List<LunaTableContent> _subnets() {
    if (whois.subnets?.isEmpty ?? true) return [];
    return whois.subnets!.fold<List<LunaTableContent>>([], (list, subnet) {
      list.add(LunaTableContent(
        title: 'isp',
        body: [
          subnet.description ?? LunaUI.TEXT_EMDASH,
          '\n\n${subnet.address ?? LunaUI.TEXT_EMDASH}',
          '\n${subnet.city}, ${subnet.state ?? LunaUI.TEXT_EMDASH}',
          '\n${subnet.postalCode ?? LunaUI.TEXT_EMDASH}',
          '\n${subnet.country ?? LunaUI.TEXT_EMDASH}',
        ].join(),
      ));
      return list;
    });
  }
}
