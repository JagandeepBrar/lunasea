import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules.dart';
import 'package:lunasea/system.dart';

class DashboardQuickAccess extends StatefulWidget {
    static const ROUTE_NAME = '/dashboard/quickaccess';
    final ProfileHiveObject profile = Database.currentProfileObject;

    @override
    State<DashboardQuickAccess> createState() => _State();
}

class _State extends State<DashboardQuickAccess> with AutomaticKeepAliveClientMixin {
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
                if(index == 0 && _hasIndexers) return DashboardSummaryTile(
                    title: LunaModule.SEARCH.name,
                    subtitle: LunaModule.SEARCH.description,
                    icon: LunaModule.SEARCH.icon,
                    index: index,
                    route: LunaModule.SEARCH.route,
                    color: LunaModule.SEARCH.color,
                );
                if(index == _serviceCount-1) return DashboardSummaryTile(
                    title: LunaModule.SETTINGS.name,
                    subtitle: LunaModule.SETTINGS.description,
                    icon: LunaModule.SETTINGS.icon,
                    index: index,
                    route: LunaModule.SETTINGS.route,
                    color: LunaModule.SETTINGS.color,
                );
                LunaModule data = widget.profile.enabledModules[_hasIndexers ? index-1 : index];
                if(data != null) return DashboardSummaryTile(
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
