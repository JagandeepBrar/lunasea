import 'package:lunasea/core.dart';
import 'package:lunasea/modules/overseerr.dart';

extension LunaOverseerrUserExtension on OverseerrUser? {
  String lunaDisplayName() {
    if (this?.displayName?.isEmpty ?? true) return 'overseerr.UnknownUser'.tr();
    return this!.displayName!;
  }

  String lunaEmail() {
    if (this?.email?.isEmpty ?? true) return LunaUI.TEXT_EMDASH;
    return this!.email!;
  }

  String lunaAmountOfRequests() {
    if ((this?.requestCount ?? 0) == 0) return 'overseerr.NoRequests'.tr();
    if (this!.requestCount == 1) return 'overseerr.OneRequest'.tr();
    return 'overseerr.SomeRequests'.tr(args: [this!.requestCount.toString()]);
  }
}
