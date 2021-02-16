import 'package:flutter/material.dart';
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

class _State extends State<RadarrTagsTagTile> with LunaLoadCallbackMixin {
    List<String> movieList;

    Future<void> loadCallback() async {
        await context.read<RadarrState>().movies.then((movies) {
            List<String> _movies = [];
            movies.forEach((element) {
                if(element.tags.contains(widget.tag.id)) _movies.add(element.title);
            });
            _movies.sort();
            if(mounted) setState(() => movieList = _movies);
        })
        .catchError((_) {
            if(mounted) setState(() => movieList = null);
        });
    }

    @override
    Widget build(BuildContext context) {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: widget.tag.label),
            subtitle: LunaText.subtitle(text: _subtitle()),
            trailing: _trailing(),
            onTap: _movieDialog,
        );
    }

    String _subtitle() {
        if(movieList == null) return 'Loading...';
        if(movieList.length == 0) return 'No Movies';
        if(movieList.length == 1) return '1 Movie';
        return '${movieList.length} Movies';
    }

    Widget _trailing() {
        if(movieList == null || movieList.length != 0) return null;
        return LunaIconButton(
            icon: Icons.delete,
            color: LunaColours.red,
            onPressed: _delete,
        );
    }

    Future<void> _movieDialog() async {
        String data = movieList == null || movieList.length == 0 ? 'No Movies' : movieList.join('\n');
        LunaDialogs().textPreview(context, 'Movie List', data);
    }

    Future<void> _delete() async {
        if(movieList == null || movieList.length != 0) {
            showLunaErrorSnackBar(
                context: context,
                title: 'Cannot Delete Tag',
                message: 'The tag must not be attached to any movies',
            );
        } else {
            bool result = await RadarrDialogs().deleteTag(context);
            if(result) RadarrAPIHelper().deleteTag(context: context, tag: widget.tag)
            .then((value) {
                if(value) context.read<RadarrState>().fetchTags();
            });
        }
    }
}
