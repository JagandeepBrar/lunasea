import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import '../../search.dart';

class SearchDetails extends StatefulWidget {
    static const ROUTE_NAME = '/search/details';

    @override
    State<SearchDetails> createState() =>  _State();
}

class _State extends State<SearchDetails> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar {
        final details = Provider.of<SearchModel>(context, listen: false).resultDetails;
        return LSAppBar(
            title: details?.title ?? 'Result Details',
            actions: <Widget>[
                if(details?.linkComments != '') LSIconButton(
                    icon: Icons.link,
                    onPressed: () => details?.linkComments?.lsLinks_OpenLink(),
                ),
            ],
        );
    }

    Widget get _body => Consumer<SearchModel>(
        builder: (context, _state, child) => LSListView(
            children: <Widget>[
                LSCardTile(
                    title: LSTitle(text: 'Release Title'),
                    subtitle: LSSubtitle(text: _state?.resultDetails?.title ?? 'Unknown'),
                    trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                    onTap: () => GlobalDialogs.textPreview(context, 'Release Title', _state?.resultDetails?.title ?? 'Unknown'),
                ),
                LSContainerRow(
                    children: <Widget>[
                        Expanded(
                            child: LSCardTile(
                                title: LSTitle(
                                    text: 'Age',
                                    centerText: true,
                                ),
                                subtitle: LSSubtitle(
                                    text: _state?.resultDetails?.age ?? 'Unknown Age',
                                    centerText: true,
                                ),
                                reducedMargin: true,
                            ),
                        ),
                        Expanded(
                            child: LSCardTile(
                                title: LSTitle(
                                    text: 'Size',
                                    centerText: true,
                                ),
                                subtitle: LSSubtitle(
                                    text: _state?.resultDetails?.size?.lsBytes_BytesToString() ?? 'Unknown Size',
                                    centerText: true,
                                ),
                                reducedMargin: true,
                            ),
                        ),
                    ],
                ),
                LSDivider(),
                SearchDetailsDownloadButton(scaffoldKey: _scaffoldKey),
            ],
            padBottom: true,
        ),
    );
}
