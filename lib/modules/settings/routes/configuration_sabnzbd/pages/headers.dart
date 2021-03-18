import 'package:fluro/fluro.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationSABnzbdHeadersRouter extends SettingsPageRouter {
    SettingsConfigurationSABnzbdHeadersRouter() : super('/settings/configuration/sabnzbd/headers');
    
    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(
        router,
        SettingsHeaderRoute(module: LunaModule.SABNZBD),
    );
}
