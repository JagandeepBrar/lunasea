import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrBookDetailsNavigationBar extends StatefulWidget {
  static const List<IconData> icons = [
    Icons.subject_rounded,
    Icons.insert_drive_file_outlined,
    Icons.history_rounded,
  ];
  static final List<String> titles = [
    'readarr.Overview'.tr(),
    'readarr.Files'.tr(),
    'readarr.History'.tr(),
  ];
  static List<ScrollController> scrollControllers =
      List.generate(icons.length, (_) => ScrollController());
  final PageController? pageController;
  final ReadarrBook? book;

  const ReadarrBookDetailsNavigationBar({
    Key? key,
    required this.pageController,
    required this.book,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ReadarrBookDetailsNavigationBar> {
  LunaLoadingState _automaticLoadingState = LunaLoadingState.INACTIVE;

  @override
  Widget build(BuildContext context) {
    return LunaBottomNavigationBar(
      pageController: widget.pageController,
      scrollControllers: ReadarrBookDetailsNavigationBar.scrollControllers,
      icons: ReadarrBookDetailsNavigationBar.icons,
      titles: ReadarrBookDetailsNavigationBar.titles,
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
        .bookSearch(context: context, book: widget.book!)
        .then((value) {
      if (mounted)
        setState(() {
          _automaticLoadingState =
              value ? LunaLoadingState.INACTIVE : LunaLoadingState.ERROR;
        });
    });
  }

  Future<void> _manual() async =>
      ReadarrReleasesRouter().navigateTo(context, bookId: widget.book!.id);
}
