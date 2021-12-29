import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliHistoryDetailsRouter extends TautulliPageRouter {
  TautulliHistoryDetailsRouter()
      : super('/tautulli/history/:ratingkey/:key/:value');

  @override
  _Widget widget({
    required int ratingKey,
    int? referenceId,
    int? sessionKey,
  }) =>
      _Widget(
        ratingKey: ratingKey,
        referenceId: referenceId,
        sessionKey: sessionKey,
      );

  @override
  Future<void> navigateTo(
    BuildContext context, {
    required int? ratingKey,
    int? referenceId,
    int? sessionKey,
  }) async =>
      LunaRouter.router.navigateTo(
        context,
        route(
          ratingKey: ratingKey,
          referenceId: referenceId,
          sessionKey: sessionKey,
        ),
      );

  @override
  String route({
    required int? ratingKey,
    int? referenceId,
    int? sessionKey,
  }) {
    String _route = TautulliHomeRouter().route();
    if (referenceId != null)
      _route = fullRoute
          .replaceFirst(':ratingkey', ratingKey.toString())
          .replaceFirst(':key', 'referenceid')
          .replaceFirst(':value', referenceId.toString());
    if (sessionKey != null)
      _route = fullRoute
          .replaceFirst(':ratingkey', ratingKey.toString())
          .replaceFirst(':key', 'sessionkey')
          .replaceFirst(':value', sessionKey.toString());
    return _route;
  }

  @override
  void defineRoute(FluroRouter router) => super.withParameterRouteDefinition(
        router,
        (context, params) {
          int ratingKey = (params['ratingkey']?.isNotEmpty ?? false)
              ? int.tryParse(params['ratingkey']![0]) ?? -1
              : -1;
          int value = (params['value']!.isNotEmpty ?? false)
              ? int.tryParse(params['value']![0]) ?? -1
              : -1;
          return _Widget(
            ratingKey: ratingKey,
            referenceId: params['key']![0] == 'referenceid' ? value : null,
            sessionKey: params['key']![0] == 'sessionkey' ? value : null,
          );
        },
      );
}

class _Widget extends StatefulWidget {
  final int ratingKey;
  final int? sessionKey;
  final int? referenceId;

  const _Widget({
    Key? key,
    required this.ratingKey,
    this.sessionKey,
    this.referenceId,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<_Widget>
    with LunaLoadCallbackMixin, LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Future<void> loadCallback() async {
    context.read<TautulliState>().setIndividualHistory(
          widget.ratingKey,
          context.read<TautulliState>().api!.history.getHistory(
                length: TautulliDatabaseValue.CONTENT_LOAD_LENGTH.data,
                ratingKey: widget.ratingKey,
              ),
        );
    await context.read<TautulliState>().individualHistory[widget.ratingKey];
  }

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar() as PreferredSizeWidget?,
      body: _body(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'History Details',
      scrollControllers: [scrollController],
      actions: [
        TautulliHistoryDetailsUser(
            ratingKey: widget.ratingKey,
            sessionKey: widget.sessionKey,
            referenceId: widget.referenceId),
        TautulliHistoryDetailsMetadata(
            ratingKey: widget.ratingKey,
            sessionKey: widget.sessionKey,
            referenceId: widget.referenceId),
      ],
    );
  }

  Widget _body() {
    return LunaRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: loadCallback,
      child: FutureBuilder(
        future:
            context.watch<TautulliState>().individualHistory[widget.ratingKey],
        builder: (context, AsyncSnapshot<TautulliHistory> snapshot) {
          if (snapshot.hasError) {
            if (snapshot.connectionState != ConnectionState.waiting)
              LunaLogger().error(
                'Unable to pull Tautulli history session',
                snapshot.error,
                snapshot.stackTrace,
              );
            return LunaMessage.error(onTap: _refreshKey.currentState?.show);
          }
          if (snapshot.hasData) {
            TautulliHistoryRecord? _record =
                snapshot.data!.records!.firstWhereOrNull((record) {
              if (record.referenceId == (widget.referenceId ?? -1) ||
                  record.sessionKey == (widget.sessionKey ?? -1)) return true;
              return false;
            });
            if (_record != null)
              return TautulliHistoryDetailsInformation(
                scrollController: scrollController,
                history: _record,
              );
            return _unknown();
          }
          return const LunaLoader();
        },
      ),
    );
  }

  Widget _unknown() {
    return LunaMessage.goBack(
      context: context,
      text: 'History Not Found',
    );
  }
}
