import 'package:fluro/fluro.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/system.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationSABnzbdHeadersRouter extends LunaPageRouter {
    SettingsConfigurationSABnzbdHeadersRouter() : super('/settings/configuration/sabnzbd/headers');
    
    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(
        router,
        SettingsHeaderRoute(module: LunaModule.SABNZBD),
    );
}
