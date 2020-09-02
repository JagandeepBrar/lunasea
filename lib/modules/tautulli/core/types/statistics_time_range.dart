enum TautulliStatisticsTimeRange {
    ONE_MONTH,
    TWO_MONTH,
    SIX_MONTH,
    ONE_YEAR,
    TWO_YEAR,
}

extension TautulliStatisticsTimeRangeExtension on TautulliStatisticsTimeRange {
    String get name {
        switch(this) {
            case TautulliStatisticsTimeRange.ONE_MONTH: return '1 Month';
            case TautulliStatisticsTimeRange.TWO_MONTH: return '2 Months';
            case TautulliStatisticsTimeRange.SIX_MONTH: return '6 Months';
            case TautulliStatisticsTimeRange.ONE_YEAR: return '1 Year';
            case TautulliStatisticsTimeRange.TWO_YEAR: return '2 Years';
        }
        throw Exception('Invalid TautulliStatisticsTimeRange');
    }

    int get value {
        switch(this) {
            case TautulliStatisticsTimeRange.ONE_MONTH: return 30;
            case TautulliStatisticsTimeRange.TWO_MONTH: return 60;
            case TautulliStatisticsTimeRange.SIX_MONTH: return 90;
            case TautulliStatisticsTimeRange.ONE_YEAR: return 365;
            case TautulliStatisticsTimeRange.TWO_YEAR: return 730;
        }
        throw Exception('Invalid TautulliStatisticsTimeRange');
    }
}