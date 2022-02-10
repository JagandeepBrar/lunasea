import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrAuthorDetailsOverviewLinksSection extends StatelessWidget {
  final ReadarrAuthor series;

  const ReadarrAuthorDetailsOverviewLinksSection({
    Key? key,
    required this.series,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaButtonContainer(
      buttonsPerRow: 1,
      children: [
        if (series.foreignAuthorId != null &&
            series.foreignAuthorId!.isNotEmpty)
          LunaCard(
            context: context,
            child: InkWell(
              child: Padding(
                child: Image.asset(LunaAssets.serviceGoodreads),
                padding: const EdgeInsets.all(12.0),
              ),
              borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
              onTap: () async =>
                  await series.foreignAuthorId!.lunaOpenGoodreadsAuthor(),
            ),
            height: 50.0,
            margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
          ),
      ],
    );
  }
}
