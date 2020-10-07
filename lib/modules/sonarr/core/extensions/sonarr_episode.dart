import 'package:lunasea/modules/sonarr.dart';

extension SonarrEpisodeExtension on SonarrEpisode {
    /// Creates a clone of the [SonarrEpisode] object (deep copy).
    SonarrEpisode clone() => SonarrEpisode.fromJson(this.toJson());
}
