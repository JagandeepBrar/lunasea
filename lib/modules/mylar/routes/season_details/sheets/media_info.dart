import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/mylar.dart';

class MylarMediaInfoSheet extends LunaBottomModalSheet {
  final MylarEpisodeFileMediaInfo? mediaInfo;

  MylarMediaInfoSheet({
    required this.mediaInfo,
  });

  @override
  Widget builder(BuildContext context) {
    return LunaListViewModal(
      children: [
        LunaHeader(text: 'mylar.Video'.tr()),
        LunaTableCard(
          content: [
            LunaTableContent(
              title: 'mylar.BitDepth'.tr(),
              body: mediaInfo!.lunaVideoBitDepth,
            ),
            LunaTableContent(
              title: 'mylar.Bitrate'.tr(),
              body: mediaInfo!.lunaVideoBitrate,
            ),
            LunaTableContent(
              title: 'mylar.Codec'.tr(),
              body: mediaInfo!.lunaVideoCodec,
            ),
            LunaTableContent(
              title: 'mylar.FPS'.tr(),
              body: mediaInfo!.lunaVideoFps,
            ),
            LunaTableContent(
              title: 'mylar.Resolution'.tr(),
              body: mediaInfo!.lunaVideoResolution,
            ),
            LunaTableContent(
              title: 'mylar.ScanType'.tr(),
              body: mediaInfo!.lunaVideoScanType,
            ),
          ],
        ),
        LunaHeader(text: 'mylar.Audio'.tr()),
        LunaTableCard(
          content: [
            LunaTableContent(
              title: 'mylar.Bitrate'.tr(),
              body: mediaInfo!.lunaAudioBitrate,
            ),
            LunaTableContent(
              title: 'mylar.Channels'.tr(),
              body: mediaInfo!.lunaAudioChannels,
            ),
            LunaTableContent(
              title: 'mylar.Codec'.tr(),
              body: mediaInfo!.lunaAudioCodec,
            ),
            LunaTableContent(
              title: 'mylar.Languages'.tr(),
              body: mediaInfo!.lunaAudioLanguages,
            ),
            LunaTableContent(
              title: 'mylar.Streams'.tr(),
              body: mediaInfo!.lunaAudioStreamCount,
            ),
          ],
        ),
        LunaHeader(text: 'mylar.Other'.tr()),
        LunaTableCard(
          content: [
            LunaTableContent(
              title: 'mylar.Runtime'.tr(),
              body: mediaInfo!.lunaRunTime,
            ),
            LunaTableContent(
              title: 'mylar.Subtitles'.tr(),
              body: mediaInfo!.lunaSubtitles,
            ),
          ],
        ),
      ],
    );
  }
}
