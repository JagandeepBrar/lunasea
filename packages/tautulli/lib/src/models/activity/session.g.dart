// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliSession _$TautulliSessionFromJson(Map<String, dynamic> json) {
  return TautulliSession(
    sessionKey: TautulliUtilities.ensureIntegerFromJson(json['session_key']),
    mediaType:
        TautulliUtilities.mediaTypeFromJson(json['media_type'] as String?),
    viewOffset: TautulliUtilities.ensureIntegerFromJson(json['view_offset']),
    progressPercent:
        TautulliUtilities.ensureIntegerFromJson(json['progress_percent']),
    qualityProfile:
        TautulliUtilities.ensureStringFromJson(json['quality_profile']),
    syncedVersionProfile:
        TautulliUtilities.ensureStringFromJson(json['synced_version_profile']),
    optimizedVersionProfile: TautulliUtilities.ensureStringFromJson(
        json['optimized_version_profile']),
    user: TautulliUtilities.ensureStringFromJson(json['user']),
    channelStream:
        TautulliUtilities.ensureIntegerFromJson(json['channel_stream']),
    sectionId: TautulliUtilities.ensureIntegerFromJson(json['section_id']),
    libraryName: TautulliUtilities.ensureStringFromJson(json['library_name']),
    ratingKey: TautulliUtilities.ensureIntegerFromJson(json['rating_key']),
    parentRatingKey:
        TautulliUtilities.ensureIntegerFromJson(json['parent_rating_key']),
    grandparentRatingKey:
        TautulliUtilities.ensureIntegerFromJson(json['grandparent_rating_key']),
    title: TautulliUtilities.ensureStringFromJson(json['title']),
    parentTitle: TautulliUtilities.ensureStringFromJson(json['parent_title']),
    grandparentTitle:
        TautulliUtilities.ensureStringFromJson(json['grandparent_title']),
    originalTitle:
        TautulliUtilities.ensureStringFromJson(json['original_title']),
    sortTitle: TautulliUtilities.ensureStringFromJson(json['sort_title']),
    mediaIndex: TautulliUtilities.ensureIntegerFromJson(json['media_index']),
    parentMediaIndex:
        TautulliUtilities.ensureIntegerFromJson(json['parent_media_index']),
    studio: TautulliUtilities.ensureStringFromJson(json['studio']),
    contentRating:
        TautulliUtilities.ensureStringFromJson(json['content_rating']),
    summary: TautulliUtilities.ensureStringFromJson(json['summary']),
    tagline: TautulliUtilities.ensureStringFromJson(json['tagline']),
    rating: TautulliUtilities.ensureDoubleFromJson(json['rating']),
    ratingImage: TautulliUtilities.ensureStringFromJson(json['rating_image']),
    audienceRating:
        TautulliUtilities.ensureDoubleFromJson(json['audience_rating']),
    audienceRatingImage:
        TautulliUtilities.ensureStringFromJson(json['audience_rating_image']),
    userRating: TautulliUtilities.ensureDoubleFromJson(json['user_rating']),
    duration: TautulliUtilities.millisecondsDurationFromJson(json['duration']),
    year: TautulliUtilities.ensureIntegerFromJson(json['year']),
    thumb: TautulliUtilities.ensureStringFromJson(json['thumb']),
    parentThumb: TautulliUtilities.ensureStringFromJson(json['parent_thumb']),
    grandparentThumb:
        TautulliUtilities.ensureStringFromJson(json['grandparent_thumb']),
    art: TautulliUtilities.ensureStringFromJson(json['art']),
    banner: TautulliUtilities.ensureStringFromJson(json['banner']),
    originallyAvailableAt:
        TautulliUtilities.ensureStringFromJson(json['originally_available_at']),
    addedAt: TautulliUtilities.millisecondsDateTimeFromJson(json['added_at']),
    updatedAt:
        TautulliUtilities.millisecondsDateTimeFromJson(json['updated_at']),
    lastViewedAt:
        TautulliUtilities.millisecondsDateTimeFromJson(json['last_viewed_at']),
    guid: TautulliUtilities.ensureStringFromJson(json['guid']),
    parentGuid: TautulliUtilities.ensureStringFromJson(json['parent_guid']),
    grandparentGuid:
        TautulliUtilities.ensureStringFromJson(json['grandparent_guid']),
    directors: TautulliUtilities.ensureStringListFromJson(json['directors']),
    actors: TautulliUtilities.ensureStringListFromJson(json['actors']),
    writers: TautulliUtilities.ensureStringListFromJson(json['writers']),
    genres: TautulliUtilities.ensureStringListFromJson(json['genres']),
    labels: TautulliUtilities.ensureStringListFromJson(json['labels']),
    collections:
        TautulliUtilities.ensureStringListFromJson(json['collections']),
    fullTitle: TautulliUtilities.ensureStringFromJson(json['full_title']),
    childrenCount:
        TautulliUtilities.ensureIntegerFromJson(json['children_count']),
    live: TautulliUtilities.ensureBooleanFromJson(json['live']),
    id: TautulliUtilities.ensureIntegerFromJson(json['id']),
    container: TautulliUtilities.ensureStringFromJson(json['container']),
    bitrate: TautulliUtilities.ensureIntegerFromJson(json['bitrate']),
    height: TautulliUtilities.ensureIntegerFromJson(json['height']),
    width: TautulliUtilities.ensureIntegerFromJson(json['width']),
    aspectRatio: TautulliUtilities.ensureDoubleFromJson(json['aspect_ratio']),
    videoCodec: TautulliUtilities.ensureStringFromJson(json['video_codec']),
    videoResolution:
        TautulliUtilities.ensureStringFromJson(json['video_resolution']),
    videoFullResolution:
        TautulliUtilities.ensureStringFromJson(json['video_full_resolution']),
    videoFramerate:
        TautulliUtilities.ensureStringFromJson(json['video_framerate']),
    videoProfile: TautulliUtilities.ensureStringFromJson(json['video_profile']),
    audioCodec: TautulliUtilities.ensureStringFromJson(json['audio_codec']),
    audioChannels:
        TautulliUtilities.ensureIntegerFromJson(json['audio_channels']),
    audioChannelLayout:
        TautulliUtilities.ensureStringFromJson(json['audio_channel_layout']),
    audioProfile: TautulliUtilities.ensureStringFromJson(json['audio_profile']),
    optimizedVersion:
        TautulliUtilities.ensureBooleanFromJson(json['optimized_version']),
    channelCallSign:
        TautulliUtilities.ensureStringFromJson(json['channel_call_sign']),
    channelIdentifier:
        TautulliUtilities.ensureStringFromJson(json['channel_identifier']),
    channelThumb: TautulliUtilities.ensureStringFromJson(json['channel_thumb']),
    file: TautulliUtilities.ensureStringFromJson(json['file']),
    fileSize: TautulliUtilities.ensureIntegerFromJson(json['file_size']),
    indexes: TautulliUtilities.ensureBooleanFromJson(json['indexes']),
    selected: TautulliUtilities.ensureBooleanFromJson(json['selected']),
    type: TautulliUtilities.ensureIntegerFromJson(json['type']),
    videoCodecLevel:
        TautulliUtilities.ensureStringFromJson(json['video_codec_level']),
    videoBitrate:
        TautulliUtilities.ensureIntegerFromJson(json['video_bitrate']),
    videoBitDepth:
        TautulliUtilities.ensureIntegerFromJson(json['video_bit_depth']),
    videoChromaSubsampling: TautulliUtilities.ensureStringFromJson(
        json['video_chroma_subsampling']),
    videoColorPrimaries:
        TautulliUtilities.ensureStringFromJson(json['video_color_primaries']),
    videoColorRange:
        TautulliUtilities.ensureStringFromJson(json['video_color_range']),
    videoColorSpace:
        TautulliUtilities.ensureStringFromJson(json['video_color_space']),
    videoColorTRC:
        TautulliUtilities.ensureStringFromJson(json['video_color_trc']),
    videoFrameRate:
        TautulliUtilities.ensureDoubleFromJson(json['video_frame_rate']),
    videoRefFrames:
        TautulliUtilities.ensureIntegerFromJson(json['video_ref_frames']),
    videoHeight: TautulliUtilities.ensureIntegerFromJson(json['video_height']),
    videoWidth: TautulliUtilities.ensureIntegerFromJson(json['video_width']),
    videoLanguage:
        TautulliUtilities.ensureStringFromJson(json['video_language']),
    videoLanguageCode:
        TautulliUtilities.ensureStringFromJson(json['video_language_code']),
    videoDynamicRange:
        TautulliUtilities.ensureStringFromJson(json['video_dynamic_range']),
    videoScanType:
        TautulliUtilities.ensureStringFromJson(json['video_scan_type']),
    audioBitrate:
        TautulliUtilities.ensureIntegerFromJson(json['audio_bitrate']),
    audioBitrateMode:
        TautulliUtilities.ensureStringFromJson(json['audio_bitrate_mode']),
    audioSampleRate:
        TautulliUtilities.ensureIntegerFromJson(json['audio_sample_rate']),
    audioLanguage:
        TautulliUtilities.ensureStringFromJson(json['audio_language']),
    audioLanguageCode:
        TautulliUtilities.ensureStringFromJson(json['audio_language_code']),
    subtitleCodec:
        TautulliUtilities.ensureStringFromJson(json['subtitle_codec']),
    subtitleContainer:
        TautulliUtilities.ensureStringFromJson(json['subtitle_container']),
    subtitleFormat:
        TautulliUtilities.ensureStringFromJson(json['subtitle_format']),
    subtitleForced:
        TautulliUtilities.ensureBooleanFromJson(json['subtitle_forced']),
    subtitleLanguage:
        TautulliUtilities.ensureStringFromJson(json['subtitle_language']),
    subtitleLanguageCode:
        TautulliUtilities.ensureStringFromJson(json['subtitle_language_code']),
    subtitleLocation:
        TautulliUtilities.ensureStringFromJson(json['subtitle_location']),
    rowId: TautulliUtilities.ensureIntegerFromJson(json['row_id']),
    userId: TautulliUtilities.ensureIntegerFromJson(json['user_id']),
    username: TautulliUtilities.ensureStringFromJson(json['username']),
    friendlyName: TautulliUtilities.ensureStringFromJson(json['friendly_name']),
    userThumb: TautulliUtilities.ensureStringFromJson(json['user_thumb']),
    email: TautulliUtilities.ensureStringFromJson(json['email']),
    isActive: TautulliUtilities.ensureBooleanFromJson(json['is_active']),
    isAdmin: TautulliUtilities.ensureBooleanFromJson(json['is_admin']),
    isHomeUser: TautulliUtilities.ensureBooleanFromJson(json['is_home_user']),
    isAllowSync: TautulliUtilities.ensureBooleanFromJson(json['is_allow_sync']),
    isRestricted:
        TautulliUtilities.ensureBooleanFromJson(json['is_restricted']),
    doNotify: TautulliUtilities.ensureBooleanFromJson(json['do_notify']),
    keepHistory: TautulliUtilities.ensureBooleanFromJson(json['keep_history']),
    deletedUser: TautulliUtilities.ensureBooleanFromJson(json['deleted_user']),
    allowGuest: TautulliUtilities.ensureBooleanFromJson(json['allow_guest']),
    sharedLibraries:
        TautulliUtilities.ensureIntegerListFromJson(json['shared_libraries']),
    ipAddress: TautulliUtilities.ensureStringFromJson(json['ip_address']),
    ipAddressPublic:
        TautulliUtilities.ensureStringFromJson(json['ip_address_public']),
    device: TautulliUtilities.ensureStringFromJson(json['device']),
    platform: TautulliUtilities.ensureStringFromJson(json['platform']),
    platformName: TautulliUtilities.ensureStringFromJson(json['platform_name']),
    platformVersion:
        TautulliUtilities.ensureStringFromJson(json['platform_version']),
    product: TautulliUtilities.ensureStringFromJson(json['product']),
    productVersion:
        TautulliUtilities.ensureStringFromJson(json['product_version']),
    profile: TautulliUtilities.ensureStringFromJson(json['profile']),
    player: TautulliUtilities.ensureStringFromJson(json['player']),
    machineId: TautulliUtilities.ensureStringFromJson(json['machine_id']),
    state: TautulliUtilities.sessionStateFromJson(json['state'] as String?),
    local: TautulliUtilities.ensureBooleanFromJson(json['local']),
    relayed: TautulliUtilities.ensureBooleanFromJson(json['relayed']),
    secure: TautulliUtilities.ensureBooleanFromJson(json['secure']),
    sessionId: TautulliUtilities.ensureStringFromJson(json['session_id']),
    bandwidth: TautulliUtilities.ensureIntegerFromJson(json['bandwidth']),
    location:
        TautulliUtilities.sessionLocationFromJson(json['location'] as String?),
    transcodeKey: TautulliUtilities.ensureStringFromJson(json['transcode_key']),
    transcodeThrottled:
        TautulliUtilities.ensureBooleanFromJson(json['transcode_throttled']),
    transcodeProgress:
        TautulliUtilities.ensureIntegerFromJson(json['transcode_progress']),
    transcodeSpeed:
        TautulliUtilities.ensureDoubleFromJson(json['transcode_speed']),
    transcodeAudioChannels: TautulliUtilities.ensureIntegerFromJson(
        json['transcode_audio_channels']),
    transcodeAudioCodec:
        TautulliUtilities.ensureStringFromJson(json['transcode_audio_codec']),
    transcodeVideoCodec:
        TautulliUtilities.ensureStringFromJson(json['transcode_video_codec']),
    transcodeWidth:
        TautulliUtilities.ensureIntegerFromJson(json['transcode_width']),
    transcodeHeight:
        TautulliUtilities.ensureIntegerFromJson(json['transcode_height']),
    transcodeContainer:
        TautulliUtilities.ensureStringFromJson(json['transcode_container']),
    transcodeProtocol:
        TautulliUtilities.ensureStringFromJson(json['transcode_protocol']),
    transcodeHardwareRequested:
        TautulliUtilities.ensureBooleanFromJson(json['transcode_hw_requested']),
    transcodeHardwareDecode:
        TautulliUtilities.ensureStringFromJson(json['transcode_hw_decode']),
    transcodeHardwareDecodeTitle: TautulliUtilities.ensureStringFromJson(
        json['transcode_hw_decode_title']),
    transcodeHardwarEencode:
        TautulliUtilities.ensureStringFromJson(json['transcode_hw_encode']),
    transcodeHardwarEencodeTitle: TautulliUtilities.ensureStringFromJson(
        json['transcode_hw_encode_title']),
    transcodeHardwareFullPipeline: TautulliUtilities.ensureBooleanFromJson(
        json['transcode_hw_full_pipeline']),
    audioDecision: TautulliUtilities.transcodeDecisionFromJson(
        json['audio_decision'] as String?),
    videoDecision: TautulliUtilities.transcodeDecisionFromJson(
        json['video_decision'] as String?),
    subtitleDecision: TautulliUtilities.transcodeDecisionFromJson(
        json['subtitle_decision'] as String?),
    throttled: TautulliUtilities.ensureBooleanFromJson(json['throttled']),
    transcodeHardwareDecoding:
        TautulliUtilities.ensureBooleanFromJson(json['transcode_hw_decoding']),
    transcodeHardwareEncoding:
        TautulliUtilities.ensureBooleanFromJson(json['transcode_hw_encoding']),
    streamContainer:
        TautulliUtilities.ensureStringFromJson(json['stream_container']),
    streamBitrate:
        TautulliUtilities.ensureIntegerFromJson(json['stream_bitrate']),
    streamAspectRatio:
        TautulliUtilities.ensureDoubleFromJson(json['stream_aspect_ratio']),
    streamAudioCodec:
        TautulliUtilities.ensureStringFromJson(json['stream_audio_codec']),
    streamAudioChannels:
        TautulliUtilities.ensureIntegerFromJson(json['stream_audio_channels']),
    streamAudioChannelLayout: TautulliUtilities.ensureStringFromJson(
        json['stream_audio_channel_layout']),
    streamAudioChannelLayout_: TautulliUtilities.ensureStringFromJson(
        json['stream_audio_channel_layout_']),
    streamVideoCodec:
        TautulliUtilities.ensureStringFromJson(json['stream_video_codec']),
    streamVideoFramerate:
        TautulliUtilities.ensureStringFromJson(json['stream_video_framerate']),
    streamVideoResolution:
        TautulliUtilities.ensureStringFromJson(json['stream_video_resolution']),
    streamVideoHeight:
        TautulliUtilities.ensureIntegerFromJson(json['stream_video_height']),
    streamVideoWidth:
        TautulliUtilities.ensureIntegerFromJson(json['stream_video_width']),
    streamDuration:
        TautulliUtilities.millisecondsDurationFromJson(json['stream_duration']),
    streamContainerDecision: TautulliUtilities.transcodeDecisionFromJson(
        json['stream_container_decision'] as String?),
    optimizedVersionTitle:
        TautulliUtilities.ensureStringFromJson(json['optimized_version_title']),
    syncedVersion:
        TautulliUtilities.ensureBooleanFromJson(json['synced_version']),
    liveUuid: TautulliUtilities.ensureStringFromJson(json['live_uuid']),
    bifThumb: TautulliUtilities.ensureStringFromJson(json['bif_thumb']),
    transcodeDecision: TautulliUtilities.transcodeDecisionFromJson(
        json['transcode_decision'] as String?),
    subtitles: TautulliUtilities.ensureBooleanFromJson(json['subtitles']),
    streamVideoFullResolution: TautulliUtilities.ensureStringFromJson(
        json['stream_video_full_resolution']),
    streamVideoDynamicRange: TautulliUtilities.ensureStringFromJson(
        json['stream_video_dynamic_range']),
    streamVideoBitDepth:
        TautulliUtilities.ensureIntegerFromJson(json['stream_video_bit_depth']),
    streamVideoBitrate:
        TautulliUtilities.ensureIntegerFromJson(json['stream_video_bitrate']),
    streamVideoChromaSubsampling: TautulliUtilities.ensureStringFromJson(
        json['stream_video_chroma_subsampling']),
    streamVideoCodecLevel: TautulliUtilities.ensureStringFromJson(
        json['stream_video_codec_level']),
    streamVideoColorPrimaries: TautulliUtilities.ensureStringFromJson(
        json['stream_video_color_primaries']),
    streamVideoColorRange: TautulliUtilities.ensureStringFromJson(
        json['stream_video_color_range']),
    streamVideoColorSpace: TautulliUtilities.ensureStringFromJson(
        json['stream_video_color_space']),
    streamVideoColorTRC:
        TautulliUtilities.ensureStringFromJson(json['stream_video_color_trc']),
    streamVideoRefFrames: TautulliUtilities.ensureIntegerFromJson(
        json['stream_video_ref_frames']),
    streamVideoDecision: TautulliUtilities.transcodeDecisionFromJson(
        json['stream_video_decision'] as String?),
    streamVideoLanguage:
        TautulliUtilities.ensureStringFromJson(json['stream_video_language']),
    streamVideoLanguageCode: TautulliUtilities.ensureStringFromJson(
        json['stream_video_language_code']),
    streamVideoScanType:
        TautulliUtilities.ensureStringFromJson(json['stream_video_scan_type']),
    streamAudioBitrate:
        TautulliUtilities.ensureIntegerFromJson(json['stream_audio_bitrate']),
    streamAudioBitrateMode: TautulliUtilities.ensureStringFromJson(
        json['stream_audio_bitrate_mode']),
    streamAudioDecision: TautulliUtilities.transcodeDecisionFromJson(
        json['stream_audio_decision'] as String?),
    streamAudioLanguage:
        TautulliUtilities.ensureStringFromJson(json['stream_audio_language']),
    streamAudioLanguageCode: TautulliUtilities.ensureStringFromJson(
        json['stream_audio_language_code']),
    streamAudioSampleRate: TautulliUtilities.ensureIntegerFromJson(
        json['stream_audio_sample_rate']),
    streamSubtitleCodec:
        TautulliUtilities.ensureStringFromJson(json['stream_subtitle_codec']),
    streamSubtitleContainer: TautulliUtilities.ensureStringFromJson(
        json['stream_subtitle_container']),
    streamSubtitleDecision: TautulliUtilities.transcodeDecisionFromJson(
        json['stream_subtitle_decision'] as String?),
    streamSubtitleForced:
        TautulliUtilities.ensureBooleanFromJson(json['stream_subtitle_forced']),
    streamSubtitleFormat:
        TautulliUtilities.ensureStringFromJson(json['stream_subtitle_format']),
    streamSubtitleLanguage: TautulliUtilities.ensureStringFromJson(
        json['stream_subtitle_language']),
    streamSubtitleLanguageCode: TautulliUtilities.ensureStringFromJson(
        json['stream_subtitle_language_code']),
    streamSubtitleLocation: TautulliUtilities.ensureStringFromJson(
        json['stream_subtitle_location']),
    streamSubtitleTransient: TautulliUtilities.ensureBooleanFromJson(
        json['stream_subtitle_transient']),
  );
}

