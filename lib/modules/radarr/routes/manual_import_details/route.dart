import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';
import 'package:lunasea/widgets/pages/invalid_route.dart';

class ManualImportDetailsRoute extends StatefulWidget {
  final String? path;

  const ManualImportDetailsRoute({
    Key? key,
    required this.path,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ManualImportDetailsRoute>
    with LunaScrollControllerMixin, LunaLoadCallbackMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Future<void> loadCallback() async {
    context.read<RadarrState>().fetchMovies();
    context.read<RadarrState>().fetchQualityDefinitions();
    context.read<RadarrState>().fetchLanguages();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.path?.isEmpty ?? true) {
      return InvalidRoutePage(
        title: 'radarr.ManualImport'.tr(),
        message: 'radarr.DirectoryNotFound'.tr(),
      );
    }
    return ChangeNotifierProvider(
      create: (BuildContext context) => RadarrManualImportDetailsState(
        context,
        path: widget.path!,
      ),
      builder: (context, _) {
        return LunaScaffold(
          scaffoldKey: _scaffoldKey,
          appBar: _appBar(),
          body: _body(context),
          bottomNavigationBar: const RadarrManualImportDetailsBottomActionBar(),
        );
      },
    );
  }

  PreferredSizeWidget _appBar() {
    return LunaAppBar(
      title: 'radarr.ManualImport'.tr(),
      scrollControllers: [scrollController],
    );
  }

  Widget _body(BuildContext context) {
    return FutureBuilder(
      future: Future.wait(
        [
          context.select(
              (RadarrManualImportDetailsState state) => state.manualImport!),
          context.select((RadarrState state) => state.qualityProfiles!),
          context.select((RadarrState state) => state.languages!),
        ],
      ),
      builder: (context, AsyncSnapshot<List<Object>> snapshot) {
        if (snapshot.hasError) {
          if (snapshot.connectionState != ConnectionState.waiting) {
            LunaLogger().error(
              'Unable to fetch Radarr manual import: ${context.read<RadarrManualImportDetailsState>().path}',
              snapshot.error,
              snapshot.stackTrace,
            );
          }
          return LunaMessage.error(
            onTap: () => context
                .read<RadarrManualImportDetailsState>()
                .fetchManualImport(context),
          );
        }
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return _list(
            context,
            manualImport: snapshot.data![0] as List<RadarrManualImport>,
          );
        }
        return const LunaLoader();
      },
    );
  }

  Widget _list(
    BuildContext context, {
    required List<RadarrManualImport> manualImport,
  }) {
    if (manualImport.isEmpty) {
      return LunaMessage(
        text: 'radarr.NoFilesFound'.tr(),
        buttonText: 'lunasea.Refresh'.tr(),
        onTap: () => context
            .read<RadarrManualImportDetailsState>()
            .fetchManualImport(context),
      );
    }
    context.read<RadarrManualImportDetailsState>().canExecuteAction = true;
    return LunaListViewBuilder(
      controller: scrollController,
      itemCount: manualImport.length,
      itemBuilder: (context, index) => RadarrManualImportDetailsTile(
        key: ObjectKey(manualImport[index].id),
        manualImport: manualImport[index],
      ),
    );
  }
}
