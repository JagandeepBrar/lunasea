import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:lunasea/core.dart';

class LSSliverAppBar extends StatelessWidget {
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

    @override
    Widget build(BuildContext context) => NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverOverlapAbsorber(
                sliver: SliverSafeArea(
                    top: false,
                    bottom: false,
                    sliver: SliverAppBar(
                        expandedHeight: 200.0,
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
                        centerTitle: true,
                        flexibleSpace: FlexibleSpaceBar(
                            collapseMode: CollapseMode.parallax,
                            background: TransitionToImage(
                                image: AdvancedNetworkImage(
                                    backgroundURI,
                                    useDiskCache: true,
                                    fallbackAssetImage: 'assets/images/secondary_color.png',
                                    retryLimit: 1,
                                ),
                                fit: BoxFit.cover,
                                loadingWidget: Image.asset(
                                    'assets/images/secondary_color.png',
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
