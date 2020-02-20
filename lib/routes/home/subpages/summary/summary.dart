import 'package:flutter/material.dart';
import 'package:lunasea/core/api.dart';
import 'package:lunasea/core/database.dart';
import 'package:lunasea/routes/home/subpages/summary/sections.dart';
import 'package:lunasea/widgets/ui.dart';

class Summary extends StatefulWidget {
    final ProfileHiveObject profile = Database.getProfileObject();
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;

    Summary({
        Key key,
        @required this.refreshIndicatorKey,
    }) : super(key: key);

    @override
    State<Summary> createState() {
        return _State();
    }
}

class _State extends State<Summary> {
    List<String> _services = [];
    int _lidarrCount;
    int _radarrCount;
    int _sonarrCount;

    @override
    void initState() {
        super.initState();
        _services = widget.profile.enabledServices;
        Future.delayed(Duration(milliseconds: 200)).then((_) {
            if(mounted) {
                widget.refreshIndicatorKey?.currentState?.show();
            } 
        });
    }

    Future<void> _refreshData() async {
        _services = widget.profile.enabledServices;
        if(mounted) {
            setState(() {
                _lidarrCount = null;
                _radarrCount = null;
                _sonarrCount = null;
            });
        }
        _getLidarr();
        _getRadarr();
        _getSonarr();
    }

    Future<void> _getLidarr() async {
        if(_services.contains('lidarr')) {
            LidarrAPI _api = LidarrAPI.from(widget.profile);
            int value = await _api.getArtistCount();
            if(mounted) {
                setState(() {
                    _lidarrCount = value;
                });
            }
        }
    }

    Future<void> _getRadarr() async {
        if(_services.contains('radarr')) {
            RadarrAPI _api = RadarrAPI.from(widget.profile);
            int value = await _api.getMovieCount();
            if(mounted) {
                setState(() {
                    _radarrCount = value;
                });
            }
        }
    }

    Future<void> _getSonarr() async {
        if(_services.contains('sonarr')) {
            SonarrAPI _api = SonarrAPI.from(widget.profile);
            int value = await _api.getSeriesCount();
            if(mounted) {
                setState(() {
                    _sonarrCount = value;
                });
            }
        }
    }

    Widget _buildNoServices() {
        return LSGenericMessage(
            text: 'No Services Enabled',
            showButton: true,
            buttonText: 'Refresh',
            onTapHandler: () => widget.refreshIndicatorKey?.currentState?.show(),
        );
    }

    Widget _buildBody() {
        return RefreshIndicator(
            key: widget.refreshIndicatorKey,
            backgroundColor: LSColors.secondary,
            onRefresh: _refreshData,
            child: _services.length == 0 ? (
                _buildNoServices()
            ) : (
                LSListView(
                    children: <Widget>[
                        ...buildQuickAccess(context, _services),
                        ...buildSummary(context, _services, _sonarrCount, _radarrCount, _lidarrCount)
                    ],
                )
            ),
        );
    }

    @override
    Widget build(BuildContext context) {
        return _buildBody();
    }
}