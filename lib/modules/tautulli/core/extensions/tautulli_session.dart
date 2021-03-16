import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

extension TautulliSessionExtension on TautulliSession {
    String get lunaContainer {
        return [
            this.streamContainerDecision.localizedName,
            ' (',
            this.container.toUpperCase(),
            if(this.streamContainerDecision != null && this.streamContainerDecision != TautulliTranscodeDecision.DIRECT_PLAY)
                ' ${LunaUI.TEXT_ARROW_RIGHT} ${this.streamContainer.toUpperCase()}',
            ')',
        ].join();
    }

    String get lunaVideo {
        return [
            this.videoDecision.localizedName,
            ' (${this.videoCodec?.toUpperCase() ?? LunaUI.TEXT_EMDASH} ',
            if(this.transcodeHardwareDecoding) '(HW) ',
            this.videoFullResolution,
            if(this.transcodeVideoCodec.isNotEmpty) ' ${LunaUI.TEXT_ARROW_RIGHT} ',
            if(this.transcodeVideoCodec.isNotEmpty) '${this.transcodeVideoCodec.toUpperCase()} ',
            if(this.transcodeVideoCodec.isNotEmpty && this.transcodeHardwareDecoding) '(HW) ',
            if(this.transcodeVideoCodec.isNotEmpty) this.streamVideoFullResolution,
            ')',
        ].join();
    }

