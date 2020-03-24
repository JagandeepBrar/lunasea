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
            onPressed: null,
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
        onTap: () => _handleSelected(),
        onLongPress: () => _handlePopup(),
        padContent: true,
    );

    void _handleSelected() {
        setState(() => widget.data.isSelected = !widget.data.isSelected);
        widget.selectedCallback(widget.data.isSelected, widget.data.episodeID);
    }

    Future<void> _automaticSearch() async {
        SonarrAPI _api = SonarrAPI.from(Database.currentProfileObject);
        return await _api.searchEpisodes([widget.data.episodeID])
        .then((_) => LSSnackBar(
            context: context,
            title: 'Searching...',
            message: widget.data.episodeTitle,
        ))
        .catchError((_) => LSSnackBar(
            context: context,
            title: 'Failed to Search',
            message: Constants.CHECK_LOGS_MESSAGE,
            type: SNACKBAR_TYPE.failure,
        ));
    }
    
    Future<void> _manualSearch() async => Navigator.of(context).pushNamed(
        SonarrSearchResults.ROUTE_NAME,
        arguments: SonarrSearchResultsArguments(
            episodeID: widget.data.episodeID,
            title: widget.data.episodeTitle,
        ),
    );

    Future<void> _deleteFile() async {
        List _values = await SonarrDialogs.showDeleteFilePrompt(context);
        if(_values[0]) {
            SonarrAPI _api = SonarrAPI.from(Database.currentProfileObject);
            await _api.deleteEpisodeFile(widget.data.episodeFileID)
            .then((_) {
                LSSnackBar(
                    context: context,
                    title: 'Deleted Episode File',
                    message: widget.data.episodeTitle,
                    type: SNACKBAR_TYPE.success,
                );
                if(mounted) setState(() {
                    widget.data.hasFile = false;
                    widget.data.isMonitored = false;
                    widget.data.episodeFileID = 0;
                });
            })
            .catchError((_) => LSSnackBar(
                context: context,
                title: 'Failed to Delete Episode File',
                message: Constants.CHECK_LOGS_MESSAGE,
                type: SNACKBAR_TYPE.failure,
            ));
        }
    }

    Future<void> _toggleMonitoredStatus() async {
        SonarrAPI _api = SonarrAPI.from(Database.currentProfileObject);
        await _api.toggleEpisodeMonitored(widget.data.episodeID, !widget.data.isMonitored)
        .then((_) {
            LSSnackBar(
                context: context,
                title: widget.data.isMonitored ? 'No Longer Monitoring' : 'Monitoring',
                message: widget.data.episodeTitle,
                type: SNACKBAR_TYPE.success,
            );
            if(mounted) setState(() {
                widget.data.isMonitored = !widget.data.isMonitored;
            });
        })
        .catchError((_) => LSSnackBar(
            context: context,
            title: widget.data.isMonitored ? 'Failed to Stop Monitoring' : 'Failed to Monitor',
            message: Constants.CHECK_LOGS_MESSAGE,
            type: SNACKBAR_TYPE.failure,
        ));
    }

    Future<void> _handlePopup() async {
        List _values = await SonarrDialogs.showEpisodeEditingPrompt(context, widget.data.episodeTitle, widget.data.isMonitored, widget.data.hasFile);
        if(_values[0]) switch(_values[1]) {
            case 'monitor_status': _toggleMonitoredStatus().catchError((_) {}); break;
            case 'search_automatic': await _automaticSearch().catchError((_) {}); break;
            case 'search_manual': await _manualSearch().catchError((_) {}); break;
            case 'delete_file': _deleteFile().catchError((_) {}); break;
            default: Logger.warning('SonarrEpisodeTile', '_handlePopup', 'Unkown Case: ${_values[1]}');
        }
    }
}
