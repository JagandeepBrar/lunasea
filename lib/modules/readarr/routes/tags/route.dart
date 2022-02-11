import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrTagsRouter extends ReadarrPageRouter {
  ReadarrTagsRouter() : super('/readarr/tags');

  @override
  _Widget widget() => _Widget();

  @override
  void defineRoute(FluroRouter router) {
    super.noParameterRouteDefinition(router);
  }
}

class _Widget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<_Widget>
    with LunaScrollControllerMixin, LunaLoadCallbackMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Future<void> loadCallback() async {
    context.read<ReadarrState>().fetchTags();
    await context.read<ReadarrState>().tags;
  }

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar() as PreferredSizeWidget?,
      body: _body(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'Tags',
      scrollControllers: [scrollController],
      actions: const [
        ReadarrTagsAppBarActionAddTag(),
      ],
    );
  }

  Widget _body() {
    return LunaRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: loadCallback,
      child: FutureBuilder(
        future: context.watch<ReadarrState>().tags,
        builder: (context, AsyncSnapshot<List<ReadarrTag>> snapshot) {
          if (snapshot.hasError) {
            if (snapshot.connectionState != ConnectionState.waiting) {
              LunaLogger().error(
                'Unable to fetch Readarr tags',
                snapshot.error,
                snapshot.stackTrace,
              );
            }
            return LunaMessage.error(onTap: _refreshKey.currentState!.show);
          }
          if (snapshot.hasData) return _list(snapshot.data);
          return const LunaLoader();
        },
      ),
    );
  }

  Widget _list(List<ReadarrTag>? tags) {
    if ((tags?.length ?? 0) == 0)
      return LunaMessage(
        text: 'readarr.NoTagsFound'.tr(),
        buttonText: 'lunasea.Refresh'.tr(),
        onTap: _refreshKey.currentState?.show,
      );
    return LunaListViewBuilder(
      controller: scrollController,
      itemCount: tags!.length,
      itemBuilder: (context, index) => ReadarrTagsTagTile(
        key: ObjectKey(tags[index].id),
        tag: tags[index],
      ),
    );
  }
}
