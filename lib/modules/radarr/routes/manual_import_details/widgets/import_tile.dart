import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrManualImportDetailsImportTile extends StatelessWidget {
    final RadarrManualImport manualImport;

    RadarrManualImportDetailsImportTile({
        Key key,
        @required this.manualImport,
    }) : super(key: key);

    Widget build(BuildContext context) {
        return ChangeNotifierProvider(
            create: (_) => _State(manualImport),
            builder: (context, _) => LunaExpandableListTile(
                key: ObjectKey(manualImport),
                title: context.watch<_State>().manualImport.relativePath,
                collapsedTrailing: Checkbox(
                    value: context.read<_State>().selected,
                    onChanged: (value) => context.read<_State>().selected = value,
                ),
                collapsedSubtitle1: _subtitle1(context),
                collapsedSubtitle2: _subtitle2(context),
                expandedTableButtons: _buttons(context),
                expandedTableContent: _table(context),
            ),
        );
    }
    
    TextSpan _subtitle1(BuildContext context) {
        return TextSpan(
            children: [
                TextSpan(text: context.watch<_State>().manualImport.lunaQualityProfile),
                TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
                TextSpan(text: context.watch<_State>().manualImport.lunaLanguage),
                TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
                TextSpan(text: context.watch<_State>().manualImport.lunaSize),
            ],
        );
    }

    TextSpan _subtitle2(BuildContext context) {
        return TextSpan(
            text: context.watch<_State>().manualImport.lunaMovie,
            style: TextStyle(
                fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                color: LunaColours.accent,
            ),
        );
    }

    List<LunaTableContent> _table(BuildContext context) {
        return [
            LunaTableContent(title: 'movie', body: context.watch<_State>().manualImport.lunaMovie),
            LunaTableContent(title: 'quality', body: context.watch<_State>().manualImport.lunaQualityProfile),
            LunaTableContent(title: 'language', body: context.watch<_State>().manualImport.lunaLanguage),
            LunaTableContent(title: 'size', body: context.watch<_State>().manualImport.lunaSize),
        ];
    }

    List<LunaButton> _buttons(BuildContext context) {
        return [
            _configureButton(context),
            if((context.read<_State>().manualImport.rejections?.length ?? 0) > 0) _rejectionsButton(context),
        ];
    }

    LunaButton _configureButton(BuildContext context) {
        // RadarrManualImport import = context.watch<_State>().manualImport;
        return LunaButton.text(
            text: 'Configure',
            onTap: () async {},
        );
    }

    LunaButton _rejectionsButton(BuildContext context) {
        return LunaButton.text(
            text: 'radarr.Rejected'.tr(),
            backgroundColor: LunaColours.red,
            onTap: () async => LunaDialogs().showRejections(
                context,
                context.read<_State>().manualImport.rejections?.map<String>((rejection) => rejection.reason)?.toList(),
            ),
        );
    }
}

class _State extends ChangeNotifier {    
    _State(this._manualImport);

    RadarrManualImport _manualImport;
    RadarrManualImport get manualImport => _manualImport;
    set manualImport(RadarrManualImport manualImport) {
        assert(manualImport != null);
        _manualImport = manualImport;
        notifyListeners();
    }

    bool _selected = false;
    bool get selected => _selected;
    set selected(bool selected) {
        _selected = selected;
        notifyListeners();
    }

    void _update(RadarrManualImportUpdate updates) {
        RadarrManualImport _import = _manualImport;
        _import.movie = updates.movie;
        _import.id = updates.id;
        _import.path = updates.path;
        _import.rejections = updates.rejections;
        manualImport = _import;
        _checkIfShouldSelect();
    }

    void _checkIfShouldSelect() {
        if(
            _manualImport.movie != null &&
            _manualImport.quality != null &&
            (_manualImport.languages?.length ?? 0) > 0 &&
            _manualImport.languages[0].id >= 0
        ) selected = true;
    }

    Future<void> fetchUpdates(BuildContext context, int movieId) async {
        if(context.read<RadarrState>().enabled) {
            RadarrManualImportUpdateData data = RadarrManualImportUpdateData(
                id: manualImport.id,
                path: manualImport.path,
                movieId: movieId,
            );
            context.read<RadarrState>().api.manualImport.update(data: [data])
            .then((value) {
                if((value?.length ?? 0) > 0) _update(value[0]);
            });
        }
    }
}
