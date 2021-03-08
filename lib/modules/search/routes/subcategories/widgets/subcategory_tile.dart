import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/search.dart';

class SearchSubcategoryTile extends StatelessWidget {
    final NewznabCategoryData category;
    final int index;
    final bool allSubcategories;

    SearchSubcategoryTile({
        @required this.category,
        @required this.index,
        this.allSubcategories = false,
    });

    @override
    Widget build(BuildContext context) => allSubcategories
        ? _cardAll(context)
        : _card(context);

    Widget _card(BuildContext context) {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: category?.subcategories[index ?? 0]?.name ?? 'Unknown'),
            subtitle: LunaText.subtitle(text: '${category?.name ?? 'Unknown'} > ${category?.subcategories[index ?? 0]?.name ?? 'Unknown'}'),
            trailing: LunaIconButton(icon: category?.icon, color: LunaColours.list(index+1)),
            onTap: () => _enterResults(
                context,
                category?.subcategories[index ?? 0]?.id ?? 0,
                '${category?.name ?? 'Unknown'}  >  ${category?.subcategories[index ?? 0]?.name ?? 'Unknown'}' ?? 'Unknown',
            ),
        );
    }

    Widget _cardAll(BuildContext context) {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'All Subcategories'),
            subtitle: LunaText.subtitle(text: '${category?.name} > All'),
            trailing: LunaIconButton(icon: category?.icon, color: LunaColours.list(0)),
            onTap: () async => _enterResults(
                context,
                category?.id ?? 0,
                category?.name ?? 'Unknown',
            ),
        );
    }

    Future<void> _enterResults(BuildContext context, int id, String title) async {
        final model = Provider.of<SearchState>(context, listen: false);
        model.searchTitle = title;
        model.searchCategoryID = id;
        Navigator.of(context).pushNamed(SearchResults.ROUTE_NAME);
    }
}