import 'package:lunasea/api/rss/models/rss_feed.dart';
import 'package:lunasea/api/rss/models/rss_feed_options.dart';
import 'package:lunasea/api/rss/rss.dart';
import 'package:lunasea/database/models/rss.dart';
import 'package:lunasea/state/state.dart';

class RssState extends LunaModuleState {
  @override
  void reset() {}

  final RssAPI _api = RssAPI.create();

  late LunaRss _feed;

  LunaRss get feed => _feed;

  set feed(LunaRss feed) {
    _feed = feed;
    notifyListeners();
  }

  final Map<LunaRss, Future<RssFeed>> _feeds = <LunaRss, Future<RssFeed>>{};

  Map<LunaRss, Future<RssFeed>> get feeds => _feeds;

  final Map<LunaRss, RssFeed> _feedResults = <LunaRss, RssFeed>{};
  Map<LunaRss, RssFeed> get feedResults => _feedResults;

  Future<RssFeed>? fetchFeed(LunaRss feed) {
    _feeds[feed] = _api!.getFeedResult(feed.url,
        options: RssFeedOptions(headers: feed.headers));
    _feeds[feed]!.then((value) => {
          feed.applyFilter(value),
          _feedResults[feed] = value,
          feed.syncDate = value.syncDate,
          feed.save()
        });
    notifyListeners();
    return _feeds[feed];
  }

  Future<RssFeed>? get currentFeed => _feeds[this._feed]!;
  RssFeed? get currentFeedResult => _feedResults[this._feed]!;

  void fetchCurrentFeed({bool update = false}) {
    if (!_feedResults.containsKey(feed) || update) {
      this.fetchFeed(this._feed);
    }
  }
}
