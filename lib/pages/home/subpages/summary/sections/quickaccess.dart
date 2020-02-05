import 'package:flutter/material.dart';
import 'package:lunasea/system/constants.dart';
import 'package:lunasea/system/ui.dart';

List buildQuickAccess(BuildContext context, List<String> services) {
    List serviceList = [
        if(services.contains('lidarr')) Expanded(
            child: Card(
                child: InkWell(
                    child: Padding(
                        child: Elements.getIcon(Icons.music_note, color: Colors.blue),
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    onTap: () async {
                        await Navigator.of(context).pushNamedAndRemoveUntil('/lidarr', (Route<dynamic> route) => false);
                    },
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                margin: EdgeInsets.all(6.0),
                elevation: 4.0,
            ),
        ),
        if(services.contains('radarr')) Expanded(
            child: Card(
                child: InkWell(
                    child: Padding(
                        child: Elements.getIcon(Icons.movie, color: Color(Constants.ACCENT_COLOR)),
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    onTap: () async {
                        await Navigator.of(context).pushNamedAndRemoveUntil('/radarr', (Route<dynamic> route) => false);
                    },
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                margin: EdgeInsets.all(6.0),
                elevation: 4.0,
            ),
        ),
        if(services.contains('sonarr')) Expanded(
            child: Card(
                child: InkWell(
                    child: Padding(
                        child: Elements.getIcon(Icons.live_tv, color: Colors.orange),
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    onTap: () async {
                        await Navigator.of(context).pushNamedAndRemoveUntil('/sonarr', (Route<dynamic> route) => false);
                    },
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                margin: EdgeInsets.all(6.0),
                elevation: 4.0,
            ),
        ),
        if(services.contains('sabnzbd')) Expanded(
            child: Card(
                child: InkWell(
                    child: Padding(
                        child: Elements.getIcon(CustomIcons.sabnzbd, color: Colors.deepPurpleAccent),
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    onTap: () async {
                        await Navigator.of(context).pushNamedAndRemoveUntil('/sabnzbd', (Route<dynamic> route) => false);
                    },
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                margin: EdgeInsets.all(6.0),
                elevation: 4.0,
            ),
        ),
        if(services.contains('nzbget')) Expanded(
            child: Card(
                child: InkWell(
                    child: Padding(
                        child: Elements.getIcon(CustomIcons.nzbget, color: Colors.blueGrey),
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    onTap: () async {
                        await Navigator.of(context).pushNamedAndRemoveUntil('/nzbget', (Route<dynamic> route) => false);
                    },
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                margin: EdgeInsets.all(6.0),
                elevation: 4.0,
            ),
        ),
        Expanded(
            child: Card(
                child: InkWell(
                    child: Padding(
                        child: Elements.getIcon(Icons.settings, color: Colors.red),
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    onTap: () async {
                        await Navigator.of(context).pushNamed('/settings');
                    },
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                margin: EdgeInsets.all(6.0),
                elevation: 4.0,
            ),
        ),
    ];
    List<Padding> chunkedList = [Elements.getHeader('Quick Access')];
    List<Padding> chunks = chunkifyServices(serviceList, chunkSize: serviceList.length <= 4 ? 4 : (serviceList.length/2).ceil());
    chunkedList.addAll(chunks);
    return chunkedList;
}

List<Padding> chunkifyServices(List list, {int chunkSize = 5}) {
    List<Padding> chunks = [];
    int length = list.length;
    for(var i=0; i < length; i += chunkSize) {
        int size = i+chunkSize;
        chunks.add(Padding(
            child: Row(
                children: <Widget>[
                    ...list.sublist(i, size > length ? length : size),
                ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 6.0),
        ));
    }
    return chunks;
}