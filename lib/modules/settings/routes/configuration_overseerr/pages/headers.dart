import 'package:fluro/fluro.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationOverseerrHeadersRouter extends SettingsPageRouter {
    SettingsConfigurationOverseerrHeadersRouter() : super('/settings/configuration/overseerr/headers');
    
    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(
        router,
        SettingsHeaderRoute(module: LunaModule.OVERSEERR),
    );
}
