import 'package:lunasea/core.dart';

extension DoubleExtension on double {
    /// Given a double (of hours), return a string signifying how long ago it occurred.
    /// 
    /// Time greater than 48 hours => "x Days Ago" else "x Hours Ago"
    String lunaHoursToAge() {
        if(this == null) return LunaUI.TEXT_EMDASH;
        int days = (this/24).floor();
        if(this > 48) return '$days Days Ago';
        return this == 1 ? '1 Hour Ago' : '${toStringAsFixed(1)} Hours Ago';
    }
}
