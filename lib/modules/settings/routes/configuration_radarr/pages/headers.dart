import 'package:fluro/fluro.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationRadarrHeadersRouter extends SettingsPageRouter {
    SettingsConfigurationRadarrHeadersRouter() : super('/settings/configuration/radarr/headers');
    
    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(
        router,
        SettingsHeaderRoute(module: LunaModule.RADARR),
    );
}
