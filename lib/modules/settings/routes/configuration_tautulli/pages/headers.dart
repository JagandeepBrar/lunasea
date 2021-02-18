import 'package:fluro/fluro.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/system.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationTautulliHeadersRouter extends LunaPageRouter {
    SettingsConfigurationTautulliHeadersRouter() : super('/settings/configuration/tautulli/headers');
    
    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(
        router,
        SettingsHeaderRoute(module: LunaModule.TAUTULLI),
    );
}
