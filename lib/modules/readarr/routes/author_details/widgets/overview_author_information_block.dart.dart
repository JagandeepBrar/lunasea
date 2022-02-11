import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrAuthorDetailsOverviewInformationBlock extends StatelessWidget {
  final ReadarrAuthor? series;
  final ReadarrQualityProfile? qualityProfile;
  final ReadarrMetadataProfile? metadataProfile;
  final List<ReadarrTag> tags;

  const ReadarrAuthorDetailsOverviewInformationBlock({
    Key? key,
    required this.series,
    required this.qualityProfile,
    required this.metadataProfile,
    required this.tags,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaTableCard(
      content: [
        LunaTableContent(
          title: 'readarr.Monitoring'.tr(),
          body: (series?.monitored ?? false) ? 'Yes' : 'No',
        ),
        LunaTableContent(
          title: 'path',
          body: series?.path,
        ),
        LunaTableContent(
          title: 'quality',
          body: qualityProfile?.name,
        ),
        LunaTableContent(
          title: 'metadata',
          body: metadataProfile?.name,
        ),
        LunaTableContent(
          title: 'tags',
          body: series?.lunaTags(tags),
        ),
        LunaTableContent(title: '', body: ''),
        LunaTableContent(
          title: 'status',
          body: series?.status?.toTitleCase(),
        ),
        LunaTableContent(
          title: 'added on',
          body: series?.lunaDateAdded,
        ),
        LunaTableContent(title: '', body: ''),
        LunaTableContent(
          title: 'rating',
          body: series?.ratings?.value.toString(),
        ),
      ],
    );
  }
}
