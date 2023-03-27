import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/database/models/rss.dart';
import 'package:lunasea/extensions/datetime.dart';
import 'package:lunasea/modules/rss/core/state.dart';
import 'package:lunasea/router/routes/rss.dart';

class RssFeedTile extends StatefulWidget {
  final LunaRss? feed;

  const RssFeedTile({
    Key? key,
    required this.feed,
  }) : super(key: key);

  @override
  State<RssFeedTile> createState() => _State();
}

class _State extends State<RssFeedTile> with LunaLoadCallbackMixin {
  LunaLoadingState _loadingState = LunaLoadingState.ACTIVE;
  dynamic _loadingError;

  @override
  Future<void> loadCallback() async {
    context
        .read<RssState>()
        .fetchFeed(widget.feed!)!
        .then((result) => {
              if (this.mounted)
                setState(() => {
                      _loadingState = LunaLoadingState.INACTIVE,
                      _loadingError = null,
                    })
            })
        .catchError((error, stack) {
      LunaLogger()
          .error('Unable to open link: ${widget.feed!.url}', error, stack);
      if (this.mounted)
        setState(() => {
              _loadingState = LunaLoadingState.ERROR,
              _loadingError = error,
            });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: context.read<RssState>(),
      builder: (context, _) => LunaBlock(
        title: widget.feed!.displayName,
        body: [
          TextSpan(text: widget.feed!.url),
          TextSpan(
              text: widget.feed!.lastItemDate != null
                  ? '${widget.feed!.lastItemDate!.asAge()} - ${widget.feed!.lastItemDate!.asTimeOnly()}'
                  : 'rss.NoPublishDate'.tr(),
              style: const TextStyle(color: LunaColours.blue)),
        ],
        leading: _leading(),
        trailing: _trailing(),
        onTap: () async {
          if (_loadingState != LunaLoadingState.ACTIVE) {
            context.read<RssState>().feed = widget.feed!;
            if (_loadingState == LunaLoadingState.ERROR) {
              context.read<RssState>().fetchCurrentFeed(update: true);
            }
            RssRoutes.RESULTS.go();
          }
        },
      ),
    );
  }

  Widget _leading() {
    return Container(
        alignment: Alignment.center,
        child: LunaHighlightedNode(
            text: widget.feed?.recent.toString() ?? '0',
            backgroundColor: _loadingState == LunaLoadingState.ERROR
                ? LunaColours.red
                : LunaColours.accent));
  }

  Widget _trailing() {
    return LunaIconButton.arrow(
      loadingState: _loadingState,
      onPressed: () async {
        if (_loadingState == LunaLoadingState.ERROR) {
          showLunaErrorSnackBar(
              title: 'rss.ErrorFetching'.tr(), error: _loadingError);
        }
      },
    );
  }
}