    String get lunaAudio {
        return [
            this.audioDecision.localizedName,
            ' (',
            this.audioCodec?.toUpperCase() ?? LunaUI.TEXT_EMDASH,
            if((this.audioChannelLayout?.split('(')?.length ?? 0) > 0) ' ${this.audioChannelLayout?.split('(')[0]}',
            if(this.transcodeAudioCodec.isNotEmpty) ' ${LunaUI.TEXT_ARROW_RIGHT} ',
            if(this.transcodeAudioCodec.isNotEmpty) this.transcodeAudioCodec?.toUpperCase() ?? LunaUI.TEXT_EMDASH,
            if(this.transcodeAudioCodec.isNotEmpty && (this.streamAudioChannelLayout?.split('(')?.length ?? 0) > 0)
                ' ${this.streamAudioChannelLayout?.split('(')[0]}',
            ')',
        ].join();
    }

    String get lunaSubtitle {
        if(!this.subtitles) return 'tautulli.None'.tr();
        return [
            this.streamSubtitleDecision == TautulliTranscodeDecision.NULL ? 'tautulli.DirectPlay'.tr() : this.streamSubtitleDecision.localizedName,
            if(this.subtitleCodec != null && this.subtitleCodec.isNotEmpty) '(${this.subtitleCodec?.toUpperCase() ?? LunaUI.TEXT_EMDASH})',
        ].join(' ');
    }
    
    String get lunaTitle {
        if(this.grandparentTitle != null && this.grandparentTitle.isNotEmpty) return this.grandparentTitle;
        if(this.parentTitle != null && this.parentTitle.isNotEmpty) return this.parentTitle;
        if(this.title != null && this.title.isNotEmpty) return this.title;
        return LunaUI.TEXT_EMDASH;
    }

    String get lunaFullTitle {
        return [
            if(this.title != null && this.title.isNotEmpty) this.title,
            if(this.parentTitle != null && this.parentTitle.isNotEmpty) this.parentTitle,
            if(this.grandparentTitle != null && this.grandparentTitle.isNotEmpty) this.grandparentTitle,
        ].join('\n');
    }

    String get lunaYear {
        if(this.year != null) return this.year.toString();
        return LunaUI.TEXT_EMDASH;
    }

    String get lunaDuration {
        double _percent = (this.progressPercent ?? 0)/100;
        String _progress = Duration(seconds: ((this.streamDuration ?? Duration(seconds: 0)).inSeconds*_percent).floor()).lunaTimestamp;
        String _total = this.streamDuration.lunaTimestamp;
        return '$_progress/$_total (${this.progressPercent}%)';
    }
    
    String get lunaLibraryName {
        if(this.libraryName != null && this.libraryName.isNotEmpty) return this.libraryName;
        return LunaUI.TEXT_EMDASH;
    }

    String get lunaFriendlyName {
        if(this.friendlyName != null && this.friendlyName.isNotEmpty) return this.friendlyName;
        return LunaUI.TEXT_EMDASH;
    }

    String get lunaIPAddress {
        if(this.ipAddress != null && this.ipAddress.isNotEmpty) return this.ipAddress;
        return LunaUI.TEXT_EMDASH;
    }

    String get lunaPlatform {
        return [
            this.platform ?? LunaUI.TEXT_EMDASH,
            if(this.platformVersion != null && this.platformVersion.isNotEmpty) '(${this.platformVersion})',
        ].join(' ');
    }

    String get lunaProduct {
        if(this.product != null && this.product.isNotEmpty) return this.product;
        return LunaUI.TEXT_EMDASH;
    }

    String get lunaPlayer {
        if(this.player != null && this.player.isNotEmpty) return this.player;
        return LunaUI.TEXT_EMDASH;
    }

    String get lunaQuality {
        return [
            this.qualityProfile ?? LunaUI.TEXT_EMDASH,
            if(this.streamBitrate != null) '(${this.streamBitrate.lunaKilobytesToString(bytes: false, decimals: 1)}ps)',
        ].join(' ');
    }

    String get lunaBandwidth {
        if(this.bandwidth != null) return '${this.bandwidth.lunaKilobytesToString(bytes: false, decimals: 1)}ps';
        return LunaUI.TEXT_EMDASH;
    }
    
    String lunaArtworkPath(BuildContext context) {
        switch(this.mediaType) {
            case TautulliMediaType.EPISODE: return context.read<TautulliState>().getImageURLFromRatingKey(this.grandparentRatingKey);
            case TautulliMediaType.TRACK: return context.read<TautulliState>().getImageURLFromRatingKey(this.parentRatingKey);
            case TautulliMediaType.MOVIE:
            case TautulliMediaType.LIVE: 
            default: return context.read<TautulliState>().getImageURLFromRatingKey(this.ratingKey);
        }
    }

    String get lunaTranscodeDecision {
        switch(this.transcodeDecision) {
            case TautulliTranscodeDecision.TRANSCODE:
                String _transcodeStatus = this.transcodeThrottled ? 'tautulli.Throttled'.tr() : '${this.transcodeSpeed ?? 0.0}x';
                return [
                    this.transcodeDecision.localizedName,
                    ' ($_transcodeStatus)',
                ].join();
            case TautulliTranscodeDecision.DIRECT_PLAY:
            case TautulliTranscodeDecision.COPY:
            case TautulliTranscodeDecision.BURN:
            case TautulliTranscodeDecision.NULL: return this.transcodeDecision.localizedName;
            default: return 'tautulli.None'.tr();
        }
    }

    IconData get lunaSessionStateIcon {
        switch(this.state) {
            case TautulliSessionState.PAUSED: return Icons.pause;
            case TautulliSessionState.PLAYING: return Icons.play_arrow;
            case TautulliSessionState.BUFFERING:
            default: return Icons.compare_arrows;
        }
    }

    double get lunaSessionStateIconOffset {
        switch(this.state) {
            case TautulliSessionState.PAUSED: return -2.0;
            case TautulliSessionState.PLAYING: return -3.0;
            case TautulliSessionState.BUFFERING:
            default: return 0.0;
        }
    }

    String get lunaETA {
        try {
            double _percent = this.progressPercent/100;
            Duration _progress = Duration(seconds: (this.streamDuration.inSeconds*_percent).floor());
            Duration _eta = this.streamDuration - _progress;
            return DateTime.now().add(_eta).lunaTime;
        } catch (error, stack) {
            LunaLogger().error('Failed to calculate ETA', error, stack);
            return 'lunasea.Unknown'.tr();
        }
    }

    double get lunaTranscodeProgress => min(1.0, max(0, this.transcodeProgress/100));
    double get lunaProgressPercent => min(1.0, max(0, this.progressPercent/100));
}
