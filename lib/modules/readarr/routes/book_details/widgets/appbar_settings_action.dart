import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrAppBarBookSettingsAction extends StatelessWidget {
  final int bookId;

  const ReadarrAppBarBookSettingsAction({
    Key? key,
    required this.bookId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ReadarrState>(
      builder: (context, state, _) => FutureBuilder(
        future: state.books,
        builder: (context, AsyncSnapshot<Map<int, ReadarrBook>> snapshot) {
          if (snapshot.hasError) return Container();
          if (snapshot.hasData) {
            ReadarrBook? movie = snapshot.data![bookId];
            if (movie != null)
              return LunaIconButton(
                icon: Icons.more_vert_rounded,
                iconSize: LunaUI.ICON_SIZE,
                onPressed: () async {
                  Tuple2<bool, ReadarrBookSettingsType?> values =
                      await ReadarrDialogs().bookSettings(context, movie);
                  if (values.item1) values.item2!.execute(context, movie);
                },
              );
          }
          return Container();
        },
      ),
    );
  }
}
