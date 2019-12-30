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
        return _SelectableCardState(
            entry: entry,
            scaffoldKey: scaffoldKey,
            selected: selected,
            selectedCallback: selectedCallback,
        );
    }
}

class _SelectableCardState extends State<SelectableCard> {
    final SonarrEpisodeEntry entry;
    final GlobalKey<ScaffoldState> scaffoldKey;
    final List<SonarrEpisodeEntry> selected;
    final Function selectedCallback;

    _SelectableCardState({
        Key key,
        @required this.entry,
        @required this.scaffoldKey,
        @required this.selected,
        @required this.selectedCallback,
    });

    @override
    Widget build(BuildContext context) {
        return Card(
            child: ListTile(
                selected: entry.isSelected,
                title: Text(
                    entry.episodeTitle,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    maxLines: 1,
                    style: TextStyle(
                        color: entry.isMonitored ? Colors.white: Colors.white30,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                    ),
                ),
                subtitle: RichText(
                    text: TextSpan(
                        style: TextStyle(
                            color: entry.isMonitored ? Colors.white70 : Colors.white30,
                            letterSpacing: Constants.LETTER_SPACING,
                        ),
                        children: <TextSpan> [
                            TextSpan(
                                text: '${entry.airDateString}\n'
                            ),
                            entry.subtitle,
                        ],
                    ),
                ),
                contentPadding: Elements.getContentPadding(),
                leading: IconButton(
                    icon: entry.isSelected ?
                        Elements.getIcon(
                            Icons.check_circle,
                            color: entry.isMonitored ? Colors.white : Colors.white30,
                        ) :
                        Text(
                            '${entry.episodeNumber}',
                            style: TextStyle(
                                color: entry.isMonitored ? Colors.white : Colors.white30,
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
                            color: entry.isMonitored ? Colors.white : Colors.white30,
                        ),
                        onPressed: () async {
                            if(await SonarrAPI.searchEpisodes([entry.episodeID])) {
                                Notifications.showSnackBar(scaffoldKey, 'Searching for ${entry.episodeTitle}...');
                            } else {
                                Notifications.showSnackBar(scaffoldKey, 'Failed to search for episode');
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
        entry.isSelected = !entry.isSelected;
        if(entry.isSelected) {
            selected.add(this.entry);
        } else {
            selected.remove(this.entry);
        }
        selectedCallback();
    }

    Future<void> _enterSearch() async {
        await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => SonarrEpisodeSearch(entry: entry),
            ),
        );
    }
}