part of tautulli_types;

/// Enumerator to handle all image hosting services available in Tautulli.
enum TautulliImageHostService {
  IMGUR,
  CLOUDINARY,
  NULL,
}

/// Extension on [TautulliImageHostService] to implement extended functionality.
extension TautulliImageHostServiceExtension on TautulliImageHostService {
  /// The actual value/key for the image hosting services in Tautulli.
  String? get value {
    switch (this) {
      case TautulliImageHostService.IMGUR:
        return 'imgur';
      case TautulliImageHostService.CLOUDINARY:
        return 'cloudinary';
      case TautulliImageHostService.NULL:
        return '';
    }
  }
}
