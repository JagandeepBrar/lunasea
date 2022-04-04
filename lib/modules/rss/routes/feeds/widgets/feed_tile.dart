import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/mixins/load_callback.dart';
import '../../../../../core/models/configuration/feed.dart';
import '../../../../../core/models/types/loading_state.dart';
import '../../../../../core/ui.dart';
import '../../../../../core/utilities/logger.dart';
import '../../../core/state.dart';
import '../../results/route.dart';

class RssFeedTile extends StatefulWidget {
  final FeedHiveObject? feed;

  const RssFeedTile({
    Key? key,
    required this.feed,
  }) : super(key: key);

  @override
  State<RssFeedTile> createState() => _State();
}

class _State extends State<RssFeedTile> with LunaLoadCallbackMixin {
  LunaLoadingState _loadingState = LunaLoadingState.ACTIVE;
  dynamic _loadingError = null;

  @override
  Future<void> loadCallback() async {
    context
        .read<RssState>()
        .fetchFeed(widget.feed!)!
        .then((result) =>
    {
      if (this.mounted) setState(() =>
      {
        _loadingState = LunaLoadingState.INACTIVE,
        _loadingError = null
      })
    }).catchError((error, stack) {
      LunaLogger()
          .error('Unable to open link: ${widget.feed!.url}', error, stack);
      if (this.mounted) setState(() =>
      {
        _loadingState = LunaLoadingState.ERROR,
        _loadingError = error
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: widget.feed!.displayName,
      body: [TextSpan(text: widget.feed!.url)],
      trailing: _trailing(),
      onTap: () async {
        if (_loadingState == LunaLoadingState.ERROR) {
          showLunaErrorSnackBar(title: "rss.ErrorFetching".tr(), error: _loadingError);
        }
        if (_loadingState == LunaLoadingState.INACTIVE) {
          context.read<RssState>().feed = widget.feed!;
          RssResultRouter().navigateTo(context);
        }
      },
    );
  }

  Widget _trailing() {
    return LunaIconButton.arrow(
      loadingState: _loadingState,
    );
  }
}
