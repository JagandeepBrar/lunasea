import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrTagsTagTile extends StatefulWidget {
  final RadarrTag tag;

  const RadarrTagsTagTile({
    Key? key,
    required this.tag,
  }) : super(key: key);

  @override
  State<RadarrTagsTagTile> createState() => _State();
}

class _State extends State<RadarrTagsTagTile> with LunaLoadCallbackMixin {
  List<String?>? movieList;

  @override
  Future<void> loadCallback() async {
    await context.read<RadarrState>().movies!.then((movies) {
      List<String?> _movies = [];
      movies.forEach((element) {
        if (element.tags!.contains(widget.tag.id)) _movies.add(element.title);
      });
      _movies.sort();
      if (mounted) setState(() => movieList = _movies);
    }).catchError((error) {
      if (mounted) setState(() => movieList = null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: widget.tag.label,
      body: [TextSpan(text: _subtitle())],
      trailing: _trailing(),
      onTap: _movieDialog,
    );
  }

  String _subtitle() {
    if (movieList == null) return 'Loading...';
    if (movieList!.isEmpty) return 'No Movies';
    if (movieList!.length == 1) return '1 Movie';
    return '${movieList!.length} Movies';
  }

  Widget? _trailing() {
    // Default to true, to not try to delete a tag that actually does have movies attached
    if (movieList?.isNotEmpty ?? true) return null;
    return LunaIconButton(
      icon: LunaIcons.DELETE,
      color: LunaColours.red,
      onPressed: _delete,
    );
  }

  Future<void> _movieDialog() async {
    String data =
        (movieList?.isEmpty ?? true) ? 'No Movies' : movieList!.join('\n');
    LunaDialogs().textPreview(context, 'Movie List', data);
  }

  Future<void> _delete() async {
    if (movieList == null || movieList!.isNotEmpty) {
      showLunaErrorSnackBar(
        title: 'Cannot Delete Tag',
        message: 'The tag must not be attached to any movies',
      );
    } else {
      bool result = await RadarrDialogs().deleteTag(context);
      if (result)
        RadarrAPIHelper()
            .deleteTag(context: context, tag: widget.tag)
            .then((value) {
          if (value) context.read<RadarrState>().fetchTags();
        });
    }
  }
}
