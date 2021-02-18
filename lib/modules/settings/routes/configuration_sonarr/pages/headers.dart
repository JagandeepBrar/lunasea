import 'package:fluro/fluro.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/system.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationSonarrHeadersRouter extends LunaPageRouter {
    SettingsConfigurationSonarrHeadersRouter() : super('/settings/configuration/sonarr/headers');
    
    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(
        router,
        SettingsHeaderRoute(module: LunaModule.SONARR),
    );
}
