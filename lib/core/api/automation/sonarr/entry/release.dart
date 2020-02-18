class SonarrReleaseEntry {
    String title;
    String guid;
    String quality;
    String protocol;
    String indexer;
    String infoUrl;
    bool approved;
    int releaseWeight;
    int size;
    int indexerId;
    int seeders;
    int leechers;
    double ageHours;
    List<dynamic> rejections;

    SonarrReleaseEntry(
        this.title,
        this.guid,
        this.quality,
        this.protocol,
        this.indexer,
        this.infoUrl,
        this.approved,
        this.releaseWeight,
        this.size,
        this.indexerId,
        this.ageHours,
        this.rejections,
        this.seeders,
        this.leechers,
    );

    bool get isTorrent {
        return protocol == 'torrent';
    }
}