import 'package:lunasea/core.dart';
import 'package:lunasea/modules/overseerr.dart';

extension LunaOverseerrMovieExtension on OverseerrMovie? {
  String lunaTitle() {
    if (this?.title == null) return LunaUI.TEXT_EMDASH;
    return this!.title!;
  }

  String lunaYear() {
    if (this?.releaseDate?.isEmpty ?? true) return LunaUI.TEXT_EMDASH;
    return this!.releaseDate!.split('-')[0];
  }
}
