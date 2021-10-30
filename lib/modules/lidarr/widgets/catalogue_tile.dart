import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrCatalogueTile extends StatefulWidget {
  final LidarrCatalogueData data;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function refresh;
  final Function refreshState;

  const LidarrCatalogueTile({
    Key key,
    @required this.data,
    @required this.scaffoldKey,
    @required this.refresh,
    @required this.refreshState,
  }) : super(key: key);

  @override
  State<LidarrCatalogueTile> createState() => _State();
}

class _State extends State<LidarrCatalogueTile> {
  @override
  Widget build(BuildContext context) => LunaListTile(
        context: context,
        title: LunaText.title(
          text: widget.data.title,
          darken: !widget.data.monitored,
        ),
        subtitle: Selector<LidarrState, LidarrCatalogueSorting>(
          selector: (_, state) => state.sortCatalogueType,
          builder: (context, type, _) => LunaText.subtitle(
            text: widget.data.subtitle(type),
            darken: !widget.data.monitored,
            maxLines: 2,
          ),
        ),
        trailing: LunaIconButton(
          icon: widget.data.monitored ? Icons.turned_in : Icons.turned_in_not,
          color: widget.data.monitored ? Colors.white : Colors.white30,
          onPressed: _toggleMonitoredStatus,
        ),
        contentPadding: true,
        decoration: LunaCardDecoration(
          uri: widget.data.bannerURI(),
          headers: Database.currentProfileObject.getLidarr()['headers'],
        ),
        onTap: () async => _enterArtist(),
        onLongPress: () async => _handlePopup(),
      );

  Future<void> _toggleMonitoredStatus() async {
    final _api = LidarrAPI.from(Database.currentProfileObject);
    await _api
        .toggleArtistMonitored(widget.data.artistID, !widget.data.monitored)
        .then((_) {
      if (mounted)
        setState(() => widget.data.monitored = !widget.data.monitored);
      widget.refreshState();
      showLunaSuccessSnackBar(
        title: widget.data.monitored ? 'Monitoring' : 'No Longer Monitoring',
        message: widget.data.title,
      );
    }).catchError((error) {
      showLunaErrorSnackBar(
        title: widget.data.monitored
            ? 'Failed to Stop Monitoring'
            : 'Failed to Monitor',
        error: error,
      );
    });
  }

  Future<void> _enterArtist() async {
    final dynamic result = await Navigator.of(context).pushNamed(
      LidarrDetailsArtist.ROUTE_NAME,
      arguments: LidarrDetailsArtistArguments(
        data: widget.data,
        artistID: widget.data.artistID,
      ),
    );
    if (result != null)
      switch (result[0]) {
        case 'remove_artist':
          {
            showLunaSuccessSnackBar(
              title: result[1] ? 'Removed (With Data)' : 'Removed',
              message: widget.data.title,
            );
            widget.refresh();
            break;
          }
        default:
          LunaLogger().warning('LidarrCatalogueTile', '_enterArtist',
              'Unknown Case: ${result[0]}');
      }
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
          LunaLogger().warning('LidarrCatalogueTile', '_handlePopup',
              'Invalid method passed through popup. (${values[1]})');
      }
  }

  Future<void> _enterEditArtist() async {
    final dynamic result = await Navigator.of(context).pushNamed(
      LidarrEditArtist.ROUTE_NAME,
      arguments: LidarrEditArtistArguments(entry: widget.data),
    );
    if (result != null && result[0])
      showLunaSuccessSnackBar(
        title: 'Updated',
        message: widget.data.title,
      );
  }

  Future<void> _refreshArtist() async {
    final _api = LidarrAPI.from(Database.currentProfileObject);
    await _api
        .refreshArtist(widget.data.artistID)
        .then((_) => showLunaSuccessSnackBar(
            title: 'Refreshing...', message: widget.data.title))
        .catchError((error) =>
            showLunaErrorSnackBar(title: 'Failed to Refresh', error: error));
  }

  Future<void> _removeArtist() async {
    final _api = LidarrAPI.from(Database.currentProfileObject);
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
          }).catchError((error) => showLunaErrorSnackBar(
                  title: 'Failed to Remove (With Data)', error: error));
        }
      } else {
        await _api
            .removeArtist(widget.data.artistID, deleteFiles: false)
            .then((_) {
          showLunaSuccessSnackBar(title: 'Removed', message: widget.data.title);
          widget.refresh();
        }).catchError((error) =>
                showLunaErrorSnackBar(title: 'Failed to Remove', error: error));
      }
    }
  }
}
