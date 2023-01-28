import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'session.g.dart';

/// Model for a single activity session in Tautulli.
@JsonSerializable(explicitToJson: true)
class TautulliSession {
  /// Type of media in this session.
  @JsonKey(
      name: 'media_type',
      toJson: TautulliUtilities.mediaTypeToJson,
      fromJson: TautulliUtilities.mediaTypeFromJson)
  final TautulliMediaType? mediaType;

  /// Session's key/identifier.
  @JsonKey(
      name: 'session_key', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? sessionKey;

  /// _Unknown_: Somehow related to the progress percentage.
  @JsonKey(
      name: 'view_offset', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? viewOffset;

  /// How much of the content has been played.
  @JsonKey(
      name: 'progress_percent',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? progressPercent;

  /// Quality profile of the stream.
  @JsonKey(
      name: 'quality_profile', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? qualityProfile;

  /// Quality of the synced version of the content.
  @JsonKey(
      name: 'synced_version_profile',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? syncedVersionProfile;

  /// Quality of the optimized version of the content.
  @JsonKey(
      name: 'optimized_version_profile',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? optimizedVersionProfile;

  /// The user streaming the content.
  @JsonKey(name: 'user', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? user;

  /// _Unknown_: Likely related to live TV streams.
  @JsonKey(
      name: 'channel_stream', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? channelStream;

  /// Plex section ID the content belongs to.
  @JsonKey(
      name: 'section_id', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? sectionId;

  /// Name of the Plex library that the content belongs to.
  @JsonKey(
      name: 'library_name', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? libraryName;

  /// The content's unique ID from Plex.
  @JsonKey(
      name: 'rating_key', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? ratingKey;

  /// The content's parent's unique ID from Plex.
  @JsonKey(
      name: 'parent_rating_key',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? parentRatingKey;

  /// The content's grandparent's unique ID from Plex.
  @JsonKey(
      name: 'grandparent_rating_key',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? grandparentRatingKey;

  /// Title of the content.
  @JsonKey(name: 'title', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? title;

  /// Title of the parent of the content.
  @JsonKey(
      name: 'parent_title', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? parentTitle;

  /// Title of the grandparent of the content.
  @JsonKey(
      name: 'grandparent_title',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? grandparentTitle;

  /// The original title of the content.
  @JsonKey(
      name: 'original_title', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? originalTitle;

  /// The sort title of the content (if different from the title).
  @JsonKey(name: 'sort_title', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? sortTitle;

  /// The index of the content with respect to its parent (for example, track number in an album).
  @JsonKey(
      name: 'media_index', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? mediaIndex;

  /// The index of the parent of the content.
  @JsonKey(
      name: 'parent_media_index',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? parentMediaIndex;

  /// The studio that made the content.
  @JsonKey(name: 'studio', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? studio;

  /// The content rating for the content.
  @JsonKey(
      name: 'content_rating', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? contentRating;

  /// The summary of the content.
  @JsonKey(name: 'summary', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? summary;

  /// The tagline of the content.
  @JsonKey(name: 'tagline', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? tagline;

  /// The critic rating of the content.
  @JsonKey(name: 'rating', fromJson: TautulliUtilities.ensureDoubleFromJson)
  final double? rating;

  /// Link to an image for the critic rating.
  @JsonKey(
      name: 'rating_image', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? ratingImage;

  /// The audience rating of the content.
  @JsonKey(
      name: 'audience_rating', fromJson: TautulliUtilities.ensureDoubleFromJson)
  final double? audienceRating;

  /// Link to an image for the audience rating.
  @JsonKey(
      name: 'audience_rating_image',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? audienceRatingImage;

  /// The user rating of the content.
  @JsonKey(
      name: 'user_rating', fromJson: TautulliUtilities.ensureDoubleFromJson)
  final double? userRating;

  /// Duration of the content.
  @JsonKey(
      name: 'duration',
      fromJson: TautulliUtilities.millisecondsDurationFromJson)
  final Duration? duration;

  /// Year the content was released.
  @JsonKey(name: 'year', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? year;

  /// Thumbnail path for the content.
  @JsonKey(name: 'thumb', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? thumb;

  /// Thumbnail path for the content's parent.
  @JsonKey(
      name: 'parent_thumb', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? parentThumb;

  /// Thumbnail path for the content's grandparent.
  @JsonKey(
      name: 'grandparent_thumb',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? grandparentThumb;

  /// Artwork path for the content.
  @JsonKey(name: 'art', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? art;

  /// Banner path for the content.
  @JsonKey(name: 'banner', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? banner;

  /// The date on which the content was originally available on.
  ///
  /// Because of the custom formatting options, the DateTime is returned as a string.
  /// You can use the miscellaneous call `getDateFormats()` to pull the date and time formatting strings.
  @JsonKey(
      name: 'originally_available_at',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? originallyAvailableAt;

  /// The date on which the content was added to Plex.
  /// This is typically read/stored as the file creation date within Plex.
  @JsonKey(
      name: 'added_at',
      fromJson: TautulliUtilities.millisecondsDateTimeFromJson)
  final DateTime? addedAt;

  /// The date on which the content was last updated on Plex.
  @JsonKey(
      name: 'updated_at',
      fromJson: TautulliUtilities.millisecondsDateTimeFromJson)
  final DateTime? updatedAt;

  /// The date on which the content was last viewed on Plex.
  @JsonKey(
      name: 'last_viewed_at',
      fromJson: TautulliUtilities.millisecondsDateTimeFromJson)
  final DateTime? lastViewedAt;

  /// The globally unique identifier for the content.
  @JsonKey(name: 'guid', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? guid;

  /// The globally unique identifier for the content's parent.
  @JsonKey(
      name: 'parent_guid', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? parentGuid;

  /// The globally unique identifier for the content's grandparent.
  @JsonKey(
      name: 'grandparent_guid',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? grandparentGuid;

  /// List of director's names who directed the content.
  @JsonKey(
      name: 'directors', fromJson: TautulliUtilities.ensureStringListFromJson)
  final List<String?>? directors;

  /// List of writer's names who wrote the content.
  @JsonKey(
      name: 'writers', fromJson: TautulliUtilities.ensureStringListFromJson)
  final List<String?>? writers;

  /// List of actors's names who acted in the content.
  @JsonKey(name: 'actors', fromJson: TautulliUtilities.ensureStringListFromJson)
  final List<String?>? actors;

  /// List of genres of the content.
  @JsonKey(name: 'genres', fromJson: TautulliUtilities.ensureStringListFromJson)
  final List<String?>? genres;

  /// List of labels that have been attached on Plex.
  @JsonKey(name: 'labels', fromJson: TautulliUtilities.ensureStringListFromJson)
  final List<String?>? labels;

  /// List of collections the content is apart of on Plex.
  @JsonKey(
      name: 'collections', fromJson: TautulliUtilities.ensureStringListFromJson)
  final List<String?>? collections;

  /// The full title of the content.
  @JsonKey(name: 'full_title', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? fullTitle;

  /// The amount of children this content has.
  @JsonKey(
      name: 'children_count', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? childrenCount;

  /// Is this session live content?
  @JsonKey(name: 'live', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? live;

  /// The ID of the content.
  @JsonKey(name: 'id', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? id;

  /// The media container type of the content.
  @JsonKey(name: 'container', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? container;

  /// Bitrate of the content.
  @JsonKey(name: 'bitrate', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? bitrate;

  /// Height in pixels.
  @JsonKey(name: 'height', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? height;

  /// Width in pixels.
  @JsonKey(name: 'width', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? width;

  /// Aspect ratio of the content.
  @JsonKey(
      name: 'aspect_ratio', fromJson: TautulliUtilities.ensureDoubleFromJson)
  final double? aspectRatio;

  /// Codec of the video stream.
  @JsonKey(
      name: 'video_codec', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? videoCodec;

  /// Resolution of the video stream.
  @JsonKey(
      name: 'video_resolution',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? videoResolution;

  /// Full resolution of the video stream.
  @JsonKey(
      name: 'video_full_resolution',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? videoFullResolution;

  /// Framerate of the video stream.
  @JsonKey(
      name: 'video_framerate', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? videoFramerate;

  /// Profile of the video stream.
  @JsonKey(
      name: 'video_profile', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? videoProfile;

  /// Codec of the audio stream.
  @JsonKey(
      name: 'audio_codec', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? audioCodec;

  /// Number of channels in the audio stream.
  @JsonKey(
      name: 'audio_channels', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? audioChannels;

  /// The layout of the channels in the audio stream.
  @JsonKey(
      name: 'audio_channel_layout',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? audioChannelLayout;

  /// Profile of the audio stream.
  @JsonKey(
      name: 'audio_profile', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? audioProfile;

  /// Is this session using an optimized version?
  @JsonKey(
      name: 'optimized_version',
      fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? optimizedVersion;

  /// The channel's callsign for live content.
  @JsonKey(
      name: 'channel_call_sign',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? channelCallSign;

  /// The channel's identifier for live content.
  @JsonKey(
      name: 'channel_identifier',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? channelIdentifier;

  /// The channel's thumbnail for live content.
  @JsonKey(
      name: 'channel_thumb', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? channelThumb;

  /// The path to the file on your system.
  @JsonKey(name: 'file', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? file;

  /// The size of the file, in bytes.
  @JsonKey(name: 'file_size', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? fileSize;

  /// Does the file have generated index files?
  @JsonKey(name: 'indexes', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? indexes;

  /// _Unknown_
  @JsonKey(name: 'selected', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? selected;

  /// _Unknown_
  @JsonKey(name: 'type', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? type;

  /// Codec level of the video stream.
  @JsonKey(
      name: 'video_codec_level',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? videoCodecLevel;

  /// Bitrate of the video stream.
  @JsonKey(
      name: 'video_bitrate', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? videoBitrate;

  /// Bit depth of the video stream.
  @JsonKey(
      name: 'video_bit_depth',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? videoBitDepth;

  /// Chroma subsampling of the video stream.
  @JsonKey(
      name: 'video_chroma_subsampling',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? videoChromaSubsampling;

  /// Color primaries of the video stream.
  @JsonKey(
      name: 'video_color_primaries',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? videoColorPrimaries;

  /// Color range of the video stream.
  @JsonKey(
      name: 'video_color_range',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? videoColorRange;

  /// Color space of the video stream.
  @JsonKey(
      name: 'video_color_space',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? videoColorSpace;

  /// Color TRC of the video stream.
  @JsonKey(
      name: 'video_color_trc', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? videoColorTRC;

  /// Frame rate of the video stream.
  @JsonKey(
      name: 'video_frame_rate',
      fromJson: TautulliUtilities.ensureDoubleFromJson)
  final double? videoFrameRate;

  /// Reference frames in the video stream.
  @JsonKey(
      name: 'video_ref_frames',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? videoRefFrames;

  /// Height in pixels of the video stream.
  @JsonKey(
      name: 'video_height', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? videoHeight;

  /// Width in pixels of the video stream.
  @JsonKey(
      name: 'video_width', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? videoWidth;

  /// Language of the video stream.
  @JsonKey(
      name: 'video_language', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? videoLanguage;

  /// Language code of the video stream.
  @JsonKey(
      name: 'video_language_code',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? videoLanguageCode;

  /// Scan type of the video stream.
  @JsonKey(
      name: 'video_scan_type', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? videoScanType;

  /// Dynamic range of the video stream.
  @JsonKey(
      name: 'video_dynamic_range',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? videoDynamicRange;

  /// Bitrate of the audio stream.
  @JsonKey(
      name: 'audio_bitrate', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? audioBitrate;

  /// Bitrate mode of the audio stream.
  @JsonKey(
      name: 'audio_bitrate_mode',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? audioBitrateMode;

  /// Sample rate of the audio stream.
  @JsonKey(
      name: 'audio_sample_rate',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? audioSampleRate;

  /// Language of the audio stream.
  @JsonKey(
      name: 'audio_language', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? audioLanguage;

  /// Language code of the audio stream.
  @JsonKey(
      name: 'audio_language_code',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? audioLanguageCode;

  /// Codec of the subtitle stream.
  @JsonKey(
      name: 'subtitle_codec', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? subtitleCodec;

  /// Container of the subtitle stream.
  @JsonKey(
      name: 'subtitle_container',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? subtitleContainer;

  /// Format of the subtitle stream.
  @JsonKey(
      name: 'subtitle_format', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? subtitleFormat;

  /// Is the subtitle stream forced?
  @JsonKey(
      name: 'subtitle_forced',
      fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? subtitleForced;

  /// Location of the subtitle stream.
  @JsonKey(
      name: 'subtitle_location',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? subtitleLocation;

  /// Language of the subtitle stream.
  @JsonKey(
      name: 'subtitle_language',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? subtitleLanguage;

  /// Language code of the subtitle stream.
  @JsonKey(
      name: 'subtitle_language_code',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? subtitleLanguageCode;

  /// Row identifier of the streaming user.
  @JsonKey(name: 'row_id', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? rowId;

  /// User identifier of the streaming user.
  @JsonKey(name: 'user_id', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? userId;

  /// Username of the streaming user.
  @JsonKey(name: 'username', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? username;

  /// Friendly name of the streaming user.
  @JsonKey(
      name: 'friendly_name', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? friendlyName;

  /// Thumbnail link of the streaming user.
  @JsonKey(name: 'user_thumb', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? userThumb;

  /// Email of the streaming user.
  @JsonKey(name: 'email', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? email;

  /// Is the user active?
  @JsonKey(name: 'is_active', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? isActive;

  /// Is the user an admin?
  @JsonKey(name: 'is_admin', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? isAdmin;

  /// Is the user a home user?
  @JsonKey(
      name: 'is_home_user', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? isHomeUser;

  /// Is the user allowed to sync content?
  @JsonKey(
      name: 'is_allow_sync', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? isAllowSync;

  /// Is the user restricted?
  @JsonKey(
      name: 'is_restricted', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? isRestricted;

  /// Does the user get notified?
  @JsonKey(name: 'do_notify', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? doNotify;

  /// Is history enabled for the user?
  @JsonKey(
      name: 'keep_history', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? keepHistory;

  /// Is the user deleted?
  @JsonKey(
      name: 'deleted_user', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? deletedUser;

  /// Does the user have guest access to Tautulli?
  @JsonKey(
      name: 'allow_guest', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? allowGuest;

  /// List of libraries that are shared with this user.
  @JsonKey(
      name: 'shared_libraries',
      fromJson: TautulliUtilities.ensureIntegerListFromJson)
  final List<int?>? sharedLibraries;

  /// IP address of the streaming device.
  @JsonKey(name: 'ip_address', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? ipAddress;

  /// Public IP address of the streaming device.
  @JsonKey(
      name: 'ip_address_public',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? ipAddressPublic;

  /// Streaming device name.
  @JsonKey(name: 'device', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? device;

  /// Platform of the streaming device.
  @JsonKey(name: 'platform', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? platform;

  /// Name of the streaming device.
  @JsonKey(
      name: 'platform_name', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? platformName;

  /// Version of the streaming device.
  @JsonKey(
      name: 'platform_version',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? platformVersion;

  /// Plex product name on the streaming device.
  @JsonKey(name: 'product', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? product;

  /// Plex product version on the streaming device.
  @JsonKey(
      name: 'product_version', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? productVersion;

  /// Plex profile on the streaming device.
  @JsonKey(name: 'profile', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? profile;

  /// Name of the streaming device/player.
  @JsonKey(name: 'player', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? player;

  /// Unique machine identifier key.
  @JsonKey(name: 'machine_id', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? machineId;

  /// Current state of the session.
  @JsonKey(
      name: 'state',
      toJson: TautulliUtilities.sessionStateToJson,
      fromJson: TautulliUtilities.sessionStateFromJson)
  final TautulliSessionState? state;

  /// Is it a local stream?
  @JsonKey(name: 'local', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? local;

  /// Is it a relayed stream?
  @JsonKey(name: 'relayed', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? relayed;

  /// Is it a secure stream?
  @JsonKey(name: 'secure', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? secure;

  /// Session ID of the stream.
  @JsonKey(name: 'session_id', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? sessionId;

  /// The total bandwidth usage of the session.
  @JsonKey(name: 'bandwidth', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? bandwidth;

  /// Location of the stream session (LAN or WAN).
  @JsonKey(
      name: 'location',
      toJson: TautulliUtilities.sessionLocationToJson,
      fromJson: TautulliUtilities.sessionLocationFromJson)
  final TautulliSessionLocation? location;

  /// Transcoder key/identifier for the session.
  @JsonKey(
      name: 'transcode_key', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? transcodeKey;

  /// Is the transcoder throttled?
  @JsonKey(
      name: 'transcode_throttled',
      fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? transcodeThrottled;

  /// Progress of the transcoder for the session.
  @JsonKey(
      name: 'transcode_progress',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? transcodeProgress;

  /// Transcoder speed for the session.
  @JsonKey(
      name: 'transcode_speed', fromJson: TautulliUtilities.ensureDoubleFromJson)
  final double? transcodeSpeed;

  /// Number of audio channels in the transcode stream.
  @JsonKey(
      name: 'transcode_audio_channels',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? transcodeAudioChannels;

  /// Audio codec of the transcode stream.
  @JsonKey(
      name: 'transcode_audio_codec',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? transcodeAudioCodec;

  /// Video codec of the transcode stream.
  @JsonKey(
      name: 'transcode_video_codec',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? transcodeVideoCodec;

  /// Height in pixels of the video in the transcode stream.
  @JsonKey(
      name: 'transcode_height',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? transcodeHeight;

  /// Width in pixels of the video in the transcode stream.
  @JsonKey(
      name: 'transcode_width',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? transcodeWidth;

  /// Container used for the transcode stream.
  @JsonKey(
      name: 'transcode_container',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? transcodeContainer;

  /// Protocol used to transmit the transcode stream.
  @JsonKey(
      name: 'transcode_protocol',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? transcodeProtocol;

  /// Did the transcoder request hardware acceleration?
  @JsonKey(
      name: 'transcode_hw_requested',
      fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? transcodeHardwareRequested;

  /// Hardware decode of the transcode stream.
  @JsonKey(
      name: 'transcode_hw_decode',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? transcodeHardwareDecode;

  /// Hardware decode title of the transcode stream.
  @JsonKey(
      name: 'transcode_hw_decode_title',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? transcodeHardwareDecodeTitle;

  /// Hardware encode of the transcode stream.
  @JsonKey(
      name: 'transcode_hw_encode',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? transcodeHardwareEncode;

  /// Hardware encode title of the transcode stream.
  @JsonKey(
      name: 'transcode_hw_encode_title',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? transcodeHardwareEncodeTitle;

  /// Is the transcoder using hardware acceleration for the full pipeline?
  @JsonKey(
      name: 'transcode_hw_full_pipeline',
      fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? transcodeHardwareFullPipeline;

  /// What decision was made on how to handle the audio stream.
  @JsonKey(
      name: 'audio_decision',
      toJson: TautulliUtilities.transcodeDecisionToJson,
      fromJson: TautulliUtilities.transcodeDecisionFromJson)
  final TautulliTranscodeDecision? audioDecision;

  /// What decision was made on how to handle the video stream.
  @JsonKey(
      name: 'video_decision',
      toJson: TautulliUtilities.transcodeDecisionToJson,
      fromJson: TautulliUtilities.transcodeDecisionFromJson)
  final TautulliTranscodeDecision? videoDecision;

  /// What decision was made on how to handle the subtitle stream.
  @JsonKey(
      name: 'subtitle_decision',
      toJson: TautulliUtilities.transcodeDecisionToJson,
      fromJson: TautulliUtilities.transcodeDecisionFromJson)
  final TautulliTranscodeDecision? subtitleDecision;

  /// Is the transcoder throttled?
  @JsonKey(name: 'throttled', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? throttled;

  /// Is the transcoder using hardware acceleration for decoding?
  @JsonKey(
      name: 'transcode_hw_decoding',
      fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? transcodeHardwareDecoding;

  /// Is the transcoder using hardware acceleration for encoding?
  @JsonKey(
      name: 'transcode_hw_encoding',
      fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? transcodeHardwareEncoding;

  /// Container used for the final stream.
  @JsonKey(
      name: 'stream_container',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? streamContainer;

  /// Bitrate of the final stream.
  @JsonKey(
      name: 'stream_bitrate', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? streamBitrate;

  /// Aspect ratio of the final video stream.
  @JsonKey(
      name: 'stream_aspect_ratio',
      fromJson: TautulliUtilities.ensureDoubleFromJson)
  final double? streamAspectRatio;

  /// Codec of the final audio stream.
  @JsonKey(
      name: 'stream_audio_codec',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? streamAudioCodec;

  /// Number of channels in the final audio stream.
  @JsonKey(
      name: 'stream_audio_channels',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? streamAudioChannels;

  /// The layout of the channels in the final audio stream.
  @JsonKey(
      name: 'stream_audio_channel_layout',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? streamAudioChannelLayout;

  /// The layout of the channels in the final audio stream. Unsure how this is different from [streamAudioChannelLayout].
  @JsonKey(
      name: 'stream_audio_channel_layout_',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? streamAudioChannelLayout_;

  /// Codec of the final video stream.
  @JsonKey(
      name: 'stream_video_codec',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? streamVideoCodec;

  /// Resolution of the final video stream.
  @JsonKey(
      name: 'stream_video_resolution',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? streamVideoResolution;

  /// Framerate of the final video stream.
  @JsonKey(
      name: 'stream_video_framerate',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? streamVideoFramerate;

  /// Height in pixels of the final video stream.
  @JsonKey(
      name: 'stream_video_height',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? streamVideoHeight;

  /// Width in pixels of the final video stream.
  @JsonKey(
      name: 'stream_video_width',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? streamVideoWidth;

  /// Duration of the final stream.
  @JsonKey(
      name: 'stream_duration',
      fromJson: TautulliUtilities.millisecondsDurationFromJson)
  final Duration? streamDuration;

  /// What decision was made on how to handle the final container of the stream.
  @JsonKey(
      name: 'stream_container_decision',
      toJson: TautulliUtilities.transcodeDecisionToJson,
      fromJson: TautulliUtilities.transcodeDecisionFromJson)
  final TautulliTranscodeDecision? streamContainerDecision;

  /// Optimized version title.
  @JsonKey(
      name: 'optimized_version_title',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? optimizedVersionTitle;

  /// Is the stream a synced version of the content?
  @JsonKey(
      name: 'synced_version', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? syncedVersion;

  /// UUID of the live stream session.
  @JsonKey(name: 'live_uuid', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? liveUuid;

  /// Location of the content's BIF thumbnail
  @JsonKey(name: 'bif_thumb', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? bifThumb;

  /// What decision was made on how to handle the content.
  @JsonKey(
      name: 'transcode_decision',
      toJson: TautulliUtilities.transcodeDecisionToJson,
      fromJson: TautulliUtilities.transcodeDecisionFromJson)
  final TautulliTranscodeDecision? transcodeDecision;

  /// Are subtitles being used for this session?
  @JsonKey(name: 'subtitles', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? subtitles;

  /// Full resolution of the final video stream.
  @JsonKey(
      name: 'stream_video_full_resolution',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? streamVideoFullResolution;

  /// Dynamic range of the final video stream.
  @JsonKey(
      name: 'stream_video_dynamic_range',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? streamVideoDynamicRange;

  /// Codec level of the final video stream.
  @JsonKey(
      name: 'stream_video_codec_level',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? streamVideoCodecLevel;

  /// Bitrate of the final video stream.
  @JsonKey(
      name: 'stream_video_bitrate',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? streamVideoBitrate;

  /// Bit depth of the final video stream.
  @JsonKey(
      name: 'stream_video_bit_depth',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? streamVideoBitDepth;

  /// Chroma subsampling of the final video stream.
  @JsonKey(
      name: 'stream_video_chroma_subsampling',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? streamVideoChromaSubsampling;

  /// Color primaries of the final video stream.
  @JsonKey(
      name: 'stream_video_color_primaries',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? streamVideoColorPrimaries;

  /// Color range of the final video stream.
  @JsonKey(
      name: 'stream_video_color_range',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? streamVideoColorRange;

  /// Color space of the final video stream.
  @JsonKey(
      name: 'stream_video_color_space',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? streamVideoColorSpace;

  /// Color TRC of the final video stream.
  @JsonKey(
      name: 'stream_video_color_trc',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? streamVideoColorTRC;

  /// Reference frames in the final video stream.
  @JsonKey(
      name: 'stream_video_ref_frames',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? streamVideoRefFrames;

  /// Language of the final video stream.
  @JsonKey(
      name: 'stream_video_language',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? streamVideoLanguage;

  /// Language code of the final video stream.
  @JsonKey(
      name: 'stream_video_language_code',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? streamVideoLanguageCode;

  /// Scan type of the final video stream.
  @JsonKey(
      name: 'stream_video_scan_type',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? streamVideoScanType;

  /// What decision was made on how to handle the final video stream.
  @JsonKey(
      name: 'stream_video_decision',
      toJson: TautulliUtilities.transcodeDecisionToJson,
      fromJson: TautulliUtilities.transcodeDecisionFromJson)
  final TautulliTranscodeDecision? streamVideoDecision;

  /// Bitrate of the final audio stream.
  @JsonKey(
      name: 'stream_audio_bitrate',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? streamAudioBitrate;

  /// Bitrate mode of the final audio stream.
  @JsonKey(
      name: 'stream_audio_bitrate_mode',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? streamAudioBitrateMode;

  /// Sample rate of the final audio stream.
  @JsonKey(
      name: 'stream_audio_sample_rate',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? streamAudioSampleRate;

  /// Language of the final audio stream.
  @JsonKey(
      name: 'stream_audio_language',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? streamAudioLanguage;

  /// Language code of the final audio stream.
  @JsonKey(
      name: 'stream_audio_language_code',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? streamAudioLanguageCode;

  /// What decision was made on how to handle the final video stream.
  @JsonKey(
      name: 'stream_audio_decision',
      toJson: TautulliUtilities.transcodeDecisionToJson,
      fromJson: TautulliUtilities.transcodeDecisionFromJson)
  final TautulliTranscodeDecision? streamAudioDecision;

  /// Codec of the final subtitle stream.
  @JsonKey(
      name: 'stream_subtitle_codec',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? streamSubtitleCodec;

  /// Container of the final subtitle stream.
  @JsonKey(
      name: 'stream_subtitle_container',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? streamSubtitleContainer;

  /// Format of the final subtitle stream.
  @JsonKey(
      name: 'stream_subtitle_format',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? streamSubtitleFormat;

  /// Is the final subtitle stream forced?
  @JsonKey(
      name: 'stream_subtitle_forced',
      fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? streamSubtitleForced;

  /// Location of the final subtitle stream.
  @JsonKey(
      name: 'stream_subtitle_location',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? streamSubtitleLocation;

  /// Language of the final subtitle stream.
  @JsonKey(
      name: 'stream_subtitle_language',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? streamSubtitleLanguage;

  /// Language code of the final subtitle stream.
  @JsonKey(
      name: 'stream_subtitle_language_code',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? streamSubtitleLanguageCode;

  /// Is the final subtitle stream transient?
  @JsonKey(
      name: 'stream_subtitle_transient',
      fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? streamSubtitleTransient;

  /// What decision was made on how to handle the final subtitle stream.
  @JsonKey(
      name: 'stream_subtitle_decision',
      toJson: TautulliUtilities.transcodeDecisionToJson,
      fromJson: TautulliUtilities.transcodeDecisionFromJson)
  final TautulliTranscodeDecision? streamSubtitleDecision;

  TautulliSession({
    this.sessionKey,
    this.mediaType,
    this.viewOffset,
    this.progressPercent,
    this.qualityProfile,
    this.syncedVersionProfile,
    this.optimizedVersionProfile,
    this.user,
    this.channelStream,
    this.sectionId,
    this.libraryName,
    this.ratingKey,
    this.parentRatingKey,
    this.grandparentRatingKey,
    this.title,
    this.parentTitle,
    this.grandparentTitle,
    this.originalTitle,
    this.sortTitle,
    this.mediaIndex,
    this.parentMediaIndex,
    this.studio,
    this.contentRating,
    this.summary,
    this.tagline,
    this.rating,
    this.ratingImage,
    this.audienceRating,
    this.audienceRatingImage,
    this.userRating,
    this.duration,
    this.year,
    this.thumb,
    this.parentThumb,
    this.grandparentThumb,
    this.art,
    this.banner,
    this.originallyAvailableAt,
    this.addedAt,
    this.updatedAt,
    this.lastViewedAt,
    this.guid,
    this.parentGuid,
    this.grandparentGuid,
    this.directors,
    this.actors,
    this.writers,
    this.genres,
    this.labels,
    this.collections,
    this.fullTitle,
    this.childrenCount,
    this.live,
    this.id,
    this.container,
    this.bitrate,
    this.height,
    this.width,
    this.aspectRatio,
    this.videoCodec,
    this.videoResolution,
    this.videoFullResolution,
    this.videoFramerate,
    this.videoProfile,
    this.audioCodec,
    this.audioChannels,
    this.audioChannelLayout,
    this.audioProfile,
    this.optimizedVersion,
    this.channelCallSign,
    this.channelIdentifier,
    this.channelThumb,
    this.file,
    this.fileSize,
    this.indexes,
    this.selected,
    this.type,
    this.videoCodecLevel,
    this.videoBitrate,
    this.videoBitDepth,
    this.videoChromaSubsampling,
    this.videoColorPrimaries,
    this.videoColorRange,
    this.videoColorSpace,
    this.videoColorTRC,
    this.videoFrameRate,
    this.videoRefFrames,
    this.videoHeight,
    this.videoWidth,
    this.videoLanguage,
    this.videoLanguageCode,
    this.videoDynamicRange,
    this.videoScanType,
    this.audioBitrate,
    this.audioBitrateMode,
    this.audioSampleRate,
    this.audioLanguage,
    this.audioLanguageCode,
    this.subtitleCodec,
    this.subtitleContainer,
    this.subtitleFormat,
    this.subtitleForced,
    this.subtitleLanguage,
    this.subtitleLanguageCode,
    this.subtitleLocation,
    this.rowId,
    this.userId,
    this.username,
    this.friendlyName,
    this.userThumb,
    this.email,
    this.isActive,
    this.isAdmin,
    this.isHomeUser,
    this.isAllowSync,
    this.isRestricted,
    this.doNotify,
    this.keepHistory,
    this.deletedUser,
    this.allowGuest,
    this.sharedLibraries,
    this.ipAddress,
    this.ipAddressPublic,
    this.device,
    this.platform,
    this.platformName,
    this.platformVersion,
    this.product,
    this.productVersion,
    this.profile,
    this.player,
    this.machineId,
    this.state,
    this.local,
    this.relayed,
    this.secure,
    this.sessionId,
    this.bandwidth,
    this.location,
    this.transcodeKey,
    this.transcodeThrottled,
    this.transcodeProgress,
    this.transcodeSpeed,
    this.transcodeAudioChannels,
    this.transcodeAudioCodec,
    this.transcodeVideoCodec,
    this.transcodeWidth,
    this.transcodeHeight,
    this.transcodeContainer,
    this.transcodeProtocol,
    this.transcodeHardwareRequested,
    this.transcodeHardwareDecode,
    this.transcodeHardwareDecodeTitle,
    this.transcodeHardwareEncode,
    this.transcodeHardwareEncodeTitle,
    this.transcodeHardwareFullPipeline,
    this.audioDecision,
    this.videoDecision,
    this.subtitleDecision,
    this.throttled,
    this.transcodeHardwareDecoding,
    this.transcodeHardwareEncoding,
    this.streamContainer,
    this.streamBitrate,
    this.streamAspectRatio,
    this.streamAudioCodec,
    this.streamAudioChannels,
    this.streamAudioChannelLayout,
    this.streamAudioChannelLayout_,
    this.streamVideoCodec,
    this.streamVideoFramerate,
    this.streamVideoResolution,
    this.streamVideoHeight,
    this.streamVideoWidth,
    this.streamDuration,
    this.streamContainerDecision,
    this.optimizedVersionTitle,
    this.syncedVersion,
    this.liveUuid,
    this.bifThumb,
    this.transcodeDecision,
    this.subtitles,
    this.streamVideoFullResolution,
    this.streamVideoDynamicRange,
    this.streamVideoBitDepth,
    this.streamVideoBitrate,
    this.streamVideoChromaSubsampling,
    this.streamVideoCodecLevel,
    this.streamVideoColorPrimaries,
    this.streamVideoColorRange,
    this.streamVideoColorSpace,
    this.streamVideoColorTRC,
    this.streamVideoRefFrames,
    this.streamVideoDecision,
    this.streamVideoLanguage,
    this.streamVideoLanguageCode,
    this.streamVideoScanType,
    this.streamAudioBitrate,
    this.streamAudioBitrateMode,
    this.streamAudioDecision,
    this.streamAudioLanguage,
    this.streamAudioLanguageCode,
    this.streamAudioSampleRate,
    this.streamSubtitleCodec,
    this.streamSubtitleContainer,
    this.streamSubtitleDecision,
    this.streamSubtitleForced,
    this.streamSubtitleFormat,
    this.streamSubtitleLanguage,
    this.streamSubtitleLanguageCode,
    this.streamSubtitleLocation,
    this.streamSubtitleTransient,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliSession] object.
  factory TautulliSession.fromJson(Map<String, dynamic> json) =>
      _$TautulliSessionFromJson(json);

  /// Serialize a [TautulliSession] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliSessionToJson(this);
}
