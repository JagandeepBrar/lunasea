import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/overseerr.dart';

class OverseerrRequestTile extends StatelessWidget {
  final OverseerrRequest request;

  const OverseerrRequestTile({
    Key key,
    @required this.request,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: request.requestedBy.displayName ?? 'overseerr.UnknownUser'.tr(),
      body: const [
        TextSpan(text: 'Placeholder 1'),
        TextSpan(text: 'Placeholder 2'),
      ],
      posterPlaceholderIcon: LunaIcons.USER,
      posterHeaders: context.read<OverseerrState>().headers,
      posterUrl: request.requestedBy.avatar,
      posterIsSquare: true,
    );
  }
}
