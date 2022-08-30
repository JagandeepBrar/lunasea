import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/string/string.dart';
import 'package:lunasea/modules/lidarr.dart';
import 'package:lunasea/router/routes/lidarr.dart';

class LidarrCatalogueTile extends StatefulWidget {
  final LidarrCatalogueData data;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function refresh;
  final Function refreshState;

  const LidarrCatalogueTile({
    Key? key,
    required this.data,
    required this.scaffoldKey,
    required this.refresh,
    required this.refreshState,
  }) : super(key: key);

  @override
  State<LidarrCatalogueTile> createState() => _State();
}

class _State extends State<LidarrCatalogueTile> {
  @override
  Widget build(BuildContext context) {
    return Selector<LidarrState, LidarrCatalogueSorting>(
      selector: (_, state) => state.sortCatalogueType,
      builder: (context, sortingType, _) => LunaBlock(
        title: widget.data.title,
        disabled: !widget.data.monitored!,
        body: [
          TextSpan(
            children: [
              TextSpan(text: widget.data.albums),
              TextSpan(text: LunaUI.TEXT_BULLET.pad()),
              TextSpan(text: widget.data.tracks),
            ],
          ),
          TextSpan(text: widget.data.subtitle(sortingType)),
        ],
        trailing: LunaIconButton(
          icon: widget.data.monitored!
              ? LunaIcons.MONITOR_ON
              : LunaIcons.MONITOR_OFF,
          onPressed: _toggleMonitoredStatus,
        ),
        posterPlaceholderIcon: LunaIcons.USER,
        posterUrl: widget.data.posterURI(),
        posterHeaders: LunaProfile.current.lidarrHeaders,
        backgroundUrl: widget.data.fanartURI(),
        backgroundHeaders: LunaProfile.current.lidarrHeaders,
        posterIsSquare: true,
        onTap: () async => _enterArtist(),
        onLongPress: () async => _handlePopup(),
      ),
    );
  }

  Future<void> _toggleMonitoredStatus() async {
    final _api = LidarrAPI.from(LunaProfile.current);
    await _api
        .toggleArtistMonitored(widget.data.artistID, !widget.data.monitored!)
        .then((_) {
      if (mounted)
        setState(() => widget.data.monitored = !widget.data.monitored!);
      widget.refreshState();
      showLunaSuccessSnackBar(
        title: widget.data.monitored! ? 'Monitoring' : 'No Longer Monitoring',
        message: widget.data.title,
      );
    }).catchError((error) {
      showLunaErrorSnackBar(
        title: widget.data.monitored!
            ? 'Failed to Stop Monitoring'
            : 'Failed to Monitor',
        error: error,
      );
    });
  }

  Future<void> _enterArtist() async {
    LidarrRoutes.ARTIST.go(
      extra: widget.data,
      params: {
        'artist': widget.data.artistID.toString(),
      },
    );
  }

  Future<void> _handlePopup() async {
    List<dynamic> values = await LidarrDialogs.editArtist(context, widget.data);
    if (values[0])
      switch (values[1]) {
        case 'refresh_artist':
          _refreshArtist();
          break;
        case 'edit_artist':
          _enterEditArtist();
          break;
        case 'remove_artist':
          _removeArtist();
          break;
        default:
          LunaLogger()
              .warning('Invalid method passed through popup. (${values[1]})');
      }
  }

  Future<void> _enterEditArtist() async {
    LidarrRoutes.ARTIST_EDIT.go(
      extra: widget.data,
      params: {
        'artist': widget.data.artistID.toString(),
      },
    );
  }

  Future<void> _refreshArtist() async {
    final _api = LidarrAPI.from(LunaProfile.current);
    await _api
        .refreshArtist(widget.data.artistID)
        .then((_) => showLunaSuccessSnackBar(
            title: 'Refreshing...', message: widget.data.title))
        .catchError((error) =>
            showLunaErrorSnackBar(title: 'Failed to Refresh', error: error));
  }

  Future<void> _removeArtist() async {
    final _api = LidarrAPI.from(LunaProfile.current);
    List values = await LidarrDialogs.deleteArtist(context);
    if (values[0]) {
      if (values[1]) {
        values = await LunaDialogs()
            .deleteCatalogueWithFiles(context, widget.data.title);
        if (values[0]) {
          await _api
              .removeArtist(widget.data.artistID, deleteFiles: true)
              .then((_) {
            showLunaSuccessSnackBar(
                title: 'Removed (With Data)', message: widget.data.title);
            widget.refresh();
          }).catchError((error) {
            showLunaErrorSnackBar(
              title: 'Failed to Remove (With Data)',
              error: error,
            );
          });
        }
      } else {
        await _api
            .removeArtist(widget.data.artistID, deleteFiles: false)
            .then((_) {
          showLunaSuccessSnackBar(title: 'Removed', message: widget.data.title);
          widget.refresh();
        }).catchError((error) {
          showLunaErrorSnackBar(
            title: 'Failed to Remove',
            error: error,
          );
        });
      }
    }
  }
}
