import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/routes/search/routes.dart';
import 'package:lunasea/widgets/ui.dart';

class LSSearchResultTile extends StatelessWidget {
    final NewznabResultData result;

    LSSearchResultTile({
        @required this.result,
    });

    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: result.title),
        subtitle: LSSubtitle(text: result?.size?.lsBytes_BytesToString()),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async => _enterDetails(context),
    );

    Future<void> _enterDetails(BuildContext context) async {
        Provider.of<SearchModel>(context, listen: false)?.resultDetails = result;
        Navigator.of(context).pushNamed(SearchDetails.ROUTE_NAME);
    }
}