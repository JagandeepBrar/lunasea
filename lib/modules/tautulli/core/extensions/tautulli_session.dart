import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

extension TautulliSessionExtension on TautulliSession {
    String get lsFullTitle => [
        if(this.title != null && this.title.isNotEmpty) '${this.title}',
        if(this.parentTitle != null && this.parentTitle.isNotEmpty) '\n${this.parentTitle}',
        if(this.grandparentTitle != null && this.grandparentTitle.isNotEmpty) '\n${this.grandparentTitle}',
    ].join();

    String get lsTitle => this.grandparentTitle == null || this.grandparentTitle.isEmpty
        ? this.parentTitle == null || this.parentTitle.isEmpty
        ? this.title == null || this.title.isEmpty
        ? 'Unknown Title'
        : this.title
        : this.parentTitle
        : this.grandparentTitle;

    String get lsDuration {
        double _percent = this.progressPercent/100;
        String _progress = Duration(seconds: (this.streamDuration.inSeconds*_percent).floor()).lunaTimestamp;
        String _total = this.streamDuration.lunaTimestamp;
        return '$_progress/$_total (${this.progressPercent}%)';
    }

    String get lsBandwidth => '${this.bandwidth.lunaKilobytesToString(bytes: false, decimals: 1)}ps';

    String get lsQuality => '${this.qualityProfile} (${this.streamBitrate.lunaKilobytesToString(bytes: false, decimals: 1)}ps)';

    String get lsStream {
        switch(this.transcodeDecision) {
            case TautulliTranscodeDecision.TRANSCODE:
                String _transcodeStatus = this.transcodeThrottled ? 'Throttled' : '${this.transcodeSpeed ?? 0.0}x';
                return [
                    'Transcode',
                    ' ($_transcodeStatus)',
                ].join();
            case TautulliTranscodeDecision.COPY: return 'Direct Stream';
            case TautulliTranscodeDecision.DIRECT_PLAY: return 'Direct Play';
            case TautulliTranscodeDecision.NULL:
            default: return 'Unknown Transcode Decision';
        }
    }

    String get lsContainer => [
        this.streamContainerDecision.name,
        ' (',
        this.container.toUpperCase(),
        if(this.streamContainerDecision != null && this.streamContainerDecision != TautulliTranscodeDecision.DIRECT_PLAY)
            ' ${LunaUI.TEXT_ARROW_RIGHT} ${this.streamContainer.toUpperCase()}',
        ')',
    ].join();

    String get lsVideo => [
        this.videoDecision.name,
        ' (',
        '${this.videoCodec.toUpperCase()} ',
        if(this.transcodeHardwareDecoding) '(HW) ',
        this.videoFullResolution,
        if(this.transcodeVideoCodec.isNotEmpty) ' ${LunaUI.TEXT_ARROW_RIGHT} ',
        if(this.transcodeVideoCodec.isNotEmpty) '${this.transcodeVideoCodec.toUpperCase()} ',
        if(this.transcodeVideoCodec.isNotEmpty && this.transcodeHardwareDecoding) '(HW) ',
        if(this.transcodeVideoCodec.isNotEmpty) this.streamVideoFullResolution,
        ')',
    ].join();

    String get lsAudio => [
        this.audioDecision.name,
        ' (',
        this.audioCodec.toUpperCase(),
        if(this.transcodeAudioCodec.isNotEmpty) ' ${LunaUI.TEXT_ARROW_RIGHT} ',
        if(this.transcodeAudioCodec.isNotEmpty) this.transcodeAudioCodec.toUpperCase(),
        ')',
    ].join();

    String get lsSubtitle => [
        this.streamSubtitleDecision == TautulliTranscodeDecision.NULL ? 'Direct Play' : this.streamSubtitleDecision.name,
        ' (',
        this.subtitleCodec.toUpperCase(),
        ')',
    ].join();

    String lsArtworkPath(BuildContext context) {
        switch(this.mediaType) {
            case TautulliMediaType.EPISODE: return context.watch<TautulliState>().getImageURLFromRatingKey(this.grandparentRatingKey);
            case TautulliMediaType.TRACK: return context.watch<TautulliState>().getImageURLFromRatingKey(this.parentRatingKey);
            case TautulliMediaType.MOVIE:
            case TautulliMediaType.LIVE: 
            default: return context.watch<TautulliState>().getImageURLFromRatingKey(this.ratingKey);
        }
    }

    double get lsTranscodeProgress => min(1.0, max(0, this.transcodeProgress/100));
    double get lsProgressPercent => min(1.0, max(0, this.progressPercent/100));

    IconData get lsStateIcon {
        switch(this.state) {
            case TautulliSessionState.PAUSED: return Icons.pause;
            case TautulliSessionState.PLAYING: return Icons.play_arrow;
            case TautulliSessionState.BUFFERING:
            default: return Icons.compare_arrows;
        }
    }

    String get lsTranscodeDecision {
        switch(this.transcodeDecision) {
            case TautulliTranscodeDecision.TRANSCODE:
                String _transcodeStatus = this.transcodeThrottled ? 'Throttled' : '${this.transcodeSpeed ?? 0.0}x';
                return [
                    'Transcode',
                    ' ($_transcodeStatus)',
                ].join();
            case TautulliTranscodeDecision.DIRECT_PLAY:
            case TautulliTranscodeDecision.COPY:
            case TautulliTranscodeDecision.NULL:
            default: return this.transcodeDecision.name ?? 'Unknown';
        }
    }

    //////////////
    
    String get lunaTitle {
        if(this.grandparentTitle != null && this.grandparentTitle.isNotEmpty) return this.grandparentTitle;
        if(this.parentTitle != null && this.parentTitle.isNotEmpty) return this.parentTitle;
        if(this.title != null && this.title.isNotEmpty) return this.title;
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
                    'tautulli.Transcode'.tr(),
                    ' ($_transcodeStatus)',
                ].join();
            case TautulliTranscodeDecision.DIRECT_PLAY: return 'tautulli.DirectPlay'.tr();
            case TautulliTranscodeDecision.COPY: return 'tautulli.Copy'.tr();
            case TautulliTranscodeDecision.BURN: return 'tautulli.Burn'.tr();
            case TautulliTranscodeDecision.NULL:
            default: return 'lunasea.Unknown'.tr();
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
