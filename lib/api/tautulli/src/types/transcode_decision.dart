part of tautulli_types;

/// Enumerator to handle all transcode decisions used in Tautulli.
enum TautulliTranscodeDecision {
  TRANSCODE,
  COPY,
  DIRECT_PLAY,
  BURN,
  NULL,
}

/// Extension on [TautulliTranscodeDecision] to implement extended functionality.
extension TautulliTranscodeDecisionExtension on TautulliTranscodeDecision {
  /// Given a String, will return the correct `TautulliTranscodeDecision` object.
  TautulliTranscodeDecision? from(String? decision) {
    switch (decision) {
      case 'transcode':
        return TautulliTranscodeDecision.TRANSCODE;
      case 'copy':
        return TautulliTranscodeDecision.COPY;
      case 'direct play':
        return TautulliTranscodeDecision.DIRECT_PLAY;
      case 'burn':
        return TautulliTranscodeDecision.BURN;
      case '':
        return TautulliTranscodeDecision.NULL;
    }
    return null;
  }

  /// The actual value/key for transcode decisions used in Tautulli.
  String? get value {
    switch (this) {
      case TautulliTranscodeDecision.TRANSCODE:
        return 'transcode';
      case TautulliTranscodeDecision.COPY:
        return 'copy';
      case TautulliTranscodeDecision.DIRECT_PLAY:
        return 'direct play';
      case TautulliTranscodeDecision.BURN:
        return 'burn';
      case TautulliTranscodeDecision.NULL:
        return '';
    }
  }

  /// Readable version of the transcode decision.
  String? get name {
    switch (this) {
      case TautulliTranscodeDecision.TRANSCODE:
        return 'Transcode';
      case TautulliTranscodeDecision.COPY:
        return 'Direct Stream';
      case TautulliTranscodeDecision.DIRECT_PLAY:
        return 'Direct Play';
      case TautulliTranscodeDecision.BURN:
        return 'Burn';
      case TautulliTranscodeDecision.NULL:
        return 'None';
    }
  }
}
