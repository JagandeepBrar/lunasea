import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrBookDetailsOverviewDescriptionTile extends StatelessWidget {
  final ReadarrBook? book;

  const ReadarrBookDetailsOverviewDescriptionTile({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      posterPlaceholderIcon: LunaIcons.VIDEO_CAM,
      backgroundUrl:
          context.read<ReadarrState>().getAuthorPosterURL(book!.authorId),
      posterUrl: context.read<ReadarrState>().getBookCoverURL(book!.id),
      posterHeaders: context.read<ReadarrState>().headers,
      title: book!.title,
      body: [
        LunaTextSpan.extended(
          text: book!.overview == null || book!.overview!.isEmpty
              ? 'sonarr.NoSummaryAvailable'.tr()
              : book!.overview,
        ),
      ],
      customBodyMaxLines: 3,
      onTap: () async =>
          LunaDialogs().textPreview(context, book!.title, book!.overview!),
    );
  }
}
