import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:lunasea/core.dart';

class SettingsSystemClearImageCacheTile extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<SettingsSystemClearImageCacheTile> {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Clear Image Cache'),
        subtitle: LSSubtitle(text: 'From Temporary Storage'),
        trailing: LSIconButton(icon: Icons.broken_image),
        onTap: () => _clear(context),
    );

    Future<void> _clear(BuildContext context) async {
        await DefaultCacheManager().emptyCache()
        .then((_) => LSSnackBar(
            context: context,
            message: 'Cached images have been removed from storage',
            title: 'Image Cache Cleared',
            type: SNACKBAR_TYPE.success,
        ))
        .catchError((_) => LSSnackBar(
            context: context,
            message: Constants.CHECK_LOGS_MESSAGE,
            title: 'Failed to Clear Image Cache',
            type: SNACKBAR_TYPE.failure,
        ));
    }
}
