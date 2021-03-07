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
            LSTableContent(title: 'country', body: geolocation?.country ?? Constants.TEXT_EMDASH),
            LSTableContent(title: 'region', body: geolocation?.region ?? Constants.TEXT_EMDASH),
            LSTableContent(title: 'city', body: geolocation?.city ?? Constants.TEXT_EMDASH),
            LSTableContent(title: 'postal', body: geolocation?.postalCode ?? Constants.TEXT_EMDASH),
            LSTableContent(title: 'timezone', body: geolocation?.timezone ?? Constants.TEXT_EMDASH),
            LSTableContent(title: 'latitude', body: '${geolocation?.latitude ?? Constants.TEXT_EMDASH}'),
            LSTableContent(title: 'longitude', body: '${geolocation?.longitude ?? Constants.TEXT_EMDASH}'),
        ],
    );
}