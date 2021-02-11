import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrTagsTagTile extends StatefulWidget {
    final RadarrTag tag;

    RadarrTagsTagTile({
        Key key,
        @required this.tag,
    }) : super(key: key);

    @override
    State<RadarrTagsTagTile> createState() => _State();
}

class _State extends State<RadarrTagsTagTile> {
    List<String> movieList;

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) => _loadMovies());
    }

    Future<void> _loadMovies() async => await context.read<RadarrState>().movies.then((movies) {
        List<String> _movies = [];
        movies.forEach((element) {
            if(element.tags.contains(widget.tag.id)) _movies.add(element.title);
        });
        _movies.sort();
        if(mounted) setState(() {
            movieList = _movies;
        });
    })
    .catchError((_) {
        if(mounted) setState(() {
            movieList = null;
        });
    });

    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LunaText.title(text: widget.tag.label),
        subtitle: LSSubtitle(text: subtitle),
        trailing: movieList == null || movieList.length != 0
            ? null
            : LSIconButton(
                icon: Icons.delete,
                color: LunaColours.red,
                onPressed: _handleDelete,
            ),
        onTap: _handleInfo,
    );

    String get subtitle {
        if(movieList == null) return 'Loading...';
        if(movieList.length == 0) return 'No Movies';
        if(movieList.length == 1) return '1 Movie';
        return '${movieList.length} Movies';
    }

    Future<void> _handleInfo() async => LunaDialogs().textPreview(
        context,
        'Movie List',
        movieList == null || movieList.length == 0 ? 'No Movies' : movieList.join('\n'),
    );

    Future<void> _handleDelete() async {
        if(movieList == null || movieList.length != 0) {
            showLunaErrorSnackBar(
                context: context,
                title: 'Cannot Delete Tag',
                message: 'The tag must not be attached to any movies',
            );
        } else {
            List _values = await RadarrDialogs().deleteTag(context);
            if(_values[0]) context.read<RadarrState>().api.tag.delete(id: widget.tag.id)
            .then((_) {
                showLunaSuccessSnackBar(
                    context: context,
                    title: 'Deleted Tag',
                    message: widget.tag.label,
                );
                context.read<RadarrState>().fetchTags();
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