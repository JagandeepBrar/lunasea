import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';

class SettingsSystemChangelogDetailsArguments {
    final Map details;

    SettingsSystemChangelogDetailsArguments({
        @required this.details,
    });
}

class SettingsSystemChangelogDetails extends StatefulWidget {
    static const ROUTE_NAME = '/settings/system/changelog/details';

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<SettingsSystemChangelogDetails> {
    SettingsSystemChangelogDetailsArguments _arguments;

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.addPostFrameCallback((_) => 
            setState(() => _arguments = ModalRoute.of(context).settings.arguments)
        );
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        appBar: _appBar,
        body: _body,
    );

    Widget get _body => _arguments == null
        ? null
        : LSListView(
            children: [
                LSHeader(text: 'New'),
                ..._new,
                LSHeader(text: 'Tweaks'),
                ..._tweaks,
                LSHeader(text: 'Fixes'),
                ..._fixes,
            ],
            padBottom: true,
        );

    List<Widget> get _new => List.generate(
        _arguments.details['new'].length,
        (index) {
            String title = _arguments.details['new'][index];
            return LSCardTile(
                title: LSTitle(text: title.substring(title.indexOf('] ')+2)),
                subtitle: LSSubtitle(text: title.substring(1, title.indexOf('] '))),
                trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                onTap: () async => LSDialogSystem.textPreview(context, 'Change', title.substring(title.indexOf('] ')+2)),
            );
        }
    );

    List<Widget> get _tweaks => List.generate(
        _arguments.details['tweaks'].length,
        (index) {
            String title = _arguments.details['tweaks'][index];
            return LSCardTile(
                title: LSTitle(text: title.substring(title.indexOf('] ')+2)),
                subtitle: LSSubtitle(text: title.substring(1, title.indexOf('] '))),
                trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                onTap: () async => LSDialogSystem.textPreview(context, 'Change', title.substring(title.indexOf('] ')+2)),
            );
        },
    );

    List<Widget> get _fixes => List.generate(
        _arguments.details['fixes'].length,
        (index) {
            String title = _arguments.details['fixes'][index];
            return LSCardTile(
                title: LSTitle(text: title.substring(title.indexOf('] ')+2)),
                subtitle: LSSubtitle(text: title.substring(1, title.indexOf('] '))),
                trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                onTap: () async => LSDialogSystem.textPreview(context, 'Change', title.substring(title.indexOf('] ')+2)),
            );
        }
    );

    Widget get _appBar => LSAppBar(title: _arguments == null ? 'Changelog' : _arguments.details['version']);
}
