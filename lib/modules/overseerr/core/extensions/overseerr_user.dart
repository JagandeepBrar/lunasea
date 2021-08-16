import 'package:lunasea/core.dart';
import 'package:lunasea/modules/overseerr.dart';

extension OverseerrUserExtension on OverseerrUser {
  String lunaDisplayName() {
    if (this.displayName != null) return this.displayName;
    return 'overseerr.UnknownUser'.tr();
  }

  String lunaEmail() {
    if (this.email != null) return this.email;
    return LunaUI.TEXT_EMDASH;
  }

  String lunaAmountOfRequests() {
    if (this.requestCount == 0) return 'overseerr.NoRequests'.tr();
    if (this.requestCount == 1) return 'overseerr.OneRequest'.tr();
    return 'overseerr.SomeRequests'.tr(args: [this.requestCount.toString()]);
  }
}
