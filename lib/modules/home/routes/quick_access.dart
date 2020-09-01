import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules.dart';
import 'package:lunasea/modules/home.dart';

class HomeQuickAccess extends StatefulWidget {
    static const ROUTE_NAME = '/home/quickaccess';
    final ProfileHiveObject profile = Database.currentProfileObject;

    @override
    State<HomeQuickAccess> createState() => _State();
}

class _State extends State<HomeQuickAccess> with AutomaticKeepAliveClientMixin {
    @override
    bool get wantKeepAlive => true;

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return ValueListenableBuilder(
            valueListenable: Database.indexersBox.listenable(),
            builder: (context, box, _) => widget.profile.anythingEnabled || Database.indexersBox.length > 0
                ? _body
                : LSNotEnabled(Constants.NO_SERVICES_ENABLED, showButton: false),
        );
    }

    Widget get _body {
        bool _hasIndexers = Database.indexersBox.length > 0;
        int _serviceCount = widget.profile.enabledModules.length + (_hasIndexers ? 2 : 1);
        return LSListViewBuilder(
            itemCount: _serviceCount,
            itemBuilder: (context, index) {
                //Check if indexer search should be included at the top
                if(index == 0 && _hasIndexers) return HomeSummaryTile(
                    title: Constants.MODULE_MAP[SearchConstants.MODULE_KEY].name,
                    subtitle: Constants.MODULE_MAP[SearchConstants.MODULE_KEY].description,
                    icon: Constants.MODULE_MAP[SearchConstants.MODULE_KEY].icon,
                    index: index,
                    route: Constants.MODULE_MAP[SearchConstants.MODULE_KEY].route,
                    color: Constants.MODULE_MAP[SearchConstants.MODULE_KEY].color,
                );
                if(index == _serviceCount-1) return HomeSummaryTile(
                    title: Constants.MODULE_MAP[SettingsConstants.MODULE_KEY].name,
                    subtitle: Constants.MODULE_MAP[SettingsConstants.MODULE_KEY].description,
                    icon: Constants.MODULE_MAP[SettingsConstants.MODULE_KEY].icon,
                    index: index,
                    route: Constants.MODULE_MAP[SettingsConstants.MODULE_KEY].route,
                    color: Constants.MODULE_MAP[SettingsConstants.MODULE_KEY].color,
                    justPush: true,
                );
                ModuleMap data = Constants.MODULE_MAP[widget.profile.enabledModules[_hasIndexers ? index-1 : index]];
                if(data != null) return HomeSummaryTile(
                        title: data.name,
                        subtitle: data.description,
                        icon: data.icon,
                        index: index,
                        route: data.route,
                        color: data.color,
                );
                return Container();
            },
        );
    }
}
