import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesRadarrHeadersAddHeaderTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSButton(
        text: 'Add Header',
        onTap: () async => _addPrompt(context),
    );

    Future<void> _addPrompt(BuildContext context) async {
        List results = await SettingsDialogs.addHeader(context);
        if(results[0]) switch(results[1]) {
            case 1:
                _showAuthenticationPrompt(context);
                break;
            case 100:
                _showCustomPrompt(context);
                break;
            default:
                LunaLogger.warning(
                    'SettingsModulesRadarrHeadersAddHeaderTile',
                    '_addPrompt',
                    'Unknown case: ${results[1]}',
                );
                break;
        }
    }

    Future<void> _showAuthenticationPrompt(BuildContext context) async {
        List results = await SettingsDialogs.addAuthenticationHeader(context);
        if(results[0]) {
            Map<String, dynamic> _headers = (Database.currentProfileObject.radarrHeaders ?? {}).cast<String, dynamic>();
            String _auth = base64.encode(utf8.encode('${results[1]}:${results[2]}'));
            _headers.addAll({'Authorization': 'Basic $_auth'});
            Database.currentProfileObject.radarrHeaders = _headers;
            Database.currentProfileObject.save();
        }
    }

    Future<void> _showCustomPrompt(BuildContext context) async {
        List results = await SettingsDialogs.addCustomHeader(context);
        if(results[0]) {
            Map<String, dynamic> _headers = (Database.currentProfileObject.radarrHeaders ?? {}).cast<String, dynamic>();
            _headers.addAll({results[1]: results[2]});
            Database.currentProfileObject.radarrHeaders = _headers;
            Database.currentProfileObject.save();
        }
    }
}