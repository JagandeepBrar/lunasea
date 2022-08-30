import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class TagsRoute extends StatefulWidget {
  const TagsRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<TagsRoute> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.scheduleFrameCallback((_) => _refresh());
  }

  Future<void> _refresh() async {
    context.read<RadarrState>().fetchTags();
    await context.read<RadarrState>().tags;
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
        RadarrTagsAppBarActionAddTag(),
      ],
    );
  }

  Widget _body() {
    return LunaRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: _refresh,
      child: FutureBuilder(
        future: context.watch<RadarrState>().tags,
        builder: (context, AsyncSnapshot<List<RadarrTag>> snapshot) {
          if (snapshot.hasError) {
            if (snapshot.connectionState != ConnectionState.waiting) {
              LunaLogger().error(
                'Unable to fetch Radarr tags',
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

  Widget _list(List<RadarrTag>? tags) {
    if ((tags?.length ?? 0) == 0) {
      return LunaMessage(
        text: 'radarr.NoTagsFound'.tr(),
        buttonText: 'lunasea.Refresh'.tr(),
        onTap: _refreshKey.currentState!.show,
      );
    }
    return LunaListViewBuilder(
      controller: scrollController,
      itemCount: tags!.length,
      itemBuilder: (context, index) => RadarrTagsTagTile(
        key: ObjectKey(tags[index].id),
        tag: tags[index],
      ),
    );
  }
}
