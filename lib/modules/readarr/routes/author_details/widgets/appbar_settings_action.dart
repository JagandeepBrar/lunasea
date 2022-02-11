import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrAppBarSeriesSettingsAction extends StatelessWidget {
  final int authorId;

  const ReadarrAppBarSeriesSettingsAction({
    Key? key,
    required this.authorId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ReadarrState>(
      builder: (context, state, _) => FutureBuilder(
        future: state.authors,
        builder: (context, AsyncSnapshot<Map<int?, ReadarrAuthor>> snapshot) {
          if (snapshot.hasError) return Container();
          if (snapshot.hasData) {
            ReadarrAuthor? series = snapshot.data![authorId];
            if (series != null)
              return LunaIconButton(
                icon: Icons.more_vert_rounded,
                onPressed: () async {
                  Tuple2<bool, ReadarrAuthorSettingsType?> values =
                      await ReadarrDialogs().authorSettings(context, series);
                  if (values.item1) values.item2!.execute(context, series);
                },
              );
          }
          return Container();
        },
      ),
    );
  }
}
