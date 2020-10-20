import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sabnzbd.dart';

class SettingsModulesSABnzbdTestConnectionTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSButton(
        text: 'Test Connection',
        onTap: () async => _testConnection(context),
    );

    Future<void> _testConnection(BuildContext context) async => await SABnzbdAPI.from(Database.currentProfileObject).testConnection()
    .then((response) {
        if((response as Response).data['status'] != false) {
            showLunaSuccessSnackBar(
                context: context,
                title: 'Connected Successfully',
                message: 'SABnzbd is ready to use with LunaSea',
            );
        } else {
            showLunaErrorSnackBar(
                context: context,
                title: 'Connection Test Failed',
                message: 'SABnzbd: ${(response as Response).data['error'] ?? Constants.TEXT_EMDASH}',
            );
        }
    })
    .catchError((error, stack) {
        LunaLogger.error(
            'SettingsModulesSABnzbdTestConnectionTile',
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
