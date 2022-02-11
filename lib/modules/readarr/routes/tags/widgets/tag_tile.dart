import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrTagsTagTile extends StatefulWidget {
  final ReadarrTag tag;

  const ReadarrTagsTagTile({
    Key? key,
    required this.tag,
  }) : super(key: key);

  @override
  State<ReadarrTagsTagTile> createState() => _State();
}

class _State extends State<ReadarrTagsTagTile> with LunaLoadCallbackMixin {
  List<String?>? seriesList;

  @override
  Future<void> loadCallback() async {
    await context.read<ReadarrState>().authors!.then((series) {
      List<String?> _series = [];
      series.values.forEach((element) {
        if (element.tags!.contains(widget.tag.id)) _series.add(element.title);
      });
      _series.sort();
      if (mounted)
        setState(() {
          seriesList = _series;
        });
    }).catchError((error) {
      if (mounted)
        setState(() {
          seriesList = null;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: widget.tag.label,
      body: [TextSpan(text: subtitle())],
      trailing: (seriesList?.isNotEmpty ?? true)
          ? null
          : LunaIconButton(
              icon: LunaIcons.DELETE,
              color: LunaColours.red,
              onPressed: _handleDelete,
            ),
      onTap: _handleInfo,
    );
  }

  String subtitle() {
    if (seriesList == null) return 'Loading...';
    if (seriesList!.isEmpty) return 'No Series';
    return '${seriesList!.length} Series';
  }

  Future<void> _handleInfo() async {
    return LunaDialogs().textPreview(
      context,
      'Series List',
      (seriesList?.isEmpty ?? true) ? 'No Series' : seriesList!.join('\n'),
    );
  }

  Future<void> _handleDelete() async {
    if (seriesList?.isNotEmpty ?? true) {
      showLunaErrorSnackBar(
        title: 'Cannot Delete Tag',
        message: 'The tag must not be attached to any series',
      );
    } else {
      bool result = await ReadarrDialogs().deleteTag(context);
      if (result)
        context
            .read<ReadarrState>()
            .api!
            .tag
            .delete(id: widget.tag.id!)
            .then((_) {
          showLunaSuccessSnackBar(
            title: 'Deleted Tag',
            message: widget.tag.label,
          );
          context.read<ReadarrState>().fetchTags();
        }).catchError((error, stack) {
          LunaLogger().error(
            'Failed to delete tag: ${widget.tag.id}',
            error,
            stack,
          );
          showLunaErrorSnackBar(
            title: 'Failed to Delete Tag',
            error: error,
          );
        });
    }
  }
}
