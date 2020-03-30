import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import '../../radarr.dart';

class RadarrDetailsSearch extends StatefulWidget {
    final RadarrCatalogueData data;

    RadarrDetailsSearch({
        Key key,
        @required this.data,
    }) : super(key: key);

    @override
    State<RadarrDetailsSearch> createState() => _State();
}

class _State extends State<RadarrDetailsSearch> with AutomaticKeepAliveClientMixin {
    Future<List<RadarrReleaseData>> _future;
    List<RadarrReleaseData> _results = [];

    @override
    bool get wantKeepAlive => true;

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return _body;
    }

    Widget get _body => FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
            List _data;
            switch(snapshot.connectionState) {
                case ConnectionState.done: {
                    if(snapshot.hasError || snapshot.data == null) {
                        _data = _error;
                    } else {
                        _results = snapshot.data;
                        _data = _assembleResults;
                    }
                    break;
                }
                case ConnectionState.none: _data = []; break;
                case ConnectionState.waiting:
                case ConnectionState.active:
                default: _data = _loading; break;
            }
            return LSListView(
                children: <Widget>[
                    _buttons,
                    ..._data,
                ],
                padBottom: true,
            );
        },
    );

    List get _loading => [
        LSDivider(),
        LSTypewriterMessage(text: 'Searching...'),
    ];

    List get _error => [
        LSDivider(),
        LSErrorMessage(onTapHandler: () => _manual(), hideButton: true),
    ];

    Widget get _buttons => LSContainerRow(
        children: <Widget>[
            Expanded(
                child: LSButton(
                    text: 'Automatic',
                    onTap: () async => _automatic().catchError((_) {}),
                    reducedMargin: true,
                ),
            ),
            Expanded(
                child: LSButton(
                    text: 'Manual',
                    backgroundColor: LSColors.orange,
                    onTap: () async => _manual(),
                    reducedMargin: true,
                ),
            ),
        ],
    );

    Future<void> _manual() async {
        final _api = RadarrAPI.from(Database.currentProfileObject);
        setState(() {
            _future = _api.getReleases(widget.data.movieID);
        });
    }

    Future<void> _automatic() async {
        RadarrAPI _api = RadarrAPI.from(Database.currentProfileObject);
        _api.automaticSearchMovie(widget.data.movieID)
        .then((_) => LSSnackBar(
            context: context,
            title: 'Searching...',
            message: widget.data.title,
            type: SNACKBAR_TYPE.success,
        ))
        .catchError((_) => LSSnackBar(
            context: context,
            title: 'Failed to Search',
            message: Constants.CHECK_LOGS_MESSAGE,
            type: SNACKBAR_TYPE.failure,
        ));
    }

    List get _assembleResults => _results.length > 0
        ? [
            LSDivider(),
            ...List.generate(
                _results.length,
                (index) => RadarrDetailsSearchTile(data: _results[index]),
            ),
        ]
        : [
            LSDivider(),
            LSGenericMessage(text: 'No Results Found'),
        ];
}
