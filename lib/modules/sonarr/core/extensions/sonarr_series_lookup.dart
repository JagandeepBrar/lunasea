import 'package:lunasea/modules/sonarr.dart';

extension SonarrSeriesLookupExtension on SonarrSeriesLookup {
    String get lunaBannerURL => this.images.firstWhere(
        (element) => element.coverType == 'banner',
        orElse: () => null,
    )?.url;
}