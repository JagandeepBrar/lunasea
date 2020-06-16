import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrHistoryTile extends StatefulWidget {
    final RadarrHistoryData data;
    final GlobalKey<ScaffoldState> scaffoldKey;
    final Function refresh;

    RadarrHistoryTile({
        @required this.data,
        @required this.scaffoldKey,
        @required this.refresh,
    });

    @override
    State<RadarrHistoryTile> createState() => _State();
}

class _State extends State<RadarrHistoryTile> {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: widget.data.movieTitle),
        subtitle: RichText(
            text: TextSpan(
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                ),
                children: widget.data.subtitle,
            ),
        ),
        trailing: LSIconButton(
            icon: Icons.arrow_forward_ios,
        ),
        padContent: true,
        onTap: () async => _enterMovie(),
    );

    Future<void> _enterMovie() async {
        if(widget.data.movieID == null || widget.data.movieID == -1) {
            LSSnackBar(
                context: context,
                title: 'No Movie Available',
                message: 'There is no movie associated with this history entry',
            );
        } else {
            final dynamic result = await Navigator.of(context).pushNamed(
                RadarrDetailsMovie.ROUTE_NAME,
                arguments: RadarrDetailsMovieArguments(
                    data: null,
                    movieID: widget.data.movieID,
                ),
            );
            if(result != null) switch(result[0]) {
                case 'remove_movie': {
                    LSSnackBar(
                        context: context,
                        title: result[1] ? 'Removed (With Data)' : 'Removed',
                        message: widget.data.movieTitle,
                        type: SNACKBAR_TYPE.success,
                    );
                    widget.refresh();
                    break;
                }
            }
        }
    }
}