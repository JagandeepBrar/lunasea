import 'package:lunasea/core.dart';
import 'package:lunasea/modules/overseerr.dart';

extension LunaOverseerrRequestExtension on OverseerrRequest? {
  String lunaRequestStatus() {
    if (this?.status == null) return LunaUI.TEXT_EMDASH;
    return this!.status.lunaName(this?.media?.status);
  }

  String lunaRequestedBy() {
    return 'overseerr.RequestedBy'.tr(args: [
      this?.requestedBy.lunaDisplayName() ?? 'overseerr.UnknownUser'.tr(),
    ]);
  }

  bool lunaIs4K() {
    if (this?.is4k ?? false) return true;
    return false;
  }

  OverseerrMediaStatus? lunaMediaStatus() {
    if (lunaIs4K()) return this?.media?.status4k;
    return this?.media?.status;
  }
}
