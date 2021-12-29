import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrMediaInfoSheet extends LunaBottomModalSheet {
  final SonarrEpisodeFileMediaInfo? mediaInfo;

  SonarrMediaInfoSheet({
    required this.mediaInfo,
  });

  @override
  Widget builder(BuildContext context) {
    return LunaListViewModal(
      children: [
        LunaHeader(text: 'sonarr.Video'.tr()),
        LunaTableCard(
          content: [
            LunaTableContent(
              title: 'sonarr.BitDepth'.tr(),
              body: mediaInfo!.lunaVideoBitDepth,
            ),
            LunaTableContent(
              title: 'sonarr.Bitrate'.tr(),
              body: mediaInfo!.lunaVideoBitrate,
            ),
            LunaTableContent(
              title: 'sonarr.Codec'.tr(),
              body: mediaInfo!.lunaVideoCodec,
            ),
            LunaTableContent(
              title: 'sonarr.FPS'.tr(),
              body: mediaInfo!.lunaVideoFps,
            ),
            LunaTableContent(
              title: 'sonarr.Resolution'.tr(),
              body: mediaInfo!.lunaVideoResolution,
            ),
            LunaTableContent(
              title: 'sonarr.ScanType'.tr(),
              body: mediaInfo!.lunaVideoScanType,
            ),
          ],
        ),
        LunaHeader(text: 'sonarr.Audio'.tr()),
        LunaTableCard(
          content: [
            LunaTableContent(
              title: 'sonarr.Bitrate'.tr(),
              body: mediaInfo!.lunaAudioBitrate,
            ),
            LunaTableContent(
              title: 'sonarr.Channels'.tr(),
              body: mediaInfo!.lunaAudioChannels,
            ),
            LunaTableContent(
              title: 'sonarr.Codec'.tr(),
              body: mediaInfo!.lunaAudioCodec,
            ),
            LunaTableContent(
              title: 'sonarr.Languages'.tr(),
              body: mediaInfo!.lunaAudioLanguages,
            ),
            LunaTableContent(
              title: 'sonarr.Streams'.tr(),
              body: mediaInfo!.lunaAudioStreamCount,
            ),
          ],
        ),
        LunaHeader(text: 'sonarr.Other'.tr()),
        LunaTableCard(
          content: [
            LunaTableContent(
              title: 'sonarr.Runtime'.tr(),
              body: mediaInfo!.lunaRunTime,
            ),
            LunaTableContent(
              title: 'sonarr.Subtitles'.tr(),
              body: mediaInfo!.lunaSubtitles,
            ),
          ],
        ),
      ],
    );
  }
}
