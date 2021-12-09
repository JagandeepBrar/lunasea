import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrHistoryTile extends StatefulWidget {
  final LidarrHistoryData entry;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function refresh;

  const LidarrHistoryTile({
    Key key,
    @required this.entry,
    @required this.scaffoldKey,
    @required this.refresh,
  }) : super(key: key);

  @override
  State<LidarrHistoryTile> createState() => _State();
}

class _State extends State<LidarrHistoryTile> {
  @override
  Widget build(BuildContext context) => LunaListTile(
        context: context,
        height: LunaListTile.heightFromSubtitleLines(2),
        title: LunaText.title(text: widget.entry.title),
        subtitle: RichText(
          text: TextSpan(
            style: const TextStyle(
              color: Colors.white70,
              fontSize: LunaUI.FONT_SIZE_H3,
            ),
            children: widget.entry.subtitle,
          ),
        ),
        trailing: LunaIconButton(
          icon: Icons.arrow_forward_ios_rounded,
        ),
        contentPadding: true,
        onTap: () async => _enterArtist(),
      );

  Future<void> _enterArtist() async {
    if (widget.entry.artistID == null || widget.entry.artistID == -1) {
      showLunaInfoSnackBar(
        title: 'No Artist Available',
        message: 'There is no artist associated with this history entry',
      );
    } else {
      final dynamic result = await Navigator.of(context).pushNamed(
        LidarrDetailsArtist.ROUTE_NAME,
        arguments: LidarrDetailsArtistArguments(
          data: null,
          artistID: widget.entry.artistID,
        ),
      );
      if (result != null)
        switch (result[0]) {
          case 'remove_artist':
            {
              showLunaSuccessSnackBar(
                title: result[1] ? 'Removed (With Data)' : 'Removed',
                message: 'Removed artist with ID ${widget.entry.artistID}',
              );
              widget.refresh();
              break;
            }
        }
    }
  }
}
