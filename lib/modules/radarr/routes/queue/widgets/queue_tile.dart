import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/int/bytes.dart';
import 'package:lunasea/extensions/string/string.dart';
import 'package:lunasea/modules/radarr.dart';
import 'package:lunasea/router/routes/radarr.dart';

class RadarrQueueTile extends StatelessWidget {
  final RadarrQueueRecord record;
  final RadarrMovie? movie;

  const RadarrQueueTile({
    Key? key,
    required this.record,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.watch<RadarrState>().movies,
      builder: (context, AsyncSnapshot<List<RadarrMovie>> snapshot) {
        RadarrMovie? movie;
        if (snapshot.hasData)
          movie = snapshot.data!.firstWhereOrNull(
            (element) => element.id == record.movieId,
          );
        return LunaExpandableListTile(
          title: record.title!,
          collapsedSubtitles: [
            _subtitle1(),
            _subtitle2(),
          ],
          expandedHighlightedNodes: _highlightedNodes(),
          expandedTableContent: _tableContent(movie),
          expandedTableButtons: _tableButtons(context),
          collapsedTrailing: LunaIconButton(
            icon: record.lunaStatusIcon,
            color: record.lunaStatusColor,
          ),
          onLongPress: () => RadarrRoutes.MOVIE.go(params: {
            'movie': record.movieId!.toString(),
          }),
        );
      },
    );
  }

  TextSpan _subtitle1() {
    return TextSpan(text: record.lunaMovieTitle(movie!));
  }

  TextSpan _subtitle2() {
    return TextSpan(
      children: [
        TextSpan(
          text: record.lunaQuality,
          style: const TextStyle(
            color: LunaColours.accent,
            fontWeight: LunaUI.FONT_WEIGHT_BOLD,
          ),
        ),
        TextSpan(text: LunaUI.TEXT_BULLET.pad()),
        TextSpan(text: record.timeLeft ?? LunaUI.TEXT_EMDASH),
      ],
    );
  }

  List<LunaTableContent> _tableContent(RadarrMovie? movie) {
    if (movie == null) return [];
    return [
      LunaTableContent(
          title: 'radarr.Movie'.tr(), body: record.lunaMovieTitle(movie)),
      LunaTableContent(
          title: 'radarr.Languages'.tr(), body: record.lunaLanguage),
      LunaTableContent(title: 'Client', body: record.lunaDownloadClient),
      LunaTableContent(title: 'Indexer', body: record.lunaIndexer),
      LunaTableContent(
          title: 'radarr.Size'.tr(), body: record.size!.toInt().asBytes()),
      LunaTableContent(
          title: 'Time Left', body: record.timeLeft ?? LunaUI.TEXT_EMDASH),
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
      if ((record.customFormats?.length ?? 0) != 0)
        for (int i = 0; i < record.customFormats!.length; i++)
          LunaHighlightedNode(
            text: record.customFormats![i].name!,
            backgroundColor: LunaColours.orange,
          ),
      LunaHighlightedNode(
        text: '${record.lunaPercentageComplete}%',
        backgroundColor: LunaColours.blueGrey,
      ),
      LunaHighlightedNode(
        text: record.status?.readable ?? LunaUI.TEXT_EMDASH,
        backgroundColor: LunaColours.blueGrey,
      ),
    ];
  }

  List<LunaButton> _tableButtons(BuildContext context) {
    return [
      if ((record.statusMessages ?? []).isNotEmpty)
        LunaButton.text(
          icon: Icons.messenger_outline_rounded,
          color: LunaColours.orange,
          text: 'Messages',
          onTap: () async {
            LunaDialogs().showMessages(
              context,
              record.statusMessages!
                  .map<String>((status) => status.messages!.join('\n'))
                  .toList(),
            );
          },
        ),
      if (record.status == RadarrQueueRecordStatus.COMPLETED &&
          record.trackedDownloadStatus == RadarrTrackedDownloadStatus.WARNING &&
          (record.outputPath ?? '').isNotEmpty)
        LunaButton.text(
          icon: Icons.download_done_rounded,
          text: 'radarr.Import'.tr(),
          onTap: () => RadarrRoutes.MANUAL_IMPORT_DETAILS.go(queryParams: {
            'path': record.outputPath!,
          }),
        ),
      LunaButton.text(
        icon: Icons.delete_rounded,
        color: LunaColours.red,
        text: 'Remove',
        onTap: () async {
          if (context.read<RadarrState>().enabled) {
            bool result = await RadarrDialogs().confirmDeleteQueue(context);
            if (result) {
              await context
                  .read<RadarrState>()
                  .api!
                  .queue
                  .delete(
                    id: record.id!,
                    blacklist: RadarrDatabase.QUEUE_BLACKLIST.read(),
                    removeFromClient:
                        RadarrDatabase.QUEUE_REMOVE_FROM_CLIENT.read(),
                  )
                  .then((_) {
                showLunaSuccessSnackBar(
                  title: 'Removed From Queue',
                  message: record.title,
                );
                context
                    .read<RadarrState>()
                    .api!
                    .command
                    .refreshMonitoredDownloads()
                    .then((_) => context.read<RadarrState>().fetchQueue());
              }).catchError((error, stack) {
                LunaLogger().error(
                    'Failed to remove queue record: ${record.id}',
                    error,
                    stack);
                showLunaErrorSnackBar(
                  title: 'Failed to Remove',
                  error: error,
                );
              });
            }
          }
        },
      ),
    ];
  }
}
