import 'package:lunasea/core.dart';
import 'package:lunasea/modules/overseerr.dart';

extension LunaOverseerrIssueExtension on OverseerrIssue? {
  String lunaIssueStatus() {
    if (this?.status == null) return LunaUI.TEXT_EMDASH;
    return this!.status!.name;
  }

  String lunaOpenedBy() {
    return 'overseerr.OpenedBy'.tr(args: [
      this?.createdBy.lunaDisplayName() ?? 'overseerr.UnknownUser'.tr(),
    ]);
  }

  String lunaTypeAndStatus() {
    String type = this?.issueType?.name ?? LunaUI.TEXT_EMDASH;
    String status = this?.status?.name ?? LunaUI.TEXT_EMDASH;
    return '$status ($type)';
  }
}
