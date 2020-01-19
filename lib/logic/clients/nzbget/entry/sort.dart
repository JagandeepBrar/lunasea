enum NZBGetSort {
    name_asc,
    name_desc,
    priority_asc,
    priority_desc,
    category_asc,
    category_desc,
    size_asc,
    size_desc,
    left_asc,
    left_desc,
}

extension NZBGetSortExtension on NZBGetSort {
    String value(NZBGetSort sort) {
        switch(sort) {
            case NZBGetSort.name_asc: {
                return 'name+';
            }
            case NZBGetSort.name_desc: {
                return 'name-';
            }
            case NZBGetSort.priority_asc: {
                return 'priority-';
            }
            case NZBGetSort.priority_desc: {
                return 'priority+';
            }
            case NZBGetSort.category_asc: {
                return 'category+';
            }
            case NZBGetSort.category_desc: {
                return 'category-';
            }
            case NZBGetSort.size_asc: {
                return 'size+';
            }
            case NZBGetSort.size_desc: {
                return 'size-';
            }
            case NZBGetSort.left_asc: {
                return 'left+';
            }
            case NZBGetSort.left_desc: {
                return 'left-';
            }
        }
        return 'unknown';
    }

    String name(NZBGetSort sort) {
        switch(sort) {
            case NZBGetSort.name_asc: {
                return 'Name (Ascending)';
            }
            case NZBGetSort.name_desc: {
                return 'Name (Descending)';
            }
            case NZBGetSort.priority_asc: {
                return 'Priority (Ascending)';
            }
            case NZBGetSort.priority_desc: {
                return 'Priority (Descending)';
            }
            case NZBGetSort.category_asc: {
                return 'Category (Ascending)';
            }
            case NZBGetSort.category_desc: {
                return 'Category (Descending)';
            }
            case NZBGetSort.size_asc: {
                return 'Size (Ascending)';
            }
            case NZBGetSort.size_desc: {
                return 'Size (Descending)';
            }
            case NZBGetSort.left_asc: {
                return 'Left (Ascending)';
            }
            case NZBGetSort.left_desc: {
                return 'Left (Descending)';
            }
        }
        return 'Unknown';
    }
}
