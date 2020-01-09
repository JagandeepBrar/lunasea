import 'package:flutter/material.dart';
import 'package:lunasea/logic/automation/sonarr.dart';
import 'package:lunasea/pages/sonarr/subpages/details/search.dart';
import 'package:lunasea/system/constants.dart';
import 'package:lunasea/system/ui.dart';

class SelectableCard extends StatefulWidget {
    final SonarrEpisodeEntry entry;
    final GlobalKey<ScaffoldState> scaffoldKey;
    final List<SonarrEpisodeEntry> selected;
    final Function selectedCallback;

    SelectableCard({
        Key key,
        @required this.entry,
        @required this.scaffoldKey,
        @required this.selected,
        @required this.selectedCallback,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() {
        return _State();
    }
}

class _State extends State<SelectableCard> {
    @override
    Widget build(BuildContext context) {
        return Card(
            child: ListTile(
                selected: widget.entry.isSelected,
                title: Text(
                    widget.entry.episodeTitle,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    maxLines: 1,
                    style: TextStyle(
                        color: widget.entry.isMonitored ? Colors.white: Colors.white30,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                    ),
                ),
                subtitle: RichText(
                    text: TextSpan(
                        style: TextStyle(
                            color: widget.entry.isMonitored ? Colors.white70 : Colors.white30,
                            letterSpacing: Constants.LETTER_SPACING,
                        ),
                        children: <TextSpan> [
                            TextSpan(
                                text: '${widget.entry.airDateString}\n'
                            ),
                            widget.entry.subtitle,
                        ],
                    ),
                ),
                contentPadding: Elements.getContentPadding(),
                leading: IconButton(
                    icon: widget.entry.isSelected ?
                        Elements.getIcon(
                            Icons.check_circle,
                            color: widget.entry.isMonitored ? Colors.white : Colors.white30,
                        ) :
                        Text(
                            '${widget.entry.episodeNumber}',
                            style: TextStyle(
                                color: widget.entry.isMonitored ? Colors.white : Colors.white30,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                            ),
                        ),
                    tooltip: 'Select Episode',
                    onPressed: toggleSelection,
                ),
                trailing: InkWell(
                    child: IconButton(
                        icon: Elements.getIcon(
                            Icons.search,
                            color: widget.entry.isMonitored ? Colors.white : Colors.white30,
                        ),
                        onPressed: () async {
                            if(await SonarrAPI.searchEpisodes([widget.entry.episodeID])) {
                                Notifications.showSnackBar(widget.scaffoldKey, 'Searching for ${widget.entry.episodeTitle}...');
                            } else {
                                Notifications.showSnackBar(widget.scaffoldKey, 'Failed to search for episode');
                            }
                        },
                    ),
                    onLongPress: () async {
                        await _enterSearch();
                    },
                ),
            ),
            margin: Elements.getCardMargin(),
            elevation: 4.0,
        );
    }

    void toggleSelection() {
        widget.entry.isSelected = !widget.entry.isSelected;
        if(widget.entry.isSelected) {
            widget.selected.add(this.widget.entry);
        } else {
            widget.selected.remove(this.widget.entry);
        }
        widget.selectedCallback();
    }

    Future<void> _enterSearch() async {
        await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => SonarrEpisodeSearch(entry: widget.entry),
            ),
        );
    }
}