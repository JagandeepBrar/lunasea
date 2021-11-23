import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesDetailsOverviewDescriptionTile extends StatelessWidget {
  final SonarrSeries series;

  const SonarrSeriesDetailsOverviewDescriptionTile({
    Key key,
    @required this.series,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaFourLineCardWithPoster(
      posterPlaceholder: LunaAssets.blankVideo,
      backgroundUrl: context.read<SonarrState>().getFanartURL(series.id),
      posterUrl: context.read<SonarrState>().getPosterURL(series.id),
      posterHeaders: context.read<SonarrState>().headers,
      title: series.title,
      subtitle1: TextSpan(
        text: series.overview == null || series.overview.isEmpty
            ? 'No summary is available.\n\n\n'
            : '${series.overview}\n\n\n',
      ),
      subtitle1MaxLines: 3,
      onTap: () async => LunaDialogs().textPreview(
        context,
        series.title,
        series.overview,
      ),
    );
  }
}
