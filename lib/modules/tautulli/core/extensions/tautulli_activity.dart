import 'package:lunasea/modules/tautulli.dart';
import 'package:lunasea/core.dart';

extension TautulliActivityExtension on TautulliActivity {
    String get lunaSessionsHeader {
        if(this.streamCount == null || this.streamCount == 0) return 'tautulli.sessionsMany'.tr(args: ['0']);
        if(this.streamCount == 1) return 'tautulli.SessionsOne'.tr();
        return 'tautulli.SessionsMany'.tr(args: [this.streamCount.toString()]);
    }

    String get lunaSessions {
        String value = '${'tautulli.Sessions'.tr()}: ';
        value += [
            if((this.streamCountDirectPlay ?? 0) > 0) '${this.streamCountDirectPlay} ${this.streamCountDirectPlay == 1 ? 'tautulli.DirectPlay'.tr() : 'tautulli.DirectPlays'.tr()}',
            if((this.streamCountDirectStream ?? 0) > 0) '${this.streamCountDirectStream} ${this.streamCountDirectStream == 1 ? 'tautulli.DirectStream'.tr() : 'tautulli.DirectStreams'.tr()}',
            if((this.streamCountTranscode ?? 0) > 0) '${this.streamCountTranscode} ${this.streamCountTranscode == 1 ? 'tautulli.Transcode'.tr() : 'tautulli.Transcodes'.tr()}',
        ].join(', ');
        return value;
    }

    String get lunaBandwidth {
        String value = '${'tautulli.Bandwidth'.tr()}: ${this.totalBandwidth?.lunaKilobytesToString(bytes: false, decimals: 1) ?? '0.0'}ps (';
        value += [
            if((this.lanBandwidth ?? 0) > 0) 'LAN: ${this.lanBandwidth.lunaKilobytesToString(bytes: false, decimals: 1)}ps',
            if((this.wanBandwidth ?? 0) > 0) 'WAN: ${this.wanBandwidth.lunaKilobytesToString(bytes: false, decimals: 1)}ps',
        ].join(', ');
        value += ')';
        return value;
    }
}