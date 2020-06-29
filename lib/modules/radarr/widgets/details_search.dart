import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

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
    @override
    bool get wantKeepAlive => true;

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return _body;
    }

    Widget get _body => LSListView(
        children: <Widget>[
            _buttons,
            LSDivider(),
            RadarrDetailsFileTile(data: widget.data),
        ],
    );

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
                    text: 'Interactive',
                    backgroundColor: LSColors.orange,
                    onTap: () async => _manual(),
                    reducedMargin: true,
                ),
            ),
        ],
    );

    Future<void> _manual() async => Navigator.of(context).pushNamed(
        RadarrSearchResults.ROUTE_NAME,
        arguments: RadarrSearchResultsArguments(
            movieID: widget.data.movieID,
            title: widget.data.title,
        ),
    );

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
}
