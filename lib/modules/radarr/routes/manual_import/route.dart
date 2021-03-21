import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrManualImportRouter extends RadarrPageRouter {
    RadarrManualImportRouter() : super('/radarr/manualimport');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _RadarrManualImportRoute());
}


class _RadarrManualImportRoute extends StatefulWidget {
    @override
    State<_RadarrManualImportRoute> createState() => _State();
}

class _State extends State<_RadarrManualImportRoute> with LunaScrollControllerMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) {
        return ChangeNotifierProvider(
            create: (context) => RadarrManualImportState(context),
            builder: (context, _) => Scaffold(
                key: _scaffoldKey,
                appBar: _appBar(),
                body: _body(context),
                bottomNavigationBar: RadarrManualImportBottomActionBar(),
            ),
        );
    }

    Widget _appBar() {
        return LunaAppBar(
            title: 'radarr.ManualImport'.tr(),
            scrollControllers: [scrollController],
        );
    }

    Widget _body(BuildContext context) {
        return FutureBuilder(
            future: context.select<RadarrManualImportState, Future<RadarrFileSystem>>((state) => state.directories),
            builder: (context, AsyncSnapshot<RadarrFileSystem> snapshot) {
                if(snapshot.hasError) {
                    if(snapshot.connectionState != ConnectionState.waiting) LunaLogger().error(
                        'Unable to fetch Radarr filesystem',
                        snapshot.error,
                        snapshot.stackTrace,
                    );
                    return LunaMessage.error(onTap: () => context.read<RadarrManualImportState>().fetchDirectories(
                        context,
                        context.read<RadarrManualImportState>().currentPath,
                    ));
                }
                if(snapshot.hasData) return _list(context, snapshot.data);
                return LunaLoader();
            },
        );
    }

    Widget _list(BuildContext context, RadarrFileSystem fileSystem) {
        if((fileSystem?.directories?.length ?? 0) == 0 && (fileSystem.parent == null || fileSystem.parent.isEmpty)) return LunaMessage(
            text: 'radarr.NoSubdirectoriesFound'.tr(),
        );
        return LunaListView(
            key: ObjectKey(fileSystem.directories),
            controller: scrollController,
            children: [
                RadarrManualImportParentDirectoryTile(fileSystem: fileSystem),
                ...List.generate(
                    fileSystem.directories.length,
                    (index) => RadarrManualImportDirectoryTile(directory: fileSystem.directories[index]),
                ),
            ]
        );
    }
}
