import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/string/string.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesDetailsOverviewInformationBlock extends StatelessWidget {
  final SonarrSeries? series;
  final SonarrQualityProfile? qualityProfile;
  final SonarrLanguageProfile? languageProfile;
  final List<SonarrTag> tags;

  const SonarrSeriesDetailsOverviewInformationBlock({
    Key? key,
    required this.series,
    required this.qualityProfile,
    required this.languageProfile,
    required this.tags,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaTableCard(
      content: [
        LunaTableContent(
          title: 'sonarr.Monitoring'.tr(),
          body: (series?.monitored ?? false) ? 'Yes' : 'No',
        ),
        LunaTableContent(
          title: 'type',
          body: series?.lunaSeriesType,
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
          title: 'language',
          body: languageProfile?.name,
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
          title: 'next airing',
          body: series?.lunaNextAiring(),
        ),
        LunaTableContent(
          title: 'added on',
          body: series?.lunaDateAdded,
        ),
        LunaTableContent(title: '', body: ''),
        LunaTableContent(
          title: 'year',
          body: series?.lunaYear,
        ),
        LunaTableContent(
          title: 'network',
          body: series?.lunaNetwork,
        ),
        LunaTableContent(
          title: 'runtime',
          body: series?.lunaRuntime,
        ),
        LunaTableContent(
          title: 'rating',
          body: series?.certification,
        ),
        LunaTableContent(
          title: 'genres',
          body: series?.lunaGenres,
        ),
        LunaTableContent(
          title: 'alternate titles',
          body: series?.lunaAlternateTitles,
        ),
      ],
    );
  }
}
