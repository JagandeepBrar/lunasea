import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrDetailsAlbumTile extends StatefulWidget {
  final LidarrAlbumData data;
  final Function refreshState;

  const LidarrDetailsAlbumTile({
    Key key,
    @required this.data,
    @required this.refreshState,
  }) : super(key: key);

  @override
  State<LidarrDetailsAlbumTile> createState() => _State();
}

class _State extends State<LidarrDetailsAlbumTile> {
  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: widget.data.title,
      disabled: !widget.data.monitored,
      posterHeaders: Database.currentProfileObject.getLidarr()['headers'] ?? {},
      posterPlaceholderIcon: LunaIcons.MUSIC,
      posterIsSquare: true,
      posterUrl: widget.data.albumCoverURI(),
      body: [
        TextSpan(text: widget.data.tracks),
        TextSpan(
          text: widget.data.releaseDateString,
          style: TextStyle(
            color: LunaColours.accent.enabled(widget.data.monitored),
            fontWeight: LunaUI.FONT_WEIGHT_BOLD,
          ),
        ),
      ],
      trailing: LunaIconButton(
        icon: widget.data.monitored
            ? Icons.turned_in_rounded
            : Icons.turned_in_not_rounded,
        color: widget.data.monitored ? Colors.white : Colors.white30,
        onPressed: _toggleMonitoredStatus,
      ),
      onTap: _enterAlbum,
    );
  }

  Future<void> _toggleMonitoredStatus() async {
    LidarrAPI _api = LidarrAPI.from(Database.currentProfileObject);
    await _api
        .toggleAlbumMonitored(widget.data.albumID, !widget.data.monitored)
        .then((_) {
      if (mounted)
        setState(() => widget.data.monitored = !widget.data.monitored);
      widget.refreshState();
      showLunaSuccessSnackBar(
          title: widget.data.monitored ? 'Monitoring' : 'No Longer Monitoring',
          message: widget.data.title);
    }).catchError((error) => showLunaErrorSnackBar(
            title: widget.data.monitored
                ? 'Failed to Stop Monitoring'
                : 'Failed to Monitor',
            error: error));
  }

  Future<void> _enterAlbum() async => await Navigator.of(context).pushNamed(
        LidarrDetailsAlbum.ROUTE_NAME,
        arguments: LidarrDetailsAlbumArguments(
          albumID: widget.data.albumID,
          title: widget.data.title,
          monitored: widget.data.monitored,
        ),
      );
}
