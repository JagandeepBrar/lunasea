import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';
import 'package:lunasea/modules/lidarr/sheets/links.dart';

class LidarrDetailsArtistArguments {
  LidarrCatalogueData? data;
  final int? artistID;

  LidarrDetailsArtistArguments({
    required this.data,
    required this.artistID,
  });
}

class LidarrDetailsArtist extends StatefulWidget {
  static const ROUTE_NAME = '/lidarr/details/artist';

  const LidarrDetailsArtist({
    Key? key,
  }) : super(key: key);

  @override
  State<LidarrDetailsArtist> createState() => _State();
}

class _State extends State<LidarrDetailsArtist> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final LunaPageController _pageController = LunaPageController(initialPage: 1);
  LidarrDetailsArtistArguments? _arguments;
  bool _error = false;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _arguments = ModalRoute.of(context)!.settings.arguments
          as LidarrDetailsArtistArguments?;
      _fetch();
    });
  }

  Future<void> _fetch() async {
    if (mounted) setState(() => _error = false);
    if (_arguments != null)
      await LidarrAPI.from(LunaProfile.current)
          .getArtist(_arguments!.artistID)
          .then((data) {
        if (mounted)
          setState(() {
            _arguments!.data = data;
            _error = false;
          });
      }).catchError((error) {
        if (mounted) setState(() => _error = true);
      });
  }

  @override
  Widget build(BuildContext context) => LunaScaffold(
        scaffoldKey: _scaffoldKey,
        appBar: _appBar as PreferredSizeWidget?,
        bottomNavigationBar: _arguments != null && _arguments!.data != null
            ? _bottomNavigationBar
            : null,
        body: _arguments != null
            ? _arguments!.data != null
                ? _body
                : _error
                    ? LunaMessage.error(onTap: _fetch)
                    : const LunaLoader()
            : null,
      );

  Widget get _appBar {
    List<Widget>? _actions;

    if (_arguments?.data != null) {
      _actions = [
        LunaIconButton(
          icon: LunaIcons.LINK,
          onPressed: () async {
            LinksSheet(artist: _arguments!.data!).show();
          },
        ),
        LidarrDetailsEditButton(data: _arguments!.data),
        LidarrDetailsSettingsButton(
          data: _arguments!.data,
          remove: _removeCallback,
        ),
      ];
    }
    return LunaAppBar(
      title: 'Artist Details',
      pageController: _pageController,
      scrollControllers: LidarrArtistNavigationBar.scrollControllers,
      actions: _actions,
    );
  }

  Widget get _bottomNavigationBar =>
      LidarrArtistNavigationBar(pageController: _pageController);

  List<Widget> get _tabs => [
        LidarrDetailsOverview(data: _arguments!.data!),
        LidarrDetailsAlbumList(artistID: _arguments!.data!.artistID),
      ];

  Widget get _body => LunaPageView(
        controller: _pageController,
        children: _tabs,
      );

  Future<void> _removeCallback(bool withData) async =>
      Navigator.of(context).pop(['remove_artist', withData]);
}
