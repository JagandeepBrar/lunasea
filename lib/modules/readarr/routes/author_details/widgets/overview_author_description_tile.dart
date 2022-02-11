import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrAuthorDetailsOverviewDescriptionTile extends StatelessWidget {
  final ReadarrAuthor? series;

  const ReadarrAuthorDetailsOverviewDescriptionTile({
    Key? key,
    required this.series,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      posterPlaceholderIcon: LunaIcons.BOOK,
      posterUrl: context.read<ReadarrState>().getAuthorPosterURL(series!.id),
      posterHeaders: context.read<ReadarrState>().headers,
      title: series!.title,
      body: [
        LunaTextSpan.extended(
          text: series!.overview == null || series!.overview!.isEmpty
              ? 'readarr.NoSummaryAvailable'.tr()
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
