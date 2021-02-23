import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SearchDatabase extends LunaModuleDatabase {
    @override
    void registerAdapters() {}

    @override
    Map<String, dynamic> export() {
        Map<String, dynamic> data = {};
        for(SearchDatabaseValue value in SearchDatabaseValue.values) {
            switch(value) {
                // Primitive values
                case SearchDatabaseValue.NAVIGATION_INDEX:
                case SearchDatabaseValue.SHOW_LINKS:
                case SearchDatabaseValue.HIDE_XXX: data[value.key] = value.data; break;
            }
        }
        return data;
    }

    @override
    void import(Map<String, dynamic> config) {
        for(String key in config.keys) {
            SearchDatabaseValue value = valueFromKey(key);
            if(value != null) switch(value) {
                // Primitive values
                case SearchDatabaseValue.NAVIGATION_INDEX:
                case SearchDatabaseValue.SHOW_LINKS:
                case SearchDatabaseValue.HIDE_XXX: value.put(config[key]); break;
            }
        }
    }

    @override
    SearchDatabaseValue valueFromKey(String key) {
        switch(key) {
            case 'SEARCH_NAVIGATION_INDEX': return SearchDatabaseValue.NAVIGATION_INDEX;
            case 'SEARCH_HIDE_XXX': return SearchDatabaseValue.HIDE_XXX;
            case 'SEARCH_SHOW_LINKS': return SearchDatabaseValue.SHOW_LINKS;
            default: return null;
        }
    }
}

enum SearchDatabaseValue {
    NAVIGATION_INDEX,
    HIDE_XXX,
    SHOW_LINKS,
}

extension SearchDatabaseValueExtension on SearchDatabaseValue {
    String get key {
        switch(this) {
            case SearchDatabaseValue.NAVIGATION_INDEX: return 'SEARCH_NAVIGATION_INDEX';
            case SearchDatabaseValue.HIDE_XXX: return 'SEARCH_HIDE_XXX';
            case SearchDatabaseValue.SHOW_LINKS: return 'SEARCH_SHOW_LINKS';
        }
        throw Exception('key not found'); 
    }

    dynamic get data {
        final _box = Database.lunaSeaBox;
        switch(this) {
            case SearchDatabaseValue.NAVIGATION_INDEX: return _box.get(this.key, defaultValue: 0);
            case SearchDatabaseValue.HIDE_XXX: return _box.get(this.key, defaultValue: false);
            case SearchDatabaseValue.SHOW_LINKS: return _box.get(this.key, defaultValue: true);
        }
        throw Exception('data not found'); 
    }

    void put(dynamic value) {
        final box = Database.lunaSeaBox;
        switch(this) {
            case SearchDatabaseValue.NAVIGATION_INDEX: if(value.runtimeType == int) box.put(this.key, value); return;
            case SearchDatabaseValue.HIDE_XXX: if(value.runtimeType == bool) box.put(this.key, value); return;
            case SearchDatabaseValue.SHOW_LINKS: if(value.runtimeType == bool) box.put(this.key, value); return;
        }
        LunaLogger().warning('SearchDatabaseValueExtension', 'put', 'Attempted to enter data for invalid SearchDatabaseValue: ${this?.toString() ?? 'null'}');
    }

    ValueListenableBuilder listen({ @required Widget Function(BuildContext, dynamic, Widget) builder }) =>  ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [this.key]),
        builder: builder,
    );
}
