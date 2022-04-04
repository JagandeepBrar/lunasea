import 'package:lunasea/modules/rss/core/types/rss_result_type.dart';

import '../../../core.dart';
import 'api.dart';

class RssState extends LunaModuleState {
  @override
  void reset() {}

  final RssAPI? _api = RssAPI.create();

  late FeedHiveObject _feed;
  FeedHiveObject get feed => _feed;
  set feed(FeedHiveObject feed) {
    _feed = feed;
    notifyListeners();
  }

  final Map<FeedHiveObject, Future<RssResult>> _feeds =
      <FeedHiveObject, Future<RssResult>>{};
  Map<FeedHiveObject, Future<RssResult>> get feeds => _feeds;
  Future<RssResult>? fetchFeed(FeedHiveObject feed) {
    _feeds[feed] = _api!.getFeedResult(feed);
    notifyListeners();
    return _feeds[feed];
  }

  Future<RssResult>? get currentFeed => _feeds[this._feed]!;
  void fetchCurrentFeed({bool update = false}) {
    if (!_feeds.containsKey(feed) || update) {
      this.fetchFeed(this._feed);
    }
  }
}
