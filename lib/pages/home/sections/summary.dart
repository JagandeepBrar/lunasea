import 'package:flutter/material.dart';
import 'package:lunasea/system/ui.dart';

List buildSummary(BuildContext context, List<String> services, int sonarr, int radarr, int lidarr) {
    return [
        Elements.getHeader('Summary'),
        if(services.contains('lidarr')) _buildLidarr(context, lidarr),
        if(services.contains('radarr')) _buildRadarr(context, radarr),
        if(services.contains('sonarr')) _buildSonarr(context, sonarr),
    ];
}

Widget _buildLidarr(BuildContext context, int count) {
    return Card(
        child: ListTile(
            title: Elements.getTitle('Lidarr'),
            subtitle: Elements.getSubtitle('Artists in Lidarr'),
            trailing: count == null ? (
                Padding(
                    child: SizedBox(
                        child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                        ),
                        width: 20.0,
                        height: 20.0,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 14.0),
                )
            ) : (
                    Padding(
                        child: Text(
                            '$count',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                            ),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 14.0),
                    )
            ),
            onTap: () async {
                await Navigator.of(context).pushNamedAndRemoveUntil('/lidarr', (Route<dynamic> route) => false);
            },
        ),
        margin: Elements.getCardMargin(),
        elevation: 4.0,
    );
}

Widget _buildRadarr(BuildContext context, int count) {
    return Card(
        child: ListTile(
            title: Elements.getTitle('Radarr'),
            subtitle: Elements.getSubtitle('Movies in Radarr'),
            trailing: count == null ? (
                Padding(
                    child: SizedBox(
                        child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                        ),
                        width: 20.0,
                        height: 20.0,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 14.0),
                )
            ) : (
                Padding(
                    child: Text(
                        '$count',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                        ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 14.0),
                )
            ),
            onTap: () async {
                await Navigator.of(context).pushNamedAndRemoveUntil('/radarr', (Route<dynamic> route) => false);
            },
        ),
        margin: Elements.getCardMargin(),
        elevation: 4.0,
    );
}

Widget _buildSonarr(BuildContext context, int count) {
    return Card(
        child: ListTile(
            title: Elements.getTitle('Sonarr'),
            subtitle: Elements.getSubtitle('Series in Sonarr'),
            trailing: count == null ? (
                Padding(
                    child: SizedBox(
                        child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                        ),
                        width: 20.0,
                        height: 20.0,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 14.0),
                )
            ) : (
                Padding(
                    child: Text(
                        '$count',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                        ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 14.0),
                )
            ),
            onTap: () async {
                await Navigator.of(context).pushNamedAndRemoveUntil('/sonarr', (Route<dynamic> route) => false);
            },
        ),
        margin: Elements.getCardMargin(),
        elevation: 4.0,
    );
}
