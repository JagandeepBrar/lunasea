import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrTagsTagTile extends StatefulWidget {
    final SonarrTag tag;

    SonarrTagsTagTile({
        Key key,
        @required this.tag,
    }) : super(key: key);

    @override
    State<SonarrTagsTagTile> createState() => _State();
}

class _State extends State<SonarrTagsTagTile> {
    List<String> seriesList;

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) => _loadSeries());
    }

    Future<void> _loadSeries() async => await context.read<SonarrState>().series.then((series) {
        List<String> _series = [];
        series.forEach((element) {
            if(element.tags.contains(widget.tag.id)) _series.add(element.title);
        });
        _series.sort();
        if(mounted) setState(() {
            seriesList = _series;
        });
    })
    .catchError((_) {
        if(mounted) setState(() {
            seriesList = null;
        });
    });

    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: widget.tag.label),
        subtitle: LSSubtitle(text: subtitle),
        trailing: seriesList == null || seriesList.length != 0
            ? null
            : LSIconButton(
                icon: Icons.delete,
                color: LunaColours.red,
                onPressed: _handleDelete,
            ),
        onTap: _handleInfo,
    );

    String get subtitle {
        if(seriesList == null) return 'Loading...';
        if(seriesList.length == 0) return 'No Series';
        return '${seriesList.length} Series';
    }

    Future<void> _handleInfo() async => LunaDialogs().textPreview(
        context,
        'Series List',
        seriesList == null || seriesList.length == 0 ? 'No Series' : seriesList.join('\n'),
    );

    Future<void> _handleDelete() async {
        if(seriesList == null || seriesList.length != 0) {
            showLunaErrorSnackBar(
                context: context,
                title: 'Cannot Delete Tag',
                message: 'The tag must not be attached to any series',
            );
        } else {
            List _values = await SonarrDialogs.deleteTag(context);
            if(_values[0]) context.read<SonarrState>().api.tag.deleteTag(id: widget.tag.id)
            .then((_) {
                showLunaSuccessSnackBar(
                    context: context,
                    title: 'Deleted Tag',
                    message: widget.tag.label,
                );
                context.read<SonarrState>().resetTags();
            })
            .catchError((error, stack) {
                LunaLogger().error('Failed to delete tag: ${widget.tag.id}', error, stack);
                showLunaErrorSnackBar(
                    context: context,
                    title: 'Failed to Delete Tag',
                    error: error,
                );
            });
        }
    }
}