import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrUpcomingTile extends StatefulWidget {
    final SonarrCalendar record;

    SonarrUpcomingTile({
        Key key,
        @required this.record,
    }) : super(key: key);

    @override
    State<SonarrUpcomingTile> createState() => _State();
}

class _State extends State<SonarrUpcomingTile> {
    @override
    Widget build(BuildContext context) {
        return Selector<SonarrState, Future<SonarrMissing>>(
            selector: (_, state) => state.missing,
            builder: (context, missing, _) => LunaFourLineCardWithPoster(
                backgroundUrl: context.read<SonarrState>().getBannerURL(widget.record.seriesId),
                posterUrl: context.read<SonarrState>().getPosterURL(widget.record.seriesId),
                posterHeaders: context.read<SonarrState>().headers,
                posterPlaceholder: 'assets/images/sonarr/noseriesposter.png',
                title: widget.record.series.title,
                subtitle1: _subtitle1(),
                subtitle2: _subtitle2(),
                subtitle3: _subtitle3(),
                darken: !widget.record.monitored,
                onTap: _onTap,
                onLongPress: _onLongPress,
                trailing: _trailing(),
            ),
        );
    }

    Widget _trailing() => LunaIconButton(
        text: widget.record.lunaAirTime,
        onPressed: _trailingOnPressed,
        onLongPress: _trailingOnLongPress, 
    );

    TextSpan _subtitle1() {
        return TextSpan(
            children: [
                TextSpan(text: widget.record.seasonNumber == 0 ? 'Specials ' : 'Season ${widget.record.seasonNumber} '),
                TextSpan(text: Constants.TEXT_EMDASH),
                TextSpan(text: ' Episode ${widget.record.episodeNumber}'),
            ],
        );
    }

    TextSpan _subtitle2() {
        return TextSpan(
            style: TextStyle(fontStyle: FontStyle.italic),
            children: [
                TextSpan(text: widget.record.title ?? 'Unknown Title'),
            ],
        );
    }

    TextSpan _subtitle3() {
        Color color = widget.record.hasFile ? LunaColours.accent : widget.record.lunaHasAired ? LunaColours.red : LunaColours.blue;
        return TextSpan(
            style: TextStyle(
                fontWeight: LunaUI().fontWeightBold,
                color: color,
            ),
            children: [
                if(!widget.record.hasFile) TextSpan(text: widget.record.lunaHasAired ? 'Missing' : 'Unaired'),
                if(widget.record.hasFile) TextSpan(text: 'Downloaded (${widget?.record?.episodeFile?.quality?.quality?.name ?? 'Unknown'})'),
            ],
        );
    }

    Future<void> _onTap() async => SonarrSeriesSeasonDetailsRouter.navigateTo(
        context,
        seriesId: widget.record.seriesId,
        seasonNumber: widget.record.seasonNumber,
    );

    Future<void> _onLongPress() async =>  SonarrSeriesDetailsRouter.navigateTo(
        context,
        seriesId: widget.record.seriesId,
    );

    Future<void> _trailingOnPressed() async {
        Provider.of<SonarrState>(context, listen: false).api.command.episodeSearch(episodeIds: [widget.record.id])
        .then((_) => LSSnackBar(
            context: context,
            title: 'Searching for Episode...',
            message: widget.record.title,
            type: SNACKBAR_TYPE.success,
        ))
        .catchError((error, stack) {
            LunaLogger().error('Failed to search for episode: ${widget.record.id}', error, stack);
            LSSnackBar(
                context: context,
                title: 'Failed to Search',
                type: SNACKBAR_TYPE.failure,
            );
        });
    }

    Future<void> _trailingOnLongPress() async => SonarrReleasesRouter.navigateTo(
        context,
        episodeId: widget.record.id,
    );
}