Map<String, dynamic> _$TautulliSessionToJson(TautulliSession instance) =>
    <String, dynamic>{
      'media_type': TautulliUtilities.mediaTypeToJson(instance.mediaType),
      'session_key': instance.sessionKey,
      'view_offset': instance.viewOffset,
      'progress_percent': instance.progressPercent,
      'quality_profile': instance.qualityProfile,
      'synced_version_profile': instance.syncedVersionProfile,
      'optimized_version_profile': instance.optimizedVersionProfile,
      'user': instance.user,
      'channel_stream': instance.channelStream,
      'section_id': instance.sectionId,
      'library_name': instance.libraryName,
      'rating_key': instance.ratingKey,
      'parent_rating_key': instance.parentRatingKey,
      'grandparent_rating_key': instance.grandparentRatingKey,
      'title': instance.title,
      'parent_title': instance.parentTitle,
      'grandparent_title': instance.grandparentTitle,
      'original_title': instance.originalTitle,
      'sort_title': instance.sortTitle,
      'media_index': instance.mediaIndex,
      'parent_media_index': instance.parentMediaIndex,
      'studio': instance.studio,
      'content_rating': instance.contentRating,
      'summary': instance.summary,
      'tagline': instance.tagline,
      'rating': instance.rating,
      'rating_image': instance.ratingImage,
      'audience_rating': instance.audienceRating,
      'audience_rating_image': instance.audienceRatingImage,
      'user_rating': instance.userRating,
      'duration': instance.duration?.inMicroseconds,
      'year': instance.year,
      'thumb': instance.thumb,
      'parent_thumb': instance.parentThumb,
      'grandparent_thumb': instance.grandparentThumb,
      'art': instance.art,
      'banner': instance.banner,
      'originally_available_at': instance.originallyAvailableAt,
      'added_at': instance.addedAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'last_viewed_at': instance.lastViewedAt?.toIso8601String(),
      'guid': instance.guid,
      'parent_guid': instance.parentGuid,
      'grandparent_guid': instance.grandparentGuid,
      'directors': instance.directors,
      'writers': instance.writers,
      'actors': instance.actors,
      'genres': instance.genres,
      'labels': instance.labels,
      'collections': instance.collections,
      'full_title': instance.fullTitle,
      'children_count': instance.childrenCount,
      'live': instance.live,
      'id': instance.id,
      'container': instance.container,
      'bitrate': instance.bitrate,
      'height': instance.height,
      'width': instance.width,
      'aspect_ratio': instance.aspectRatio,
      'video_codec': instance.videoCodec,
      'video_resolution': instance.videoResolution,
      'video_full_resolution': instance.videoFullResolution,
      'video_framerate': instance.videoFramerate,
      'video_profile': instance.videoProfile,
      'audio_codec': instance.audioCodec,
      'audio_channels': instance.audioChannels,
      'audio_channel_layout': instance.audioChannelLayout,
      'audio_profile': instance.audioProfile,
      'optimized_version': instance.optimizedVersion,
      'channel_call_sign': instance.channelCallSign,
      'channel_identifier': instance.channelIdentifier,
      'channel_thumb': instance.channelThumb,
      'file': instance.file,
      'file_size': instance.fileSize,
      'indexes': instance.indexes,
      'selected': instance.selected,
      'type': instance.type,
      'video_codec_level': instance.videoCodecLevel,
      'video_bitrate': instance.videoBitrate,
      'video_bit_depth': instance.videoBitDepth,
      'video_chroma_subsampling': instance.videoChromaSubsampling,
      'video_color_primaries': instance.videoColorPrimaries,
      'video_color_range': instance.videoColorRange,
      'video_color_space': instance.videoColorSpace,
      'video_color_trc': instance.videoColorTRC,
      'video_frame_rate': instance.videoFrameRate,
      'video_ref_frames': instance.videoRefFrames,
      'video_height': instance.videoHeight,
      'video_width': instance.videoWidth,
      'video_language': instance.videoLanguage,
      'video_language_code': instance.videoLanguageCode,
      'video_scan_type': instance.videoScanType,
      'video_dynamic_range': instance.videoDynamicRange,
      'audio_bitrate': instance.audioBitrate,
      'audio_bitrate_mode': instance.audioBitrateMode,
      'audio_sample_rate': instance.audioSampleRate,
      'audio_language': instance.audioLanguage,
      'audio_language_code': instance.audioLanguageCode,
      'subtitle_codec': instance.subtitleCodec,
      'subtitle_container': instance.subtitleContainer,
      'subtitle_format': instance.subtitleFormat,
      'subtitle_forced': instance.subtitleForced,
      'subtitle_location': instance.subtitleLocation,
      'subtitle_language': instance.subtitleLanguage,
      'subtitle_language_code': instance.subtitleLanguageCode,
      'row_id': instance.rowId,
      'user_id': instance.userId,
      'username': instance.username,
      'friendly_name': instance.friendlyName,
      'user_thumb': instance.userThumb,
      'email': instance.email,
      'is_active': instance.isActive,
      'is_admin': instance.isAdmin,
      'is_home_user': instance.isHomeUser,
      'is_allow_sync': instance.isAllowSync,
      'is_restricted': instance.isRestricted,
      'do_notify': instance.doNotify,
      'keep_history': instance.keepHistory,
      'deleted_user': instance.deletedUser,
      'allow_guest': instance.allowGuest,
      'shared_libraries': instance.sharedLibraries,
      'ip_address': instance.ipAddress,
      'ip_address_public': instance.ipAddressPublic,
      'device': instance.device,
      'platform': instance.platform,
      'platform_name': instance.platformName,
      'platform_version': instance.platformVersion,
      'product': instance.product,
      'product_version': instance.productVersion,
      'profile': instance.profile,
      'player': instance.player,
      'machine_id': instance.machineId,
      'state': TautulliUtilities.sessionStateToJson(instance.state),
      'local': instance.local,
      'relayed': instance.relayed,
      'secure': instance.secure,
      'session_id': instance.sessionId,
      'bandwidth': instance.bandwidth,
      'location': TautulliUtilities.sessionLocationToJson(instance.location),
      'transcode_key': instance.transcodeKey,
      'transcode_throttled': instance.transcodeThrottled,
      'transcode_progress': instance.transcodeProgress,
      'transcode_speed': instance.transcodeSpeed,
      'transcode_audio_channels': instance.transcodeAudioChannels,
      'transcode_audio_codec': instance.transcodeAudioCodec,
      'transcode_video_codec': instance.transcodeVideoCodec,
      'transcode_height': instance.transcodeHeight,
      'transcode_width': instance.transcodeWidth,
      'transcode_container': instance.transcodeContainer,
      'transcode_protocol': instance.transcodeProtocol,
      'transcode_hw_requested': instance.transcodeHardwareRequested,
      'transcode_hw_decode': instance.transcodeHardwareDecode,
      'transcode_hw_decode_title': instance.transcodeHardwareDecodeTitle,
      'transcode_hw_encode': instance.transcodeHardwarEencode,
      'transcode_hw_encode_title': instance.transcodeHardwarEencodeTitle,
      'transcode_hw_full_pipeline': instance.transcodeHardwareFullPipeline,
      'audio_decision':
          TautulliUtilities.transcodeDecisionToJson(instance.audioDecision),
      'video_decision':
          TautulliUtilities.transcodeDecisionToJson(instance.videoDecision),
      'subtitle_decision':
          TautulliUtilities.transcodeDecisionToJson(instance.subtitleDecision),
      'throttled': instance.throttled,
      'transcode_hw_decoding': instance.transcodeHardwareDecoding,
      'transcode_hw_encoding': instance.transcodeHardwareEncoding,
      'stream_container': instance.streamContainer,
      'stream_bitrate': instance.streamBitrate,
      'stream_aspect_ratio': instance.streamAspectRatio,
      'stream_audio_codec': instance.streamAudioCodec,
      'stream_audio_channels': instance.streamAudioChannels,
      'stream_audio_channel_layout': instance.streamAudioChannelLayout,
      'stream_audio_channel_layout_': instance.streamAudioChannelLayout_,
      'stream_video_codec': instance.streamVideoCodec,
      'stream_video_resolution': instance.streamVideoResolution,
      'stream_video_framerate': instance.streamVideoFramerate,
      'stream_video_height': instance.streamVideoHeight,
      'stream_video_width': instance.streamVideoWidth,
      'stream_duration': instance.streamDuration?.inMicroseconds,
      'stream_container_decision': TautulliUtilities.transcodeDecisionToJson(
          instance.streamContainerDecision),
      'optimized_version_title': instance.optimizedVersionTitle,
      'synced_version': instance.syncedVersion,
      'live_uuid': instance.liveUuid,
      'bif_thumb': instance.bifThumb,
      'transcode_decision':
          TautulliUtilities.transcodeDecisionToJson(instance.transcodeDecision),
      'subtitles': instance.subtitles,
      'stream_video_full_resolution': instance.streamVideoFullResolution,
      'stream_video_dynamic_range': instance.streamVideoDynamicRange,
      'stream_video_codec_level': instance.streamVideoCodecLevel,
      'stream_video_bitrate': instance.streamVideoBitrate,
      'stream_video_bit_depth': instance.streamVideoBitDepth,
      'stream_video_chroma_subsampling': instance.streamVideoChromaSubsampling,
      'stream_video_color_primaries': instance.streamVideoColorPrimaries,
      'stream_video_color_range': instance.streamVideoColorRange,
      'stream_video_color_space': instance.streamVideoColorSpace,
      'stream_video_color_trc': instance.streamVideoColorTRC,
      'stream_video_ref_frames': instance.streamVideoRefFrames,
      'stream_video_language': instance.streamVideoLanguage,
      'stream_video_language_code': instance.streamVideoLanguageCode,
      'stream_video_scan_type': instance.streamVideoScanType,
      'stream_video_decision': TautulliUtilities.transcodeDecisionToJson(
          instance.streamVideoDecision),
      'stream_audio_bitrate': instance.streamAudioBitrate,
      'stream_audio_bitrate_mode': instance.streamAudioBitrateMode,
      'stream_audio_sample_rate': instance.streamAudioSampleRate,
      'stream_audio_language': instance.streamAudioLanguage,
      'stream_audio_language_code': instance.streamAudioLanguageCode,
      'stream_audio_decision': TautulliUtilities.transcodeDecisionToJson(
          instance.streamAudioDecision),
      'stream_subtitle_codec': instance.streamSubtitleCodec,
      'stream_subtitle_container': instance.streamSubtitleContainer,
      'stream_subtitle_format': instance.streamSubtitleFormat,
      'stream_subtitle_forced': instance.streamSubtitleForced,
      'stream_subtitle_location': instance.streamSubtitleLocation,
      'stream_subtitle_language': instance.streamSubtitleLanguage,
      'stream_subtitle_language_code': instance.streamSubtitleLanguageCode,
      'stream_subtitle_transient': instance.streamSubtitleTransient,
      'stream_subtitle_decision': TautulliUtilities.transcodeDecisionToJson(
          instance.streamSubtitleDecision),
    };
