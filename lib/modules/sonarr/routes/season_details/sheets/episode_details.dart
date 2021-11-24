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
    _intializeSheet();
  }

  Future<void> _intializeSheet() async {
    context
        .read<SonarrSeasonDetailsState>()
        .fetchEpisodeHistory(context, episode.id);
    context.read<SonarrSeasonDetailsState>().episodeSearchState =
        LunaLoadingState.INACTIVE;
  }

  Widget _highlightedNodes(BuildContext context) {
    List<LunaHighlightedNode> _nodes = [
      if (!episode.monitored)
        LunaHighlightedNode(
          text: 'sonarr.Unmonitored'.tr(),
          backgroundColor: LunaColours.red,
        ),
      if (episode.hasFile && episodeFile != null)
        LunaHighlightedNode(
          backgroundColor: episodeFile.qualityCutoffNotMet
              ? LunaColours.orange
              : LunaColours.accent,
          text: episodeFile.quality?.quality?.name ?? LunaUI.TEXT_EMDASH,
        ),
      if (episode.hasFile && episodeFile != null)
        LunaHighlightedNode(
          backgroundColor: episodeFile.languageCutoffNotMet
              ? LunaColours.orange
              : LunaColours.accent,
          text: episodeFile.language?.name ?? LunaUI.TEXT_EMDASH,
        ),
      if (episode.hasFile && episodeFile != null)
        LunaHighlightedNode(
          backgroundColor: LunaColours.blueGrey,
          text: episodeFile.size?.lunaBytesToString() ?? LunaUI.TEXT_EMDASH,
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
    return Padding(
      child: Wrap(
        direction: Axis.horizontal,
        spacing: 6.0,
        runSpacing: 6.0,
        children: _nodes,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: LunaUI.DEFAULT_MARGIN_SIZE,
      ),
    );
  }

  List<Widget> _episodeDetails(BuildContext context) {
    return [
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
          if (episode?.absoluteEpisodeNumber != null)
            ' (${episode.absoluteEpisodeNumber})',
        ].join(),
      ),
      _highlightedNodes(context),
      Padding(
        padding: LunaUI.MARGIN_CARD.copyWith(
          top: LunaUI.DEFAULT_MARGIN_SIZE,
        ),
        child: LunaText.subtitle(
          text: episode.overview ?? 'sonarr.NoSummaryAvailable'.tr(),
          maxLines: 0,
          softWrap: true,
        ),
      ),
    ];
  }

  List<Widget> _files(BuildContext context) {
    if (!episode.hasFile || episodeFile == null) return [];
    return [
      LunaTableCard(
        content: [
          LunaTableContent(
            title: 'sonarr.RelativePath'.tr(),
            body: episodeFile.relativePath ?? LunaUI.TEXT_EMDASH,
          ),
          LunaTableContent(
            title: 'sonarr.Video'.tr(),
            body: episodeFile?.mediaInfo?.videoCodec,
          ),
          LunaTableContent(
            title: 'sonarr.Audio'.tr(),
            body: [
              episodeFile?.mediaInfo?.audioCodec ?? LunaUI.TEXT_EMDASH,
              if (episodeFile?.mediaInfo?.audioChannels != null)
                episodeFile?.mediaInfo?.audioChannels?.toString(),
            ].join(LunaUI.TEXT_EMDASH.lunaPad()),
          ),
          LunaTableContent(
            title: 'sonarr.Size'.tr(),
            body: episodeFile.size?.lunaBytesToString() ?? LunaUI.TEXT_EMDASH,
          ),
          LunaTableContent(
            title: 'sonarr.AddedOn'.tr(),
            body: episodeFile?.dateAdded
                ?.lunaDateTimeReadable(timeOnNewLine: true),
          ),
        ],
        buttons: [
          if (episodeFile?.mediaInfo != null)
            LunaButton.text(
              text: 'sonarr.MediaInfo'.tr(),
              icon: Icons.info_outline_rounded,
              onTap: () async =>
                  SonarrMediaInfoSheet(mediaInfo: episodeFile.mediaInfo)
                      .showModal(context: context),
            ),
          LunaButton(
            type: LunaButtonType.TEXT,
            text: 'lunasea.Delete'.tr(),
            icon: Icons.delete,
            onTap: () async {
              bool result = await SonarrDialogs().deleteEpisode(context);
              if (result) {
                SonarrAPIController()
                    .deleteEpisode(
                        context: context,
                        episode: episode,
                        episodeFile: episodeFile)
                    .then((_) {
                  episode.hasFile = false;
                  context
                      .read<SonarrSeasonDetailsState>()
                      .fetchHistory(context);
                  context
                      .read<SonarrSeasonDetailsState>()
                      .fetchEpisodeHistory(context, episode.id);
                });
              }
            },
            color: LunaColours.red,
          ),
        ],
      ),
    ];
  }

  List<Widget> _history(BuildContext context) {
    return [
      FutureBuilder(
        future: context.select<SonarrSeasonDetailsState, Future<SonarrHistory>>(
          (s) => s.getEpisodeHistory(episode.id),
        ),
        builder: (BuildContext context, AsyncSnapshot<SonarrHistory> snapshot) {
          if (snapshot.hasError) {
            if (snapshot.connectionState != ConnectionState.waiting) {
              LunaLogger().error(
                'Unable to fetch Sonarr episode history ${episode.id}',
                snapshot.error,
                snapshot.stackTrace,
              );
            }
          }
          if (snapshot.hasData) {
            if (snapshot.data.records.isEmpty)
              return Padding(
                child: LunaMessage.inList(
                  text: 'sonarr.NoHistoryFound'.tr(),
                ),
                padding: const EdgeInsets.only(
                    bottom: LunaUI.DEFAULT_MARGIN_SIZE / 2),
              );
            return Padding(
              child: Column(
                children: List.generate(
                  snapshot.data.records.length,
                  (index) => SonarrHistoryTile(
                    history: snapshot.data.records[index],
                    episode: episode,
                    type: SonarrHistoryTileType.EPISODE,
                  ),
                ),
              ),
              padding:
                  const EdgeInsets.only(bottom: LunaUI.DEFAULT_MARGIN_SIZE / 2),
            );
          }
          return const Padding(
            child: LunaLoader(
              useSafeArea: false,
              size: 16.0,
            ),
            padding: EdgeInsets.only(
              bottom: LunaUI.DEFAULT_MARGIN_SIZE * 1.5,
              top: LunaUI.DEFAULT_MARGIN_SIZE,
            ),
          );
        },
      ),
    ];
  }

  LunaBottomActionBar _actionBar(BuildContext context) {
    return LunaBottomActionBar(
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
    );
  }

  @override
  Widget builder(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: this.context.read<SonarrSeasonDetailsState>(),
      builder: (context, _) => LunaListViewModal(
        children: [
          ..._episodeDetails(context),
          ..._files(context),
          ..._history(context),
        ],
        actionBar: _actionBar(context),
      ),
    );
  }
}
