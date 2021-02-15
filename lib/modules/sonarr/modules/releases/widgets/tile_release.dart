import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrReleasesReleaseTile extends StatefulWidget {
    final SonarrRelease release;
    final bool isSeasonRelease;

    SonarrReleasesReleaseTile({
        Key key,
        @required this.release,
        @required this.isSeasonRelease,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<SonarrReleasesReleaseTile> {
    final ExpandableController _controller = ExpandableController();
    LunaLoadingState _loadingState = LunaLoadingState.INACTIVE;

    @override
    Widget build(BuildContext context) => LSExpandable(
        controller: _controller,
        collapsed: _collapsed(context),
        expanded: _expanded(context),
    );

    Widget _collapsed(BuildContext context) => LSCardTile(
        title: LSTitle(text: widget.release.title),
        subtitle: RichText(
            text: TextSpan(
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                ),
                children: <TextSpan>[
                    TextSpan(
                        style: TextStyle(
                            color: widget.release.protocol == 'torrent'
                                ? LunaColours.purple
                                : LunaColours.blue,
                            fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                        ),
                        text: widget.release.protocol.lunaCapitalizeFirstLetters(),
                    ),
                    if(widget.release.protocol == 'torrent') TextSpan(
                        text: ' (${widget.release.seeders}/${widget.release.leechers})',
                        style: TextStyle(
                            color: LunaColours.purple,
                            fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                        ),
                    ),
                    TextSpan(text: '\t•\t${widget.release.indexer}\t•\t'),
                    TextSpan(text: '${widget.release?.ageHours?.lunaHoursToAge() ?? 'Unknown'}\n'),
                    TextSpan(text: '${widget.release?.quality?.quality?.name ?? 'Unknown'}\t•\t'),
                    TextSpan(text: '${widget.release?.size?.lunaBytesToString() ?? 'Unknown'}'),
                ]
            ),
        ),
        trailing: _loadingState == LunaLoadingState.ACTIVE
            ? IconButton(
                icon: SpinKitThreeBounce(
                    color: Colors.white,
                    size: 12.0,
                ),
                onPressed: null,
            )
            : LSIconButton(
                icon: widget.release.approved
                    ? Icons.file_download
                    : Icons.report,
                color: widget.release.approved
                    ? Colors.white
                    : LunaColours.red,
                onPressed: _loadingState == LunaLoadingState.ACTIVE ? null : () async => widget.release.approved ? _startDownload(context) : _showWarnings(context),
            ),
        padContent: true,
        onTap: () => _controller.toggle(),
    );

    Widget _expanded(BuildContext context) => LSCard(
        child: InkWell(
            child: Row(
                children: [
                    Expanded(
                        child: Padding(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    LSTitle(text: widget.release.title, softWrap: true, maxLines: 12),
                                    Padding(
                                        child: Wrap(
                                            direction: Axis.horizontal,
                                            runSpacing: 10.0,
                                            children: [
                                                LSTextHighlighted(
                                                    text: widget.release.protocol.lunaCapitalizeFirstLetters(),
                                                    bgColor: widget.release.protocol == 'torrent'
                                                        ? LunaColours.purple
                                                        : LunaColours.blue,
                                                ),
                                                LSTextHighlighted(
                                                    text: widget.release?.indexer ?? 'Unknown',
                                                    bgColor: LunaColours.blueGrey,
                                                ),
                                            ],
                                        ),
                                        padding: EdgeInsets.only(top: 8.0, bottom: 2.0),
                                    ),
                                    Padding(
                                        child: Column(
                                            children: [
                                                _tableContent('age', widget.release?.ageHours?.lunaHoursToAge() ?? 'Unknown'),
                                                _tableContent('quality', widget.release?.quality?.quality?.name ?? 'Unknown'),
                                                _tableContent('size', widget.release?.size?.lunaBytesToString() ?? 'Unknown'),
                                                if(widget.release.protocol == 'torrent') _tableContent(
                                                    'statistics',
                                                    [
                                                        '${widget.release?.seeders?.toString() ?? 'Unknown'} Seeder${(widget.release?.seeders ?? 0) != 1 ? 's' : ''}',
                                                        '${widget.release?.leechers?.toString() ?? 'Unknown'} Leecher${(widget.release?.leechers ?? 0) != 1 ? 's' : ''}',
                                                    ].join(' ${Constants.TEXT_BULLET} '),
                                                ),
                                            ],
                                        ),
                                        padding: EdgeInsets.only(top: 6.0, bottom: 10.0),
                                    ),
                                    Padding(
                                        child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                                Expanded(
                                                    child: LSButtonSlim(
                                                        text: 'Download',
                                                        widget: _loadingState == LunaLoadingState.ACTIVE
                                                            ? LSLoader(
                                                                color: Colors.white,
                                                                size: 17.0,
                                                            )
                                                            : null,
                                                        onTap: _loadingState == LunaLoadingState.ACTIVE ? null : () => _startDownload(context),
                                                        margin: widget.release.approved
                                                            ? EdgeInsets.zero
                                                            : EdgeInsets.only(right: 6.0),
                                                    ),
                                                ),
                                                if(!widget.release.approved) Expanded(
                                                    child: LSButtonSlim(
                                                        text: 'Rejected',
                                                        backgroundColor: LunaColours.red,
                                                        onTap: () => _showWarnings(context),
                                                        margin: EdgeInsets.only(left: 6.0),
                                                    ),
                                                ),
                                            ],
                                        ),
                                        padding: EdgeInsets.only(bottom: 2.0),
                                    ),
                                ],
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                        ),
                    )
                ],
            ),
            borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
            onTap: () => _controller.toggle(),
        ),
    );

    Widget _tableContent(String title, String body) => LSTableContent(
        title: title,
        body: body,
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 2.0),
    );

    Future<void> _startDownload(BuildContext context) async {
        if(mounted) setState(() => _loadingState = LunaLoadingState.ACTIVE);
        if(context.read<SonarrState>().api != null) await context.read<SonarrState>().api.release.addRelease(
            guid: widget.release.guid,
            indexerId: widget.release.indexerId,
            useVersion3: widget.isSeasonRelease,
        )
        .then((_) => LSSnackBar(
            context: context,
            title: 'Downloading Release...',
            message: widget.release.title,
            type: SNACKBAR_TYPE.success,
        ))
        .catchError((error, stack) {
            LunaLogger().error('Unable to download release: ${widget.release.guid}', error, stack);
            LSSnackBar(
                context: context,
                title: 'Failed to Download Release',
                type: SNACKBAR_TYPE.failure,
            );
        });
        if(mounted) setState(() => _loadingState = LunaLoadingState.INACTIVE);
    }

    Future<void> _showWarnings(BuildContext context) async {
        String rejections = '';
        for(var i=0; i<widget.release.rejections.length; i++) {
            rejections += '${i+1}. ${widget.release.rejections[i]}\n';
        }
        await LunaDialogs().textPreview(context, 'Rejection Reasons', rejections.trim());
    }
}