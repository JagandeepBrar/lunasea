import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class HeaderUtility {
    /// Show a dialog confirming the user wants to delete a header.
    /// 
    /// If yes, delete the header from the map, and show a snackbar/toast.
    /// Updates the passed in headers map, and saves the database profile.
    Future<void> deleteHeader(BuildContext context, {
        @required Map<dynamic, dynamic> headers,
        @required String key,
        IndexerHiveObject indexer,
    }) async {
        List result = await SettingsDialogs.deleteHeader(context);
        if(result[0]) {
            Map<String, dynamic> _headers = (headers ?? {}).cast<String, dynamic>();
            _headers.remove(key);
            headers = _headers;
            Database.currentProfileObject.save();
            indexer?.save();
            showLunaSuccessSnackBar(
                title: 'Header Deleted',
                message: key,
            );
        }
    }

    /// Add a new header to the map.
    /// 
    /// If yes, adds a header and shows a snackbar.
    /// Updates the passed in headers map, and saves the database profile.
    Future<void> addHeader(BuildContext context, {
        @required Map<dynamic, dynamic> headers,
        IndexerHiveObject indexer,
    }) async {
        Tuple2<bool, HeaderType> result = await SettingsDialogs().addHeader(context);
        if(result.item1) switch(result.item2) {
            case HeaderType.AUTHORIZATION: await _basicAuthenticationHeader(context, headers, indexer); break;
            case HeaderType.GENERIC: await _genericHeader(context, headers, indexer); break;
            default: LunaLogger().warning('HeaderUtility', 'addHeader', 'Unknown case: ${result.item2}');
        }
    }

    /// Add a generic header.
    Future<void> _genericHeader(BuildContext context, Map<dynamic, dynamic> headers, IndexerHiveObject indexer) async {
        List results = await SettingsDialogs.addCustomHeader(context);
        if(results[0]) {
            Map<String, dynamic> _headers = (headers ?? {}).cast<String, dynamic>();
            _headers[results[1]] = results[2];
            headers = _headers;
            Database.currentProfileObject.save();
            indexer?.save();
            showLunaSuccessSnackBar(
                title: 'Header Added',
                message: results[1],
            );
        }
    }

    /// Add an 'Authorization' header.
    Future<void> _basicAuthenticationHeader(BuildContext context, Map<dynamic, dynamic> headers, IndexerHiveObject indexer) async {
        List results = await SettingsDialogs.addBasicAuthenticationHeader(context);
        if(results[0]) {
            Map<String, dynamic> _headers = (headers ?? {}).cast<String, dynamic>();
            String _auth = base64.encode(utf8.encode('${results[1]}:${results[2]}'));
            _headers['Authorization'] = 'Basic $_auth';
            headers = _headers;
            Database.currentProfileObject.save();
            indexer?.save();
            showLunaSuccessSnackBar(
                title: 'Header Added',
                message: 'Authorization',
            );
        }
    }
}

enum HeaderType {
    GENERIC,
    AUTHORIZATION,
}

extension HeaderTypeExtension on HeaderType {
    String get name {
        switch(this) {
            case HeaderType.GENERIC: return 'Custom...';
            case HeaderType.AUTHORIZATION: return 'Basic Authentication';
        }
        throw Exception('Invalid HeaderType');
    }

    IconData get icon {
        switch(this) {
            case HeaderType.GENERIC: return Icons.device_hub;
            case HeaderType.AUTHORIZATION: return Icons.verified_user;
        }
        throw Exception('Invalid HeaderType');
    }
}
