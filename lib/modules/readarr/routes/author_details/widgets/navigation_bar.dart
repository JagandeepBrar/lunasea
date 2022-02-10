import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrAuthorDetailsNavigationBar extends StatefulWidget {
  static const List<IconData> icons = [
    Icons.subject_rounded,
    Icons.menu_book_rounded,
    Icons.history_rounded,
  ];
  static final List<String> titles = [
    'readarr.Overview'.tr(),
    'readarr.Books'.tr(),
    'readarr.History'.tr(),
  ];
  static List<ScrollController> scrollControllers =
      List.generate(icons.length, (_) => ScrollController());
  final PageController? pageController;
  final ReadarrAuthor? author;

  const ReadarrAuthorDetailsNavigationBar({
    Key? key,
    required this.pageController,
    required this.author,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ReadarrAuthorDetailsNavigationBar> {
  LunaLoadingState _automaticLoadingState = LunaLoadingState.INACTIVE;

  @override
  Widget build(BuildContext context) {
    return LunaBottomNavigationBar(
      pageController: widget.pageController,
      scrollControllers: ReadarrAuthorDetailsNavigationBar.scrollControllers,
      icons: ReadarrAuthorDetailsNavigationBar.icons,
      titles: ReadarrAuthorDetailsNavigationBar.titles,
      topActions: [
        LunaButton(
          type: LunaButtonType.TEXT,
          text: 'Automatic',
          icon: Icons.search_rounded,
          onTap: _automatic,
          loadingState: _automaticLoadingState,
        ),
        LunaButton.text(
          text: 'Interactive',
          icon: Icons.person_rounded,
          onTap: _manual,
        ),
      ],
    );
  }

  Future<void> _automatic() async {
    setState(() => _automaticLoadingState = LunaLoadingState.ACTIVE);
    ReadarrAPIController()
        .authorSearch(context: context, author: widget.author!)
        .then((value) {
      if (mounted)
        setState(() {
          _automaticLoadingState =
              value ? LunaLoadingState.INACTIVE : LunaLoadingState.ERROR;
        });
    });
  }

  Future<void> _manual() async =>
      ReadarrReleasesRouter().navigateTo(context, authorId: widget.author!.id);
}
