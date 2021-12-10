import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesDetailsSeasonTile extends StatefulWidget {
  final SonarrSeriesSeason season;
  final int seriesId;

  const SonarrSeriesDetailsSeasonTile({
    Key key,
    @required this.season,
    @required this.seriesId,
  }) : super(key: key);

  @override
  State<SonarrSeriesDetailsSeasonTile> createState() => _State();
}

class _State extends State<SonarrSeriesDetailsSeasonTile> {
  LunaLoadingState _loadingState = LunaLoadingState.INACTIVE;

  @override
  Widget build(BuildContext context) {
    if (widget.season == null) return const SizedBox(height: 0.0);
    return LunaThreeLineCardWithPoster(
      posterPlaceholder: LunaAssets.blankVideo,
      posterUrl: widget.season?.images
              ?.firstWhere((e) => e.coverType == 'poster', orElse: () => null)
              ?.url ??
          '',
      posterHeaders: context.read<SonarrState>().headers,
      title: widget.season.lunaTitle,
      darken: !widget.season.monitored,
      subtitle1: _subtitle1(),
      subtitle2: _subtitle2(),
      trailing: _trailing(),
      onTap: _onTap,
      onLongPress: _onLongPress,
    );
  }

  Future<void> _onTap() async => SonarrSeasonDetailsRouter().navigateTo(
        context,
        seriesId: widget.seriesId,
        seasonNumber: widget.season.seasonNumber,
      );

  Future<void> _onLongPress() async {
    Tuple2<bool, SonarrSeasonSettingsType> result = await SonarrDialogs()
        .seasonSettings(context, widget.season.seasonNumber);
    if (result.item1)
      result.item2.execute(
        context,
        widget.seriesId,
        widget.season.seasonNumber,
      );
  }

  TextSpan _subtitle1() {
    return TextSpan(
      text: widget.season?.statistics?.sizeOnDisk
              ?.lunaBytesToString(decimals: 1) ??
          LunaUI.TEXT_EMDASH,
    );
  }

  TextSpan _subtitle2() {
    return TextSpan(
      style: TextStyle(
        color: widget.season.lunaPercentageComplete == 100
            ? widget.season.monitored
                ? LunaColours.accent
                : LunaColours.accent.withOpacity(0.30)
            : widget.season.monitored
                ? LunaColours.red
                : LunaColours.red.withOpacity(0.30),
        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
      ),
      text: [
        '${widget.season.lunaPercentageComplete}%',
        LunaUI.TEXT_BULLET,
        '${widget?.season?.statistics?.episodeFileCount ?? 0}/${widget?.season?.statistics?.episodeCount ?? 0}',
        'sonarr.EpisodesAvailable'.tr(),
      ].join(' '),
    );
  }

  Widget _trailing() {
    Future<void> setLoadingState(LunaLoadingState state) async {
      if (this.mounted) setState(() => _loadingState = state);
    }

    return LunaIconButton(
      icon: widget.season.monitored
          ? Icons.turned_in_rounded
          : Icons.turned_in_not_rounded,
      color: widget.season.monitored ? Colors.white : Colors.white30,
      loadingState: _loadingState,
      onPressed: () async {
        setLoadingState(LunaLoadingState.ACTIVE);
        await SonarrAPIController()
            .toggleSeasonMonitored(
              context: context,
              season: widget.season,
              seriesId: widget.seriesId,
            )
            .whenComplete(() => setLoadingState(LunaLoadingState.INACTIVE));
      },
    );
  }
}
