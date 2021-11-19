import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrEpisodeDetailsSheet extends LunaBottomModalSheet {
  final BuildContext context;
  final SonarrEpisode episode;
  final SonarrEpisodeFile episodeFile;
  final SonarrQueueRecord queueRecord;

  SonarrEpisodeDetailsSheet({
    @required this.context,
    @required this.episode,
    this.episodeFile,
    this.queueRecord,
  }) {
    context
        .read<SonarrSeasonDetailsState>()
        .fetchEpisodeHistory(context, episode.id);
  }

  @override
  Widget builder(BuildContext context) {
    List<LunaHighlightedNode> _highlightedNodes = [
      if (!episode.monitored)
        LunaHighlightedNode(
          text: 'sonarr.Unmonitored'.tr(),
          backgroundColor: LunaColours.red,
        ),
      if (queueRecord != null)
        LunaHighlightedNode(
          text: [
            queueRecord?.quality?.quality?.name ?? LunaUI.TEXT_EMDASH,
            LunaUI.TEXT_EMDASH,
            '${queueRecord.lunaPercentageComplete}%',
          ].join(' '),
          backgroundColor: LunaColours.purple,
        ),
      if (queueRecord == null && episodeFile != null)
        LunaHighlightedNode(
          backgroundColor: episodeFile.qualityCutoffNotMet
              ? LunaColours.orange
              : LunaColours.accent,
          text: episodeFile.quality?.quality?.name ?? LunaUI.TEXT_EMDASH,
        ),
      if (queueRecord == null && episodeFile != null)
        LunaHighlightedNode(
          backgroundColor: LunaColours.blueGrey,
          text: episodeFile.size?.lunaBytesToString() ?? LunaUI.TEXT_EMDASH,
        ),
      if (queueRecord == null &&
          !episode.hasFile &&
          (episode?.airDateUtc?.toLocal()?.isAfter(DateTime.now()) ?? true))
        LunaHighlightedNode(
          backgroundColor: LunaColours.blue,
          text: 'sonarr.Unaired'.tr(),
        ),
      if (queueRecord == null &&
          !episode.hasFile &&
          (episode?.airDateUtc?.toLocal()?.isBefore(DateTime.now()) ?? true))
        LunaHighlightedNode(
          backgroundColor: LunaColours.red,
          text: 'sonarr.Missing'.tr(),
        ),
    ];
    return ChangeNotifierProvider.value(
      value: this.context.read<SonarrSeasonDetailsState>(),
      builder: (context, _) => LunaListViewModal(
        children: [
          LunaHeader(
            text: episode.title,
            subtitle: [
              episode.airDateUtc != null
                  ? DateFormat.yMMMMd().format(episode.airDateUtc.toLocal())
                  : 'lunasea.UnknownDate'.tr(),
              '\n',
              'sonarr.SeasonNumber'.tr(
                args: [episode?.seasonNumber.toString()],
              ),
              LunaUI.TEXT_BULLET.lunaPad(),
              'sonarr.EpisodeNumber'.tr(
                args: [episode?.episodeNumber.toString()],
              ),
            ].join(),
          ),
          Padding(
            child: Wrap(
              direction: Axis.horizontal,
              spacing: 6.0,
              runSpacing: 6.0,
              children: _highlightedNodes,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: LunaUI.DEFAULT_MARGIN_SIZE,
            ),
          ),
          Padding(
            padding: LunaUI.MARGIN_DEFAULT,
            child: LunaText.subtitle(
              text: episode.overview ?? 'sonarr.NoSummaryAvailable'.tr(),
              maxLines: 0,
              softWrap: true,
            ),
          ),
        ],
        actionBar: LunaBottomActionBar(
          actions: [
            LunaButton(
              loadingState:
                  context.select<SonarrSeasonDetailsState, LunaLoadingState>(
                      (s) => s.episodeSearchState),
              type: LunaButtonType.TEXT,
              text: 'sonarr.Automatic'.tr(),
              icon: Icons.search_rounded,
              onTap: () async {
                context.read<SonarrSeasonDetailsState>().episodeSearchState =
                    LunaLoadingState.ACTIVE;
                SonarrAPIController()
                    .episodeSearch(context: context, episode: episode)
                    .whenComplete(
                      () => context
                          .read<SonarrSeasonDetailsState>()
                          .episodeSearchState = LunaLoadingState.INACTIVE,
                    );
              },
            ),
            LunaButton.text(
              text: 'sonarr.Interactive'.tr(),
              icon: Icons.person_rounded,
              onTap: () async => SonarrReleasesRouter().navigateTo(
                context,
                episodeId: episode.id,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
