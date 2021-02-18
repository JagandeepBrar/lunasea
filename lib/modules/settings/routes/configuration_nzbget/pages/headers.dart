import 'package:fluro/fluro.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/system.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationNZBGetHeadersRouter extends LunaPageRouter {
    SettingsConfigurationNZBGetHeadersRouter() : super('/settings/configuration/nzbget/headers');
    
    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(
        router,
        SettingsHeaderRoute(module: LunaModule.NZBGET),
    );
}
