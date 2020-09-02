import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesNZBGetHeadersHeaderTile extends StatelessWidget {
    final String headerKey;
    final String headerValue;

    SettingsModulesNZBGetHeadersHeaderTile({
        @required this.headerKey,
        @required this.headerValue,
    });
    
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: headerKey),
        subtitle: LSSubtitle(text: headerValue),
        trailing: LSIconButton(
            icon: Icons.delete,
            color: LSColors.red,
            onPressed: () async => _deleteHeader(context),
        ),
    );

    Future<void> _deleteHeader(BuildContext context) async {
        List results = await SettingsDialogs.deleteHeader(context);
        if(results[0]) {
            Map<String, dynamic> _headers = (Database.currentProfileObject.nzbgetHeaders ?? {}).cast<String, dynamic>();
            _headers.remove(headerKey);
            Database.currentProfileObject.nzbgetHeaders = _headers;
            Database.currentProfileObject.save(context: context);
            LSSnackBar(
                context: context,
                message: headerKey,
                title: 'Header Deleted',
                type: SNACKBAR_TYPE.success,
            );
        }
    }
}
