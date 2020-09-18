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
    Widget build(BuildContext context) => LSCard(
        child: Padding(
            child: Column(
                children: [
                    _content('host', whois.host),
                    ...whois.subnets.fold<List<Widget>>([], (list, subnet) {
                        list.add(_content('isp', [
                            subnet.description,
                            '\n\n${subnet.address}',
                            '\n${subnet.city}, ${subnet.state}',
                            '\n${subnet.postalCode}',
                            '\n${subnet.country}',
                        ].join()));
                        return list;
                    }),
                ],
            ),
            padding: EdgeInsets.symmetric(vertical: 8.0),
        ),
    );

    Widget _content(String header, String body) => Padding(
        child: Row(
            children: [
                Expanded(
                    child: Text(
                        header.toUpperCase(),
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                        ),
                    ),
                    flex: 2,
                ),
                Container(width: 16.0, height: 0.0),
                Expanded(
                    child: Text(
                        body,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                        ),
                    ),
                    flex: 5,
                ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
    );
}