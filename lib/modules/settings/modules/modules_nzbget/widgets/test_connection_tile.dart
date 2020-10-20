import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/nzbget.dart';

class SettingsModulesNZBGetTestConnectionTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSButton(
        text: 'Test Connection',
        onTap: () async => _testConnection(context),
    );

    Future<void> _testConnection(BuildContext context) async => await NZBGetAPI.from(Database.currentProfileObject).testConnection()
    .then((_) => showLunaSuccessSnackBar(
        context: context,
        title: 'Connected Successfully',
        message: 'NZBGet is ready to use with LunaSea',
    ))
    .catchError((error, stack) {
        LunaLogger.error(
            'SettingsModulesNZBGetTestConnectionTile',
            '_testConnection',
            'Connection Test Failed',
            error,
            stack,
            uploadToSentry: false,
        );
        showLunaErrorSnackBar(
            context: context,
            title: 'Connection Test Failed',
            error: error,
        );
    });
}
