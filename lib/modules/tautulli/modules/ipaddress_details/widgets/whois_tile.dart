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
            LSTableContent(title: 'host', body: whois.host),
            ...whois.subnets.fold<List<LSTableContent>>([], (list, subnet) {
                list.add(LSTableContent(
                    title: 'isp',
                    body: [
                        subnet.description,
                        '\n\n${subnet.address}',
                        '\n${subnet.city}, ${subnet.state}',
                        '\n${subnet.postalCode}',
                        '\n${subnet.country}',
                    ].join(),
                ));
                return list;
            }),
        ],
    );
}
