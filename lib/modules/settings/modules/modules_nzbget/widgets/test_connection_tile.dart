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
        ? LSSnackBar(context: context, title: 'Connected Successfully', message: 'NZBGet is ready to use with LunaSea', type: SNACKBAR_TYPE.success)
        : LSSnackBar(context: context, title: 'Connection Test Failed', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure);
}
