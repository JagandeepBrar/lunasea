import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/datetime.dart';
import 'package:lunasea/extensions/int/bytes.dart';
import 'package:lunasea/extensions/string/string.dart';
import 'package:lunasea/modules/mylar.dart';
import 'package:lunasea/router/routes/mylar.dart';

class MylarSeriesDetailsSeasonTile extends StatefulWidget {
  final MylarSeriesSeason season;
  final int? seriesId;

  const MylarSeriesDetailsSeasonTile({
    Key? key,
    required this.season,
    required this.seriesId,
  }) : super(key: key);

  @override
  State<MylarSeriesDetailsSeasonTile> createState() => _State();
}

class _State extends State<MylarSeriesDetailsSeasonTile> {
  LunaLoadingState _loadingState = LunaLoadingState.INACTIVE;

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      posterPlaceholderIcon: LunaIcons.VIDEO_CAM,
      posterUrl: widget.season.images
              ?.firstWhereOrNull((e) => e.coverType == 'poster')
              ?.url ??
          '',
      posterHeaders: context.read<MylarState>().headers,
      title: widget.season.lunaTitle,
      disabled: !widget.season.monitored!,
      body: [
        _subtitle1(),
        _subtitle2(),
        _subtitle3(),
      ],
      trailing: _trailing(),
      onTap: _onTap,
      onLongPress: _onLongPress,
    );
  }

  Future<void> _onTap() async {
    MylarRoutes.SERIES_SEASON.go(params: {
      'series': (widget.seriesId ?? -1).toString(),
      'season': (widget.season.seasonNumber ?? -1).toString(),
    });
  }

  Future<void> _onLongPress() async {
    Tuple2<bool, MylarSeasonSettingsType?> result = await MylarDialogs()
        .seasonSettings(context, widget.season.seasonNumber);
    if (result.item1)
      result.item2!.execute(
        context,
        widget.seriesId,
        widget.season.seasonNumber,
      );
  }

  TextSpan _subtitle1() {
    return TextSpan(
      text: widget.season.statistics?.previousAiring?.asDateTime(
            showSeconds: false,
            delimiter: '@'.pad(),
          ) ??
          LunaUI.TEXT_EMDASH,
    );
  }

  TextSpan _subtitle2() {
    return TextSpan(
      text: widget.season.statistics?.sizeOnDisk?.asBytes(decimals: 1) ??
          LunaUI.TEXT_EMDASH,
    );
  }

  TextSpan _subtitle3() {
    return TextSpan(
      style: TextStyle(
        color: widget.season.lunaPercentageComplete == 100
            ? LunaColours.accent
            : LunaColours.red,
        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
      ),
      text: [
        '${widget.season.lunaPercentageComplete}%',
        LunaUI.TEXT_BULLET,
        '${widget.season.statistics?.episodeFileCount ?? 0}/${widget.season.statistics?.episodeCount ?? 0}',
        'mylar.EpisodesAvailable'.tr(),
      ].join(' '),
    );
  }

  Widget _trailing() {
    Future<void> setLoadingState(LunaLoadingState state) async {
      if (this.mounted) setState(() => _loadingState = state);
    }

    return LunaIconButton(
      icon: widget.season.monitored!
          ? Icons.turned_in_rounded
          : Icons.turned_in_not_rounded,
      color: LunaColours.white,
      loadingState: _loadingState,
      onPressed: () async {
        setLoadingState(LunaLoadingState.ACTIVE);
        await MylarAPIController()
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
