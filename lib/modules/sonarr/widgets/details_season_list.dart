import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrDetailsSeasonList extends StatefulWidget {
    final SonarrCatalogueData data;

    SonarrDetailsSeasonList({
        Key key,
        @required this.data,
    }) : super(key: key);

    @override
    State<SonarrDetailsSeasonList> createState() => _State();
}

class _State extends State<SonarrDetailsSeasonList> with AutomaticKeepAliveClientMixin {
    @override
    bool get wantKeepAlive => true;

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return widget.data.seasonData.length == 0
            ? _empty
            : _list;
    }

    Widget get _list => LSListViewBuilder(
        itemCount: widget.data.seasonData.length+1,
        itemBuilder: (context, index) => SonarrDetailsSeasonListTile(
            data: widget.data,
            index: index == 0 ? -1 : widget.data.seasonData.length-index,
        ),
    );

    Widget get _empty => LSListView(
        children: [LSGenericMessage(text: 'No Seasons Found')],
    );
}
