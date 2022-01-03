import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class HeaderUtility {
  /// Show a dialog confirming the user wants to delete a header.
  ///
  /// If yes, delete the header from the map, and show a snackbar/toast.
  /// Updates the passed in headers map, and saves the database profile.
  Future<void> deleteHeader(
    BuildContext context, {
    required Map<dynamic, dynamic>? headers,
    required String key,
    IndexerHiveObject? indexer,
  }) async {
    bool result = await SettingsDialogs().deleteHeader(context);
    if (result) {
      Map<String, dynamic> _headers = (headers ?? {}).cast<String, dynamic>();
      _headers.remove(key);
      headers = _headers;
      LunaProfile.current.save();
      indexer?.save();
      showLunaSuccessSnackBar(
        title: 'settings.HeaderDeleted'.tr(),
        message: key,
      );
    }
  }

  /// Add a new header to the map.
  ///
  /// If yes, adds a header and shows a snackbar.
  /// Updates the passed in headers map, and saves the database profile.
  Future<void> addHeader(
    BuildContext context, {
    required Map<dynamic, dynamic>? headers,
    IndexerHiveObject? indexer,
  }) async {
    Tuple2<bool, HeaderType?> result =
        await SettingsDialogs().addHeader(context);
    if (result.item1)
      switch (result.item2) {
        case HeaderType.AUTHORIZATION:
          await _basicAuthenticationHeader(context, headers, indexer);
          break;
        case HeaderType.GENERIC:
          await _genericHeader(context, headers, indexer);
          break;
        default:
          LunaLogger().warning(
            'HeaderUtility',
            'addHeader',
            'Unknown case: ${result.item2}',
          );
      }
  }

  /// Add a generic header.
  Future<void> _genericHeader(
    BuildContext context,
    Map<dynamic, dynamic>? headers,
    IndexerHiveObject? indexer,
  ) async {
    Tuple3<bool, String, String> results =
        await SettingsDialogs().addCustomHeader(context);
    if (results.item1) {
      Map<String, dynamic> _headers = (headers ?? {}).cast<String, dynamic>();
      _headers[results.item2] = results.item3;
      headers = _headers;
      LunaProfile.current.save();
      indexer?.save();
      showLunaSuccessSnackBar(
        title: 'settings.HeaderAdded'.tr(),
        message: results.item2,
      );
    }
  }

  /// Add an 'Authorization' header.
  Future<void> _basicAuthenticationHeader(
    BuildContext context,
    Map<dynamic, dynamic>? headers,
    IndexerHiveObject? indexer,
  ) async {
    Tuple3<bool, String, String> results =
        await SettingsDialogs().addBasicAuthenticationHeader(context);
    if (results.item1) {
      Map<String, dynamic> _headers = (headers ?? {}).cast<String, dynamic>();
      String _auth = base64.encode(
        utf8.encode('${results.item2}:${results.item3}'),
      );
      _headers['Authorization'] = 'Basic $_auth';
      headers = _headers;
      LunaProfile.current.save();
      indexer?.save();
      showLunaSuccessSnackBar(
        title: 'settings.HeaderAdded'.tr(),
        message: 'Authorization',
      );
    }
  }
}
