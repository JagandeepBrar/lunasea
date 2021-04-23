import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/search.dart';

class SearchSubcategoryTile extends StatelessWidget {
    final int index;

    SearchSubcategoryTile({
        Key key,
        @required this.index,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Selector<SearchState, NewznabCategoryData>(
            selector: (_, state) => state.activeCategory,
            builder: (context, category, _) {
                NewznabSubcategoryData subcategory = category.subcategories[index];
                return LunaListTile(
                    context: context,
                    title: LunaText.title(text: subcategory?.name ?? 'lunasea.Unknown'.tr()),
                    subtitle: LunaText.subtitle(
                        text: [
                            category?.name ?? 'lunasea.Unknown'.tr(),
                            subcategory?.name ?? 'lunasea.Unknown'.tr(),
                        ].join(' > '),
                    ),
                    trailing: LunaIconButton(icon: category?.icon, color: LunaColours().byListIndex(index+1)),
                    onTap: () async {
                        context.read<SearchState>().activeSubcategory = subcategory;
                        SearchResultsRouter().navigateTo(context);
                    }
                );
            },
        );
    }
}
