import 'package:fluro/fluro.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationNZBGetHeadersRouter extends SettingsPageRouter {
    SettingsConfigurationNZBGetHeadersRouter() : super('/settings/configuration/nzbget/headers');
    
    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(
        router,
        SettingsHeaderRoute(module: LunaModule.NZBGET),
    );
}
