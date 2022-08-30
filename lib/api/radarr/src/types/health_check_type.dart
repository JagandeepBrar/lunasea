part of radarr_types;

/// Enumerator to handle all health check types used in Radarr.
enum RadarrHealthCheckType {
  NOTICE,
  WARNING,
  ERROR,
}

/// Extension on [RadarrHealthCheckType] to implement extended functionality.
extension RadarrHealthCheckTypeExtension on RadarrHealthCheckType {
  /// Given a String, will return the correct [RadarrHealthCheckType] object.
  RadarrHealthCheckType? from(String? type) {
    switch (type) {
      case 'notice':
        return RadarrHealthCheckType.NOTICE;
      case 'warning':
        return RadarrHealthCheckType.WARNING;
      case 'error':
        return RadarrHealthCheckType.ERROR;
      default:
        return null;
    }
  }

  String? get value {
    switch (this) {
      case RadarrHealthCheckType.NOTICE:
        return 'notice';
      case RadarrHealthCheckType.WARNING:
        return 'warning';
      case RadarrHealthCheckType.ERROR:
        return 'error';
      default:
        return null;
    }
  }

  String? get readable {
    switch (this) {
      case RadarrHealthCheckType.NOTICE:
        return 'Notice';
      case RadarrHealthCheckType.WARNING:
        return 'Warning';
      case RadarrHealthCheckType.ERROR:
        return 'Error';
      default:
        return null;
    }
  }
}
