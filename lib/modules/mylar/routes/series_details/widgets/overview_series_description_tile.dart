import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/mylar.dart';

class MylarSeriesDetailsOverviewDescriptionTile extends StatelessWidget {
  final MylarSeries? series;

  const MylarSeriesDetailsOverviewDescriptionTile({
    Key? key,
    required this.series,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      posterPlaceholderIcon: LunaIcons.VIDEO_CAM,
      backgroundUrl: context.read<MylarState>().getFanartURL(series!.id),
      posterUrl: context.read<MylarState>().getPosterURL(series!.id),
      posterHeaders: context.read<MylarState>().headers,
      title: series!.title,
      body: [
        LunaTextSpan.extended(
          text: series!.overview == null || series!.overview!.isEmpty
              ? 'mylar.NoSummaryAvailable'.tr()
              : series!.overview,
        ),
      ],
      customBodyMaxLines: 3,
      onTap: () async => LunaDialogs().textPreview(
        context,
        series!.title,
        series!.overview!,
      ),
    );
  }
}
