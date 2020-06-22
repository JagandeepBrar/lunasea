import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
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
        return widget.profile.anythingEnabled || Database.indexersBox.length > 0
        ? _body
        : _nothing;
    }

    Widget get _body {
        bool _hasIndexers = ModuleFlags.SEARCH && Database.indexersBox.length > 0;
        int _serviceCount = widget.profile.enabledModules.length + (_hasIndexers ? 2 : 1);
        return LSListViewBuilder(
            itemCount: _serviceCount,
            itemBuilder: (context, index) {
                //Check if indexer search should be included at the top
                if(index == 0 && _hasIndexers) return HomeSummaryTile(
                    title: Constants.MODULE_MAP['search']['name'],
                    subtitle: Constants.MODULE_MAP['search']['desc'],
                    icon: Constants.MODULE_MAP['search']['icon'],
                    index: index,
                    route: Constants.MODULE_MAP['search']['route'],
                );
                if(index == _serviceCount-1) return HomeSummaryTile(
                    title: Constants.MODULE_MAP['settings']['name'],
                    subtitle: Constants.MODULE_MAP['settings']['desc'],
                    icon: Constants.MODULE_MAP['settings']['icon'],
                    index: index,
                    route: Constants.MODULE_MAP['settings']['route'],
                    justPush: true,
                );
                Map data = Constants.MODULE_MAP[widget.profile.enabledModules[_hasIndexers ? index-1 : index]];
                if(data != null) return HomeSummaryTile(
                        title: data['name'],
                        subtitle: data['desc'],
                        icon: data['icon'],
                        index: index,
                        route: data['route'],
                );
                return Container();
            },
        );
    }

    Widget get _nothing => LSGenericMessage(text: 'No Modules Enabled');
}