import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/search.dart';

class SearchResultTile extends StatelessWidget {
    final NewznabResultData result;

    SearchResultTile({
        @required this.result,
    });

    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: result.title),
        subtitle: RichText(
            maxLines: 2,
            text: TextSpan(
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                ),
                children: <TextSpan>[
                    TextSpan(
                        text: result?.age ?? 'Unknown Age',
                    ),
                    TextSpan(
                        text: '\n${result?.size?.lsBytes_BytesToString() ?? 'Unknown Size'}',
                    ),
                ],
            ),
        ),
        padContent: true,
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async => _enterDetails(context),
    );

    Future<void> _enterDetails(BuildContext context) async {
        Provider.of<SearchModel>(context, listen: false)?.resultDetails = result;
        Navigator.of(context).pushNamed(SearchDetails.ROUTE_NAME);
    }
}