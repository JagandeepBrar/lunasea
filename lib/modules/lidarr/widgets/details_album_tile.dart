import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';
import 'package:lunasea/router/routes/lidarr.dart';

class LidarrDetailsAlbumTile extends StatefulWidget {
  final LidarrAlbumData data;
  final int artistId;
  final Function refreshState;

  const LidarrDetailsAlbumTile({
    Key? key,
    required this.data,
    required this.artistId,
    required this.refreshState,
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
      posterHeaders: LunaProfile.current.lidarrHeaders,
      posterPlaceholderIcon: LunaIcons.MUSIC,
      posterIsSquare: true,
      posterUrl: widget.data.albumCoverURI(),
      body: [
        TextSpan(text: widget.data.tracks),
        TextSpan(
          text: widget.data.releaseDateString,
          style: const TextStyle(
            color: LunaColours.accent,
            fontWeight: LunaUI.FONT_WEIGHT_BOLD,
          ),
        ),
      ],
      trailing: LunaIconButton(
        icon: widget.data.monitored
            ? Icons.turned_in_rounded
            : Icons.turned_in_not_rounded,
        onPressed: _toggleMonitoredStatus,
      ),
      onTap: _enterAlbum,
    );
  }

  Future<void> _toggleMonitoredStatus() async {
    LidarrAPI _api = LidarrAPI.from(LunaProfile.current);
    await _api
        .toggleAlbumMonitored(widget.data.albumID, !widget.data.monitored)
        .then((_) {
      if (mounted)
        setState(() => widget.data.monitored = !widget.data.monitored);
      widget.refreshState();
      showLunaSuccessSnackBar(
          title: widget.data.monitored ? 'Monitoring' : 'No Longer Monitoring',
          message: widget.data.title);
    }).catchError((error) {
      showLunaErrorSnackBar(
        title: widget.data.monitored
            ? 'Failed to Stop Monitoring'
            : 'Failed to Monitor',
        error: error,
      );
    });
  }

  Future<void> _enterAlbum() async {
    LidarrRoutes.ARTIST_ALBUM.go(params: {
      'album': widget.data.albumID.toString(),
      'artist': widget.artistId.toString(),
    }, queryParams: {
      'monitored': widget.data.monitored.toString(),
    });
  }
}
