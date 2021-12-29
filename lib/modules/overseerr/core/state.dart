import 'package:lunasea/core.dart';
import 'package:lunasea/modules/overseerr.dart';

class OverseerrState extends LunaModuleState {
  OverseerrState() {
    reset();
  }

  @override
  void reset() {
    resetProfile();
  }

  ///////////////
  /// PROFILE ///
  ///////////////

  /// API handler instance
  Overseerr? _api;
  Overseerr? get api => _api;

  /// Is the API enabled?
  bool? _enabled;
  bool? get enabled => _enabled;

  /// Overseerr host
  String? _host;
  String? get host => _host;

  /// Overseerr API key
  String? _apiKey;
  String? get apiKey => _apiKey;

  /// Headers to attach to all requests
  Map<dynamic, dynamic>? _headers;
  Map<dynamic, dynamic>? get headers => _headers;

  /// Reset the profile data, reinitializes API instance
  void resetProfile() {
    ProfileHiveObject _profile = Database.currentProfileObject!;
    // Copy profile into state
    _enabled = _profile.overseerrEnabled ?? false;
    _host = _profile.overseerrHost ?? '';
    _apiKey = _profile.overseerrKey ?? '';
    _headers = _profile.overseerrHeaders ?? {};
    // Create the API instance if Overseerr is enabled
    _api = !_enabled!
        ? null
        : Overseerr(
            host: _host!,
            apiKey: _apiKey!,
            headers: Map<String, dynamic>.from(_headers!),
          );
  }
}
