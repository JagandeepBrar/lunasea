enum TautulliStatisticsTimeRange {
  ONE_WEEK,
  TWO_WEEK,
  ONE_MONTH,
  SIX_MONTH,
  ONE_YEAR,
  TWO_YEAR,
}

extension TautulliStatisticsTimeRangeExtension on TautulliStatisticsTimeRange {
  String get name {
    switch (this) {
      case TautulliStatisticsTimeRange.ONE_WEEK:
        return '1 Week';
      case TautulliStatisticsTimeRange.TWO_WEEK:
        return '2 Weeks';
      case TautulliStatisticsTimeRange.ONE_MONTH:
        return '1 Month';
      case TautulliStatisticsTimeRange.SIX_MONTH:
        return '6 Months';
      case TautulliStatisticsTimeRange.ONE_YEAR:
        return '1 Year';
      case TautulliStatisticsTimeRange.TWO_YEAR:
        return '2 Years';
    }
  }

  int get value {
    switch (this) {
      case TautulliStatisticsTimeRange.ONE_WEEK:
        return 7;
      case TautulliStatisticsTimeRange.TWO_WEEK:
        return 14;
      case TautulliStatisticsTimeRange.ONE_MONTH:
        return 30;
      case TautulliStatisticsTimeRange.SIX_MONTH:
        return 90;
      case TautulliStatisticsTimeRange.ONE_YEAR:
        return 365;
      case TautulliStatisticsTimeRange.TWO_YEAR:
        return 730;
    }
  }
}
