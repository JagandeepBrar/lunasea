import 'package:fluro/fluro.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationLidarrHeadersRouter extends SettingsPageRouter {
    SettingsConfigurationLidarrHeadersRouter() : super('/settings/configuration/lidarr/headers');
    
    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(
        router,
        SettingsHeaderRoute(module: LunaModule.LIDARR),
    );
}
