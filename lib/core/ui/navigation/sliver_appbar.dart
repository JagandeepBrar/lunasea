import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:lunasea/core.dart';

class LSSliverAppBar extends StatelessWidget {
    final ScrollController _controller = ScrollController(initialScrollOffset: _EXPANDED_HEIGHT - 80.0);
    final String title;
    final String backgroundURI;
    final List<Widget> actions;
    final Widget body;

    LSSliverAppBar({
        @required this.title,
        @required this.backgroundURI,
        @required this.body,
        this.actions,
    });

    static const _EXPANDED_HEIGHT = 200.0;

    @override
    Widget build(BuildContext context) => NestedScrollView(
        controller: _controller,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverOverlapAbsorber(
                sliver: SliverSafeArea(
                    top: false,
                    bottom: false,
                    sliver: SliverAppBar(
                        expandedHeight: _EXPANDED_HEIGHT,
                        pinned: true,
                        elevation: Constants.UI_ELEVATION,
                        title: Text(
                            title,
                            overflow: TextOverflow.fade,
                            softWrap: false,
                            maxLines: 1,
                            style: TextStyle(
                                letterSpacing: Constants.UI_LETTER_SPACING,
                            ),
                        ),
                        centerTitle: false,
                        flexibleSpace: FlexibleSpaceBar(
                            collapseMode: CollapseMode.parallax,
                            background: TransitionToImage(
                                image: AdvancedNetworkImage(
                                    backgroundURI,
                                    useDiskCache: true,
                                    fallbackAssetImage: LunaSeaDatabaseValue.THEME_AMOLED.data
                                        ? 'assets/images/colors/black.png'
                                        : 'assets/images/colors/secondary.png',
                                    retryLimit: 1,
                                ),
                                fit: BoxFit.cover,
                                loadingWidget: Image.asset(
                                    LunaSeaDatabaseValue.THEME_AMOLED.data
                                        ? 'assets/images/colors/black.png'
                                        : 'assets/images/colors/secondary.png',
                                ),
                                color: LSColors.secondary.withAlpha((255/1.5).floor()),
                                blendMode: BlendMode.darken,
                            ),
                        ),
                        actions: actions,
                    ),
                ),
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
        ],
        body: body,
    );
}
