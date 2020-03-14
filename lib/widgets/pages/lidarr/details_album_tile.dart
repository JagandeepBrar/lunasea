import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/routes/lidarr/routes.dart';
import 'package:lunasea/widgets/ui.dart';

class LidarrDetailsAlbumTile extends StatefulWidget {
    final LidarrAlbumData data;
    final Function refreshState;

    LidarrDetailsAlbumTile({
        Key key,
        @required this.data,
        @required this.refreshState,
    }) : super(key: key);

    @override
    State<LidarrDetailsAlbumTile> createState() => _State();
}

class _State extends State<LidarrDetailsAlbumTile> {
    @override
    Widget build(BuildContext context) => LSCard(
        child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            child: Row(
                children: <Widget>[
                    widget.data.albumCoverURI() != null && widget.data.albumCoverURI() != '' ? (
                        ClipRRect(
                            child: Image(
                                image: AdvancedNetworkImage(
                                    widget.data.albumCoverURI(),
                                    useDiskCache: true,
                                    fallbackAssetImage: 'assets/images/noalbumart.png',
                                    loadFailedCallback: () {},
                                    retryLimit: 1,
                                ),
                                height: 70.0,
                                width: 70.0,
                                fit: BoxFit.cover,
                                color: widget.data.monitored ? null : LSColors.secondary.withAlpha((255/1.5).floor()),
                                colorBlendMode: widget.data.monitored ? null : BlendMode.darken,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        )
                    ) : (
                        Container()
                    ),
                    Expanded(
                        child: Padding(
                            child: Column(
                                children: <Widget>[
                                    Elements.getTitle(widget.data.title, darken: !widget.data.monitored),
                                    RichText(
                                        text: TextSpan(
                                            text: "${widget.data.tracks}",
                                            style: TextStyle(
                                                color: widget.data.monitored ? Colors.white70 : Colors.white30,
                                                fontSize: 14.0,
                                                letterSpacing: Constants.UI_LETTER_SPACING,
                                            ),
                                            children: <TextSpan> [
                                                TextSpan(
                                                    text: '\n${widget.data.releaseDateString}',
                                                    style: TextStyle(
                                                        color: widget.data.monitored ? LSColors.accent : LSColors.accent.withOpacity(0.30),
                                                        fontWeight: FontWeight.bold,
                                                    ),
                                                ),
                                            ],
                                        ),
                                    ),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                        ),
                    ),
                    Padding(
                        child: LSIconButton(
                            icon: widget.data.monitored ? 
                                Icons.turned_in :
                                Icons.turned_in_not,
                            color: widget.data.monitored ?
                                Colors.white :
                                Colors.white30,
                            onPressed: () => _toggleMonitoredStatus(),
                        ),
                        padding: EdgeInsets.fromLTRB(8.0, 0.0, 12.0, 0.0),
                    ),
                ],
            ),
            onTap: () => _enterAlbum(),
        ),
    );

    Future<void> _toggleMonitoredStatus() async {
        LidarrAPI _api = LidarrAPI.from(Database.currentProfileObject);
        if(await _api.toggleAlbumMonitored(widget.data.albumID, !widget.data.monitored)) {
            if(mounted) setState(() => widget.data.monitored = !widget.data.monitored);
            widget.refreshState();
            LSSnackBar(
                context: context,
                title: widget.data.monitored ? 'Monitoring' : 'No Longer Monitoring',
                message: widget.data.title,
                type: SNACKBAR_TYPE.success,
            );
        } else {
            LSSnackBar(
                context: context,
                title: widget.data.monitored ? 'Failed to Stop Monitoring' : 'Failed to Monitor',
                message: widget.data.title,
                type: SNACKBAR_TYPE.failure,
            );
        }
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
