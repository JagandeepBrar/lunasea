import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliIPAddressDetailsState extends ChangeNotifier {
  final String? ipAddress;
  TautulliIPAddressDetailsState(BuildContext context, this.ipAddress) {
    fetchAll(context);
  }

  Future<void> fetchAll(BuildContext context) async {
    fetchGeolocation(context);
    fetchWHOIS(context);
    await Future.wait([
      if (_geolocation != null) _geolocation!,
      if (_whois != null) _whois!,
    ]);
  }

  Future<TautulliGeolocationInfo>? _geolocation;
  Future<TautulliGeolocationInfo>? get geolocation => _geolocation;
  void fetchGeolocation(BuildContext context) {
    if (context.read<TautulliState>().enabled) {
      _geolocation = context
          .read<TautulliState>()
          .api!
          .miscellaneous
          .getGeoIPLookup(ipAddress: ipAddress!);
    }
    notifyListeners();
  }

  Future<TautulliWHOISInfo>? _whois;
  Future<TautulliWHOISInfo>? get whois => _whois;
  void fetchWHOIS(BuildContext context) {
    if (context.read<TautulliState>().enabled) {
      _whois = context
          .read<TautulliState>()
          .api!
          .miscellaneous
          .getWHOISLookup(ipAddress: ipAddress!);
    }
    notifyListeners();
  }
}
