import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:lunasea/core.dart';

class SettingsSystemClearImageCacheTile extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<SettingsSystemClearImageCacheTile> {
    Future<int> _future = DiskCache().cacheSize();

    @override
    Widget build(BuildContext context) => FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
            String _subtitle = 'Loading...';
            switch(snapshot.connectionState) {
                case ConnectionState.active:
                case ConnectionState.none:
                case ConnectionState.waiting: break;
                case ConnectionState.done: if(!snapshot.hasError) {
                    _subtitle = (snapshot.data as int).lsBytes_BytesToString();
                }
                break;
            }
            return LSCardTile(
                title: LSTitle(text: 'Clear Image Cache'),
                subtitle: LSSubtitle(text: _subtitle),
                trailing: LSIconButton(icon: Icons.broken_image),
                onTap: () => _clear(context),
            );
        }
    );

    Future<void> _clear(BuildContext context) async {
        await DiskCache().clear()
            ? LSSnackBar(
                context: context,
                message: 'Cached images have been removed from storage',
                title: 'Image Cache Cleared',
                type: SNACKBAR_TYPE.success,
            )
            : LSSnackBar(
                context: context,
                message: Constants.CHECK_LOGS_MESSAGE,
                title: 'Failed to Clear Image Cache',
                type: SNACKBAR_TYPE.failure,
            );
        setState(() => { _future = DiskCache().cacheSize() });
    }
}
