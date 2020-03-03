import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/routes/search/routes.dart';
import 'package:lunasea/widgets/ui.dart';
import 'package:provider/provider.dart';

class SearchSubcategories extends StatefulWidget {
    static const ROUTE_NAME = '/search/subcategories';

    @override
    State<SearchSubcategories> createState() =>  _State();
}

class _State extends State<SearchSubcategories> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body, 
    );

    Widget get _appBar => LSAppBar(title: Provider.of<SearchModel>(context, listen: false)?.category?.name ?? 'Subcategories');

    Widget get _body => Consumer<SearchModel>(
        builder: (context, _state, child) => LSListViewBuilder(
            itemCount: (_state?.category?.subcategories?.length ?? 0)+1,
            itemBuilder: (context, index) => index == 0
                ? _cardAll(_state)
                : _card(_state, index-1),
            padBottom: true,
        ),
    );

    Widget _card(SearchModel _state, int index) => LSCardTile(
        title: LSTitle(text: _state?.category?.subcategories[index]?.name ?? 'Unknown'),
        subtitle: LSSubtitle(text: '${_state?.category?.name ?? 'Unknown'} > ${_state?.category?.subcategories[index]?.name ?? 'Unknown'}'),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        leading: LSIconButton(icon: _state?.category?.icon, color: LSColors.list(index)),
        onTap: () => _enterResults(_state?.category?.subcategories[index]?.id),
    );

    Widget _cardAll(SearchModel _state) => LSCardTile(
        title: LSTitle(text: 'All Subcategories'),
        subtitle: LSSubtitle(text: '${_state?.category?.name} > All'),
        leading: LSIconButton(icon: _state?.category?.icon, color: LSColors.list(0)),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () => _enterResults(_state?.category?.id),
    );

    Future<void> _enterResults(int categoryId) async {
        final model = Provider.of<SearchModel>(context, listen: false);
        model.searchCategoryID = categoryId;
        model.searchQuery = '';
        Navigator.of(context).pushNamed(SearchResults.ROUTE_NAME);
    }
}
