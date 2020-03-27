import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import '../../home.dart';

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
        bool _hasIndexers = Database.indexersBox.length > 0;
        int _serviceCount = widget.profile.enabledServices.length + (_hasIndexers ? 2 : 1);
        return LSListViewBuilder(
            itemCount: _serviceCount,
            itemBuilder: (context, index) {
                //Check if indexer search should be included at the top
                if(index == 0 && _hasIndexers) return HomeSummaryTile(
                    title: Constants.SERVICE_MAP['search']['name'],
                    subtitle: Constants.SERVICE_MAP['search']['desc'],
                    icon: Constants.SERVICE_MAP['search']['icon'],
                    index: index,
                    route: Constants.SERVICE_MAP['search']['route'],
                );
                if(index == _serviceCount-1) return HomeSummaryTile(
                    title: Constants.SERVICE_MAP['settings']['name'],
                    subtitle: Constants.SERVICE_MAP['settings']['desc'],
                    icon: Constants.SERVICE_MAP['settings']['icon'],
                    index: index,
                    route: Constants.SERVICE_MAP['settings']['route'],
                    justPush: true,
                );
                Map data = Constants.SERVICE_MAP[widget.profile.enabledServices[_hasIndexers ? index-1 : index]];
                if(data != null) return HomeSummaryTile(
                        title: data['name'],
                        subtitle: data['desc'],
                        icon: data['icon'],
                        index: index,
                        route: data['route'],
                );
                return Container();
            },
            customPadding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 85.0),
        );
    }

    Widget get _nothing => LSGenericMessage(text: 'No Services Enabled');
}