import 'package:lunasea/database/table.dart';

enum SearchDatabase<T> with LunaTableMixin<T> {
  HIDE_XXX<bool>(false),
  SHOW_LINKS<bool>(true);

  @override
  String get table => TABLE_SEARCH_KEY;

  @override
  final T defaultValue;

  const SearchDatabase(this.defaultValue);
}
