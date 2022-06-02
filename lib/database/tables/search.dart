import 'package:lunasea/database/table.dart';

enum SearchDatabase<T> with LunaTableMixin<T> {
  HIDE_XXX<bool>(false),
  SHOW_LINKS<bool>(true);

  @override
  LunaTable get table => LunaTable.search;

  @override
  final T fallback;

  const SearchDatabase(this.fallback);
}
