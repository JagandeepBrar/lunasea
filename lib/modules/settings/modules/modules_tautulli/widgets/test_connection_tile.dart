import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class SettingsModulesTautulliTestConnectionTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSButton(
        text: 'Test Connection',
        onTap: () async => _testConnection(context),
    );

    Future<void> _testConnection(BuildContext context) async {
        TautulliState state = Provider.of<TautulliState>(context, listen: false);
        if(!state.enabled) {
            showLunaErrorSnackBar(
                context: context,
                title: 'Tautulli Not Enabled',
                message: 'Tautulli needs to be enabled',
            );
            return;
        }
        if(state.host == null || state.host.isEmpty) {
            showLunaErrorSnackBar(
                context: context,
                title: 'Host Required',
                message: 'Host is required to connect to Tautulli',
            );
            return;
        }
        if(state.apiKey == null || state.apiKey.isEmpty) {
            showLunaErrorSnackBar(
                context: context,
                title: 'API Key Required',
                message: 'API key is required to connect to Tautulli',
            );
            return;
        }
        state.api.miscellaneous.arnold()
        .then((_) {
            showLunaSuccessSnackBar(
                context: context,
                title: 'Connected Successfully',
                message: 'Tautulli is ready to use with LunaSea',
            );
        }).catchError((error, trace) {
            LunaLogger.error(
                'SettingsModulesTautulliTestConnectionTile',
                '_testConnection',
                'Connection Test Failed',
                error,
                trace,
                uploadToSentry: false,
            );
            showLunaErrorSnackBar(
                context: context,
                title: 'Connection Test Failed',
                error: error,
            );
        });
    }
}
