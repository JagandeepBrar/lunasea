import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class _RadarrManualImportDetailsArguments {
    final String path;

    _RadarrManualImportDetailsArguments({
        @required this.path,
    }) {
        assert(path != null);
    }
}

class RadarrManualImportDetailsRouter extends RadarrPageRouter {
    RadarrManualImportDetailsRouter() : super('/radarr/manualimport/details');

    @override
    Future<void> navigateTo(BuildContext context, {
        @required String path,
    }) => LunaRouter.router.navigateTo(
        context,
        route(),
        routeSettings: RouteSettings(arguments: _RadarrManualImportDetailsArguments(path: path)),
    );
    
    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _RadarrMoviesAddDetailsRoute());
}

class _RadarrMoviesAddDetailsRoute extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<_RadarrMoviesAddDetailsRoute> with LunaScrollControllerMixin {
    @override
    Widget build(BuildContext context) {
        _RadarrManualImportDetailsArguments arguments = ModalRoute.of(context).settings.arguments;
        if(arguments == null || arguments.path == null || arguments.path.isEmpty) return LunaInvalidRoute(
            title: 'radarr.ManualImport'.tr(),
            message: 'radarr.DirectoryNotFound'.tr(),
        );
        return ChangeNotifierProvider(
            create: (BuildContext context) => RadarrManualImportDetailsState(context, path: arguments.path),
            builder: (context, _) {
                return Scaffold(
                    appBar: _appBar(),
                );
            },
        );
    }

    Widget _appBar() {
        return LunaAppBar(
            title: 'radarr.ManualImport'.tr(),
            scrollControllers: [scrollController],
        );
    }
}