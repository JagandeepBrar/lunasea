import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/system.dart';
import 'package:lunasea/routes/home/subpages/summary/sections.dart';
import 'package:lunasea/widgets/ui.dart';

class Summary extends StatefulWidget {
    @override
    State<Summary> createState() {
        return _State();
    }
}

class _State extends State<Summary> {
    final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
    List<String> _services = [];
    int _lidarrCount;
    int _radarrCount;
    int _sonarrCount;

    @override
    void initState() {
        super.initState();
        _services = Values.getEnabledServices();
        Future.delayed(Duration(milliseconds: 200)).then((_) {
            if(mounted) {
                _refreshIndicatorKey?.currentState?.show();
            } 
        });
    }

    Future<void> _refreshData() async {
        _services = Values.getEnabledServices();
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
            int value = await LidarrAPI.getArtistCount();
            if(mounted) {
                setState(() {
                    _lidarrCount = value;
                });
            }
        }
    }

    Future<void> _getRadarr() async {
        if(_services.contains('radarr')) {
            int value = await RadarrAPI.getMovieCount();
            if(mounted) {
                setState(() {
                    _radarrCount = value;
                });
            }
        }
    }

    Future<void> _getSonarr() async {
        if(_services.contains('sonarr')) {
            int value = await SonarrAPI.getSeriesCount();
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
            onTapHandler: () => _refreshIndicatorKey?.currentState?.show(),
        );
    }

    Widget _buildBody() {
        return RefreshIndicator(
            key: _refreshIndicatorKey,
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