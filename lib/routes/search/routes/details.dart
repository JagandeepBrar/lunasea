import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';
import 'package:provider/provider.dart';

class SearchDetails extends StatefulWidget {
    static const ROUTE_NAME = '/search/details';

    @override
    State<SearchDetails> createState() =>  _State();
}

class _State extends State<SearchDetails> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    void initState() {
        super.initState();
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(title: Provider.of<SearchModel>(context, listen: false)?.resultDetails?.title ?? 'Result Details');

    Widget get _body => LSListView(
        children: <Widget>[
            Consumer<SearchModel>(
                builder: (context, _state, child) => LSCardTile(
                    title: LSTitle(text: 'Title'),
                    subtitle: LSSubtitle(text: _state?.resultDetails?.title ?? 'Unknown'),
                    trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                    onTap: () => SystemDialogs.showTextPreviewPrompt(context, 'Title', _state?.resultDetails?.title ?? 'Unknown'),
                ),
            ),
        ],
        padBottom: true,
    );
}
