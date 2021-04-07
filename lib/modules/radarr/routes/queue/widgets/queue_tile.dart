import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrQueueTile extends StatelessWidget {
    final RadarrQueueRecord record;

    RadarrQueueTile({
        Key key,
        @required this.record,
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
                    collapsedSubtitle1: TextSpan(text: '1'),
                    collapsedSubtitle2: TextSpan(text: '2'),
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

    List<LunaTableContent> _tableContent(RadarrMovie movie) {
        return [
            LunaTableContent(title: 'radarr.Movie'.tr(), body: movie?.title ?? LunaUI.TEXT_EMDASH),
            LunaTableContent(title: 'radarr.Language'.tr(), body: record.lunaLanguage),
            LunaTableContent(title: 'radarr.Size'.tr(), body: record.size.toInt().lunaBytesToString()),
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
            LunaButton.text(
                icon: Icons.delete_rounded,
                color: LunaColours.red,
                text: 'Delete',
                onTap: () async {
                    if(context.read<RadarrState>().enabled) {
                        // TODO: Add dialog confirmation
                        await context.read<RadarrState>().api.queue.delete(id: record.id);
                        context.read<RadarrState>().api.command.refreshMonitoredDownloads()
                        .then((_) => context.read<RadarrState>().fetchQueue());
                    }
                },
            ),
        ];
    }
}
