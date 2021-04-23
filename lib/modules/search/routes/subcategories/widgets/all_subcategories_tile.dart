import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/search.dart';

class SearchSubcategoryAllTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'search.AllSubcategories'.tr()),
            subtitle: LunaText.subtitle(text: context.read<SearchState>().activeCategory?.name ?? 'lunasea.Unknown'.tr()),
            trailing: LunaIconButton(icon: context.read<SearchState>().activeCategory?.icon, color: LunaColours().byListIndex(0)),
            onTap: () async {
                context.read<SearchState>().activeSubcategory = null;
                SearchResultsRouter().navigateTo(context);
            },
        );
    }
}
