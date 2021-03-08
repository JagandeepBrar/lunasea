import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/search.dart';

class SearchCategoryTile extends StatelessWidget {
    final NewznabCategoryData category;
    final int index;

    SearchCategoryTile({
        @required this.category,
        this.index = 0,
    });

    @override
    Widget build(BuildContext context) {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: category.name ?? 'lunasea.Unknown'.tr()),
            subtitle: LunaText.subtitle(
                text: category.subcategoriesTitleList,
            ),
            trailing: LunaIconButton(icon: category.icon, color: LunaColours.list(index)),
            onTap: () async {
                context.read<SearchState>().activeCategory = category;
                SearchSubcategoriesRouter().navigateTo(context);
            },
        );
    }
}
