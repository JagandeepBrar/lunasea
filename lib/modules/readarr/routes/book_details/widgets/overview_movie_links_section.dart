import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrBookDetailsOverviewLinksSection extends StatelessWidget {
  final ReadarrBook? movie;

  const ReadarrBookDetailsOverviewLinksSection({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaButtonContainer(
      buttonsPerRow: 1,
      children: [
        if (movie!.foreignBookId != null && movie!.foreignBookId!.isNotEmpty)
          LunaCard(
            context: context,
            child: InkWell(
              child: Padding(
                child: Image.asset(LunaAssets.serviceGoodreads),
                padding: const EdgeInsets.all(12.0),
              ),
              borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
              onTap: () async =>
                  await movie?.foreignBookId?.lunaOpenGoodreadsBook(),
            ),
            height: 50.0,
            margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
          ),
      ],
    );
  }
}
