import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/nzbget.dart';
import 'package:lunasea/modules/sabnzbd.dart';
import 'package:lunasea/modules/search.dart';
import 'package:lunasea/system/filesystem/filesystem.dart';

enum SearchDownloadType {
  NZBGET,
  SABNZBD,
  FILESYSTEM,
}

extension SearchDownloadTypeExtension on SearchDownloadType {
  String get name {
    switch (this) {
      case SearchDownloadType.NZBGET:
        return 'NZBGet';
      case SearchDownloadType.SABNZBD:
        return 'SABnzbd';
      case SearchDownloadType.FILESYSTEM:
        return 'search.DownloadToDevice'.tr();
    }
  }

  IconData get icon {
    switch (this) {
      case SearchDownloadType.NZBGET:
        return LunaModule.NZBGET.icon;
      case SearchDownloadType.SABNZBD:
        return LunaModule.SABNZBD.icon;
      case SearchDownloadType.FILESYSTEM:
        return Icons.download_rounded;
    }
  }

  Future<void> execute(BuildContext context, NewznabResultData data) async {
    switch (this) {
      case SearchDownloadType.NZBGET:
        return _executeNZBGet(context, data);
      case SearchDownloadType.SABNZBD:
        return _executeSABnzbd(context, data);
      case SearchDownloadType.FILESYSTEM:
        return _executeFileSystem(context, data);
    }
  }

  Future<void> _executeNZBGet(
      BuildContext context, NewznabResultData data) async {
    NZBGetAPI api = NZBGetAPI.from(LunaProfile.current);
    await api
        .uploadURL(data.linkDownload)
        .then((_) => showLunaSuccessSnackBar(
              title: 'search.SentNZBData'.tr(),
              message:
                  'search.SentTo'.tr(args: [SearchDownloadType.NZBGET.name]),
              showButton: true,
              buttonOnPressed: LunaModule.NZBGET.launch,
            ))
        .catchError((error, stack) {
      LunaLogger().error('Failed to download data', error, stack);
      return showLunaErrorSnackBar(
          title: 'search.FailedToSend'.tr(), error: error);
    });
  }

  Future<void> _executeSABnzbd(
      BuildContext context, NewznabResultData data) async {
    SABnzbdAPI api = SABnzbdAPI.from(LunaProfile.current);
    await api
        .uploadURL(data.linkDownload)
        .then((_) => showLunaSuccessSnackBar(
              title: 'search.SentNZBData'.tr(),
              message:
                  'search.SentTo'.tr(args: [SearchDownloadType.SABNZBD.name]),
              showButton: true,
              buttonOnPressed: LunaModule.SABNZBD.launch,
            ))
        .catchError((error, stack) {
      LunaLogger().error('Failed to download data', error, stack);
      return showLunaErrorSnackBar(
          title: 'search.FailedToSend'.tr(), error: error);
    });
  }

  Future<void> _executeFileSystem(
      BuildContext context, NewznabResultData data) async {
    showLunaInfoSnackBar(
      title: 'search.Downloading'.tr(),
      message: 'search.DownloadingNZBToDevice'.tr(),
    );
    String cleanTitle = data.title.replaceAll(RegExp(r'[^0-9a-zA-Z. -]+'), '');
    try {
      context
          .read<SearchState>()
          .api
          .downloadRelease(data)
          .then((download) async {
        bool result = await LunaFileSystem().save(
          context,
          '$cleanTitle.nzb',
          utf8.encode(download!),
        );
        if (result)
          showLunaSuccessSnackBar(
              title: 'Saved NZB', message: 'NZB has been successfully saved');
      });
    } catch (error, stack) {
      LunaLogger().error('Error downloading NZB', error, stack);
      showLunaErrorSnackBar(
          title: 'search.FailedToDownloadNZB'.tr(), error: error);
    }
  }
}
