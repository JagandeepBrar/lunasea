import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:tautulli/tautulli.dart';

class TautulliIPAddressDetailsWHOISTile extends StatelessWidget {
    final TautulliWHOISInfo whois;

    TautulliIPAddressDetailsWHOISTile({
        Key key,
        @required this.whois,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) => LSTableBlock(
        title: 'Connection Details',
        children: [
            LSTableContent(title: 'host', body: whois?.host ?? Constants.TEXT_EMDASH),
            ...whois?.subnets?.fold<List<LSTableContent>>([], (list, subnet) {
                list.add(LSTableContent(
                    title: 'isp',
                    body: [
                        subnet?.description ?? Constants.TEXT_EMDASH,
                        '\n\n${subnet?.address ?? Constants.TEXT_EMDASH}',
                        '\n${subnet?.city}, ${subnet?.state ?? Constants.TEXT_EMDASH}',
                        '\n${subnet?.postalCode ?? Constants.TEXT_EMDASH}',
                        '\n${subnet?.country ?? Constants.TEXT_EMDASH}',
                    ].join(),
                ));
                return list;
            }),
        ],
    );
}
