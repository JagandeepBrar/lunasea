import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrBookDetailsOverviewInformationBlock extends StatelessWidget {
  final ReadarrBook? book;

  const ReadarrBookDetailsOverviewInformationBlock({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaTableCard(
      content: [
        LunaTableContent(
          title: 'monitoring',
          body: (book?.monitored ?? false) ? 'Yes' : 'No',
        ),
        LunaTableContent(title: 'added on', body: book?.lunaReleaseDate()),
        LunaTableContent(title: '', body: ''),
        LunaTableContent(title: 'genres', body: book?.lunaGenres),
      ],
    );
  }
}
