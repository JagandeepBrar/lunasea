import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:lunasea/routes/radarr/subpages/details/movie.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';

class Upcoming extends StatefulWidget {
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
    final RadarrAPI api = RadarrAPI.from(Database.currentProfileObject);

    Upcoming({
        Key key,
        @required this.refreshIndicatorKey,
    }) : super(key: key);

    @override
    State<Upcoming> createState() {
        return _State();
    }
}

class _State extends State<Upcoming> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    bool _loading = true;
    List<RadarrMissingEntry> _entries = [];

    @override
    void initState() {
        super.initState();
        Future.delayed(Duration(milliseconds: 200)).then((_) {
            if(mounted) {
                widget.refreshIndicatorKey?.currentState?.show();
            }
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            body: RefreshIndicator(
                key: widget.refreshIndicatorKey,
                backgroundColor: Color(Constants.SECONDARY_COLOR),
                onRefresh: _handleRefresh,
                child: _loading ?
                    LSLoading() :
                    _entries == null ?
                        Notifications.centeredMessage('Connection Error', showBtn: true, btnMessage: 'Refresh', onTapHandler: () {widget.refreshIndicatorKey?.currentState?.show();}) :
                        _entries.length == 0 ?
                            Notifications.centeredMessage('No Upcoming Movies', showBtn: true, btnMessage: 'Refresh', onTapHandler: () {widget.refreshIndicatorKey?.currentState?.show();}) :
                            _buildList(),
            ),
        );
    }

    Future<void> _handleRefresh() async {
        if(mounted) {
            setState(() {
                _loading = true;
            });
        }
        _entries = await widget.api.getUpcoming();
        if(mounted) {
            setState(() {
                _loading = false;
            });
        }
    }

    Widget _buildList() {
        return Scrollbar(
            child: ListView.builder(
                itemCount: _entries.length,
                itemBuilder: (context, index) {
                    return _buildEntry(_entries[index]);
                },
                padding: Elements.getListViewPadding(),
                physics: AlwaysScrollableScrollPhysics(),
            ),
        );
    }

    Widget _buildEntry(RadarrMissingEntry entry) {
        return Card(
            child: Container(
                child: ListTile(
                    title: Elements.getTitle(entry.title),
                    subtitle: RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: Colors.white70,
                                letterSpacing: Constants.UI_LETTER_SPACING,
                            ),
                            children: entry.subtitle,
                        ),
                    ),
                    trailing: IconButton(
                        icon: Elements.getIcon(Icons.search),
                        tooltip: 'Search',
                        onPressed: () async {
                            if(await widget.api.searchMissingMovies([entry.movieID])) {
                                Notifications.showSnackBar(_scaffoldKey, 'Searching for ${entry.title}...');
                            } else {
                                Notifications.showSnackBar(_scaffoldKey, 'Failed to search for ${entry.title}');
                            }
                        },
                    ),
                    contentPadding: Elements.getContentPadding(),
                    onTap: () async {
                        _enterMovie(entry);
                    },
                ),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AdvancedNetworkImage(
                            entry.posterURI(),
                            useDiskCache: true,
                            loadFailedCallback: () {},
                            fallbackAssetImage: 'assets/images/secondary_color.png',
                            retryLimit: 1,
                        ),
                        colorFilter: new ColorFilter.mode(Color(Constants.SECONDARY_COLOR).withOpacity(0.20), BlendMode.dstATop),
                        fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
            ),
            margin: Elements.getCardMargin(),
            elevation: 2.0,
        );
    }

    Future<void> _enterMovie(RadarrMissingEntry entry) async {
        final result = await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => RadarrMovieDetails(
                    entry: null,
                    movieID: entry.movieID,
                ),
            ),
        );
        //Handle the result
        switch(result) {
            case 'movie_deleted': {
                Notifications.showSnackBar(_scaffoldKey, 'Removed ${entry.title}');
                widget.refreshIndicatorKey?.currentState?.show();
                break;
            }
        }
    }
}