import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrQueueTile extends StatelessWidget {
    final RadarrQueueRecord record;
    final RadarrMovie movie;

    RadarrQueueTile({
        Key key,
        @required this.record,
        @required this.movie,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return FutureBuilder(
            future: context.watch<RadarrState>().movies,
            builder: (context, AsyncSnapshot<List<RadarrMovie>> snapshot) {
                RadarrMovie movie;
                if(snapshot.hasData) movie = snapshot.data.firstWhere(
                    (element) => element.id == record.movieId,
                    orElse: () => null,
                );
                return LunaExpandableListTile(
                    title: record.title,
                    collapsedSubtitle1: _subtitle1(),
                    collapsedSubtitle2: _subtitle2(),
                    expandedHighlightedNodes: _highlightedNodes(),
                    expandedTableContent: _tableContent(movie),
                    expandedTableButtons: _tableButtons(context),
                    collapsedTrailing: LunaIconButton(
                        icon: record.lunaStatusIcon,
                        color: record.lunaStatusColor,
                    ),
                    onLongPress: () async => RadarrMoviesDetailsRouter().navigateTo(context, movieId: record.movieId),
                );
            },
        );
    }

    TextSpan _subtitle1() {
        return TextSpan(text: movie?.title ?? LunaUI.TEXT_EMDASH);
    }

    TextSpan _subtitle2() {
        return TextSpan(
            children: [
                TextSpan(
                    text: record.lunaQuality,
                    style: TextStyle(
                        color: LunaColours.accent,
                        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                    ),
                ),
                TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
                TextSpan(text: record?.timeLeft ?? LunaUI.TEXT_EMDASH),
            ],
        );
    }

    List<LunaTableContent> _tableContent(RadarrMovie movie) {
        return [
            LunaTableContent(title: 'radarr.Movie'.tr(), body: movie?.title ?? LunaUI.TEXT_EMDASH),
            LunaTableContent(title: 'radarr.Language'.tr(), body: record.lunaLanguage),
            LunaTableContent(title: 'radarr.Size'.tr(), body: record.size.toInt().lunaBytesToString()),
            LunaTableContent(title: 'Client', body: record.downloadClient ?? LunaUI.TEXT_EMDASH),
            LunaTableContent(title: 'Indexer', body: record.indexer ?? LunaUI.TEXT_EMDASH),
        ];
    }

    List<LunaHighlightedNode> _highlightedNodes() {
        return [
            LunaHighlightedNode(
                text: record.protocol?.readable ?? LunaUI.TEXT_EMDASH,
                backgroundColor: LunaColours.blue,
            ),
            LunaHighlightedNode(
                text: record.lunaQuality,
                backgroundColor: LunaColours.accent,
            ),
            if((record.customFormats?.length ?? 0) != 0) for(int i=0; i<record.customFormats.length; i++) LunaHighlightedNode(
                text: record.customFormats[i].name,
                backgroundColor: LunaColours.orange,
            ),
            LunaHighlightedNode(
                text: '${record?.lunaPercentageComplete ?? LunaUI.TEXT_EMDASH}%',
                backgroundColor: LunaColours.blueGrey,
            ),
            LunaHighlightedNode(
                text: record?.status?.readable ?? LunaUI.TEXT_EMDASH,
                backgroundColor: LunaColours.blueGrey,
            ),
        ];
    }

    List<LunaButton> _tableButtons(BuildContext context) {
        return [
            if((record?.statusMessages ?? []).isNotEmpty) LunaButton.text(
                icon: Icons.messenger_outline_rounded,
                text: 'Messages',
                onTap: () async {
                    LunaDialogs().showMessages(
                        context,
                        record.statusMessages.map<String>((status) => status.messages.join('\n')).toList(),
                    );
                },
            ),
            if(
                record?.status == RadarrQueueRecordStatus.COMPLETED &&
                record?.trackedDownloadStatus == RadarrTrackedDownloadStatus.WARNING &&
                (record?.outputPath ?? '').isNotEmpty
            ) LunaButton.text(
                icon: Icons.download_done_rounded,
                text: 'radarr.Import'.tr(),
                onTap: () async => RadarrManualImportDetailsRouter().navigateTo(context, path: record.outputPath)
            ),
            LunaButton.text(
                icon: Icons.delete_rounded,
                color: LunaColours.red,
                text: 'Remove',
                onTap: () async {
                    if(context.read<RadarrState>().enabled) {
                        bool result = await RadarrDialogs().confirmDeleteQueue(context);
                        if(result) {
                            await context.read<RadarrState>().api.queue.delete(
                                id: record.id,
                                blacklist: RadarrDatabaseValue.QUEUE_BLACKLIST.data,
                                removeFromClient: RadarrDatabaseValue.QUEUE_REMOVE_FROM_CLIENT.data,
                            );
                            context.read<RadarrState>().api.command.refreshMonitoredDownloads()
                            .then((_) => context.read<RadarrState>().fetchQueue());
                        }
                    }
                },
            ),
        ];
    }
}
