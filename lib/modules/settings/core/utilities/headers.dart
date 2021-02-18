import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

enum HEADER_TYPE {
    GENERIC,
    AUTHORIZATION,
}

class HeaderUtility {
    /// Show a dialog confirming the user wants to delete a header.
    /// 
    /// If yes, delete the header from the map, and show a snackbar/toast.
    /// Updates the passed in headers map, and saves the database profile.
    Future<void> deleteHeader(BuildContext context, {
        @required Map<dynamic, dynamic> headers,
        @required String key,
    }) async {
        List result = await SettingsDialogs.deleteHeader(context);
        if(result[0]) {
            Map<String, dynamic> _headers = (headers ?? {}).cast<String, dynamic>();
            _headers.remove(key);
            headers = _headers;
            Database.currentProfileObject.save();
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
    }) async {
        List result = await SettingsDialogs.addHeader(context);
        if(result[0]) switch(result[1]) {
            case 1: await _authorizationHeader(context, headers); break;
            case 100: await _genericHeader(context, headers); break;
            default: LunaLogger().warning('HeaderUtility', 'addHeader', 'Unknown case: ${result[1]}');
        }
    }

    /// Add a generic header.
    Future<void> _genericHeader(BuildContext context, Map<dynamic, dynamic> headers) async {
        List results = await SettingsDialogs.addCustomHeader(context);
        if(results[0]) {
            Map<String, dynamic> _headers = (headers ?? {}).cast<String, dynamic>();
            _headers[results[1]] = results[2];
            headers = _headers;
            Database.currentProfileObject.save();
            showLunaSuccessSnackBar(
                title: 'Header Added',
                message: results[1],
            );
        }
    }

    /// Add an 'Authorization' header.
    Future<void> _authorizationHeader(BuildContext context, Map<dynamic, dynamic> headers) async {
        List results = await SettingsDialogs.addAuthenticationHeader(context);
        if(results[0]) {
            Map<String, dynamic> _headers = (headers ?? {}).cast<String, dynamic>();
            String _auth = base64.encode(utf8.encode('${results[1]}:${results[2]}'));
            _headers['Authorization'] = 'Basic $_auth';
            headers = _headers;
            Database.currentProfileObject.save();
            showLunaSuccessSnackBar(
                title: 'Header Added',
                message: 'Authorization',
            );
        }
    }
}
