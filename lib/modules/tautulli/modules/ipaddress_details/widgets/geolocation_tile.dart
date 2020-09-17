import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:tautulli/tautulli.dart';

class TautulliIPAddressDetailsGeolocationTile extends StatelessWidget {
    final TautulliGeolocationInfo geolocation;

    TautulliIPAddressDetailsGeolocationTile({
        Key key,
        @required this.geolocation,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) => LSCard(
        child: Padding(
            child: Column(
                children: [
                    _content('country', geolocation.country),
                    _content('region', geolocation.region),
                    _content('city', geolocation.city),
                    _content('postal', geolocation.postalCode),
                    _content('timezone', geolocation.timezone),
                    _content('latitude', '${geolocation.latitude}'),
                    _content('longitude', '${geolocation.longitude}'),
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