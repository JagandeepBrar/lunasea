import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import '../../sonarr.dart';

class SonarrEpisodeTile extends StatefulWidget {
    final SonarrEpisodeData data;
    final Function(bool, int) selectedCallback;


    SonarrEpisodeTile({
        @required this.data,
        @required this.selectedCallback,
    });

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<SonarrEpisodeTile> {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(
            text: widget.data.episodeTitle,
            darken: !widget.data.isMonitored,
        ),
        subtitle: RichText(
            text: TextSpan(
                children: [
                    TextSpan(
                        text: '${widget.data.airDateString}\n',
                        style: TextStyle(
                            color: widget.data.isMonitored
                                ? Colors.white70
                                : Colors.white30,
                        ),
                    ),
                    widget.data.subtitle
                ],
            ),
        ),
        leading: IconButton(
            icon: widget.data.isSelected
                ? LSIcon(icon: Icons.check)
                : Text(
                    '${widget.data.episodeNumber}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: widget.data.isMonitored ? Colors.white : Colors.white30,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                    ),
                ),
            onPressed: () => _handleSelected(),
        ),
        decoration: widget.data.isSelected
            ? BoxDecoration(
                color: LSColors.accent.withOpacity(0.30),
                borderRadius: BorderRadius.circular(4.0)
            )
            : null,
        trailing: InkWell(
            child: LSIconButton(
                icon: Icons.search,
                color: widget.data.isMonitored
                    ? Colors.white
                    : Colors.white30,
                onPressed: () async => _automaticSearch(),
            ),
            onLongPress: () async => _manualSearch(),
        ),
        padContent: true,
    );

    void _handleSelected() {
        setState(() => widget.data.isSelected = !widget.data.isSelected);
        widget.selectedCallback(widget.data.isSelected, widget.data.episodeID);
    }

    Future<void> _automaticSearch() async {}
    Future<void> _manualSearch() async {}
}
