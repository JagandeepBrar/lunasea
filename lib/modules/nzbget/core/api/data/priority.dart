enum NZBGetPriority {
    force,
    veryHigh,
    high,
    normal,
    low,
    veryLow,
}

extension NZBGetPriorityExtension on NZBGetPriority {
    int get value {
        switch(this) {
            case NZBGetPriority.veryLow: return -100;
            case NZBGetPriority.low: return -50;
            case NZBGetPriority.normal: return 0;
            case NZBGetPriority.high: return 50;
            case NZBGetPriority.veryHigh: return 100;
            case NZBGetPriority.force: return 900;
            default: return -1;
        }
    }

    String get name {
        switch(this) {
            case NZBGetPriority.veryLow: return 'Very Low';
            case NZBGetPriority.low: return 'Low';
            case NZBGetPriority.normal: return 'Normal';
            case NZBGetPriority.high: return 'High';
            case NZBGetPriority.veryHigh: return 'Very High';
            case NZBGetPriority.force: return 'Force';
            default: return 'Unknown';
        }
    }
}
