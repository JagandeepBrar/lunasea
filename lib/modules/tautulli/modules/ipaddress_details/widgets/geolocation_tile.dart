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
    Widget build(BuildContext context) => LSTableBlock(
        title: 'Location Details',
        children: [
            LSTableContent(title: 'country', body: geolocation.country),
            LSTableContent(title: 'region', body: geolocation.region),
            LSTableContent(title: 'city', body: geolocation.city),
            LSTableContent(title: 'postal', body: geolocation.postalCode),
            LSTableContent(title: 'timezone', body: geolocation.timezone),
            LSTableContent(title: 'latitude', body: '${geolocation.latitude}'),
            LSTableContent(title: 'longitude', body: '${geolocation.longitude}'),
        ],
    );
}