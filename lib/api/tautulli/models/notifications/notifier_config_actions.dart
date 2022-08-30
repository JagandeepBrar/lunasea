import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'notifier_config_actions.g.dart';

/// Model to store information about a Tautulli notifier configuration actions.
@JsonSerializable(explicitToJson: true)
class TautulliNotifierConfigActions {
  /// Trigger on play?
  @JsonKey(name: 'on_play', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? onPlay;

  /// Trigger on stop?
  @JsonKey(name: 'on_stop', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? onStop;

  /// Trigger on pause?
  @JsonKey(name: 'on_pause', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? onPause;

  /// Trigger on resume?
  @JsonKey(name: 'on_resume', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? onResume;

  /// Trigger on transcode decision change?
  @JsonKey(name: 'on_change', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? onChange;

  /// Trigger on buffer warning?
  @JsonKey(name: 'on_buffer', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? onBuffer;

  /// Trigger on watched?
  @JsonKey(
      name: 'on_watched', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? onWatched;

  /// Trigger on concurrent streams passing threshold?
  @JsonKey(
      name: 'on_concurrent', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? onConcurrent;

  /// Trigger on new user device?
  @JsonKey(
      name: 'on_newdevice', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? onNewDevice;

  /// Trigger on created/new content?
  @JsonKey(
      name: 'on_created', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? onCreated;

  /// Trigger on Plex Media Server going down?
  @JsonKey(
      name: 'on_intdown', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? onPlexServerDown;

  /// Trigger on Plex Media Server going back up?
  @JsonKey(name: 'on_intup', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? onPlexServerUp;

  /// Trigger on Plex Media Server remote access going down?
  @JsonKey(
      name: 'on_extdown', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? onPlexServerRemoteAccessDown;

  /// Trigger on Plex Media Server remote access going back up?
  @JsonKey(name: 'on_extup', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? onPlexServerRemoteAccessUp;

  /// Trigger on Plex Media Server update?
  @JsonKey(
      name: 'on_pmsupdate', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? onPlexUpdate;

  /// Trigger on Tautulli update?
  @JsonKey(
      name: 'on_plexpyupdate',
      fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? onTautulliUpdate;

  /// Trigger on Tautulli database corruption?
  @JsonKey(
      name: 'on_plexpydbcorrupt',
      fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? onTautulliDatabaseCorruption;

  TautulliNotifierConfigActions({
    this.onPlay,
    this.onBuffer,
    this.onChange,
    this.onConcurrent,
    this.onCreated,
    this.onNewDevice,
    this.onPause,
    this.onPlexServerDown,
    this.onPlexServerRemoteAccessDown,
    this.onPlexServerRemoteAccessUp,
    this.onPlexServerUp,
    this.onPlexUpdate,
    this.onResume,
    this.onStop,
    this.onTautulliDatabaseCorruption,
    this.onTautulliUpdate,
    this.onWatched,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliNotifierConfigActions] object.
  factory TautulliNotifierConfigActions.fromJson(Map<String, dynamic> json) =>
      _$TautulliNotifierConfigActionsFromJson(json);

  /// Serialize a [TautulliNotifierConfigActions] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliNotifierConfigActionsToJson(this);
}
