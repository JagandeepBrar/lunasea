import 'package:flutter/material.dart';
import 'package:lunasea/routes/sonarr/subpages/details/search.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';

class SelectableCard extends StatefulWidget {
    final SonarrAPI api = SonarrAPI.from(Database.currentProfileObject);
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
                            letterSpacing: Constants.UI_LETTER_SPACING,
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
                            if(await widget.api.searchEpisodes([widget.entry.episodeID])) {
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
                onLongPress: _handleLongPress,
            ),
            margin: Elements.getCardMargin(),
            elevation: 2.0,
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

    Future<void> _handleLongPress() async {
        List<dynamic> _values = await SonarrDialogs.showEpisodeEditingPrompt(context, widget.entry.episodeTitle, widget.entry.isMonitored, widget.entry.episodeFileID > 0);
        if(_values[0]) {
            switch(_values[1]) {
                case 'search_manual': {
                    await _enterSearch();
                    break;
                }
                case 'search_automatic': {
                    if(await widget.api.searchEpisodes([widget.entry.episodeID])) {
                        Notifications.showSnackBar(widget.scaffoldKey, 'Searching for ${widget.entry.episodeTitle}...');
                    } else {
                        Notifications.showSnackBar(widget.scaffoldKey, 'Failed to search for episode');
                    }
                    break;
                }
                case 'monitor_status': {
                    if(await widget.api.toggleEpisodeMonitored(widget.entry.episodeID, !widget.entry.isMonitored)) {
                        Notifications.showSnackBar(widget.scaffoldKey, widget.entry.isMonitored
                            ? 'No longer monitoring ${widget.entry.episodeTitle}...'
                            : 'Monitoring ${widget.entry.episodeTitle}...'
                        );
                        if(mounted) setState(() {
                            widget.entry.isMonitored = !widget.entry.isMonitored;
                        });
                    } else {
                        Notifications.showSnackBar(widget.scaffoldKey, widget.entry.isMonitored
                            ? 'Failed to stop monitoring ${widget.entry.episodeTitle}'
                            : 'Failed to start monitoring ${widget.entry.episodeTitle}'
                        );
                    }
                    break;
                }
                case 'delete_file': {
                    _values = await SonarrDialogs.showDeleteFilePrompt(context);
                    if(_values[0]) {
                        if(await widget.api.deleteEpisodeFile(widget.entry.episodeFileID)) {
                            if(mounted) setState(() {
                                widget.entry.hasFile = false;
                                widget.entry.isMonitored = false;
                                widget.entry.episodeFileID = 0;
                            });
                            Notifications.showSnackBar(widget.scaffoldKey, 'Deleting episode file...');
                        } else {
                            Notifications.showSnackBar(widget.scaffoldKey, 'Failed to delete episode file');
                        }
                    }
                    break;
                }
            }
        }
    }

    Future<void> _enterSearch() async {
        await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => SonarrEpisodeSearch(entry: widget.entry),
            ),
        );
    }
}