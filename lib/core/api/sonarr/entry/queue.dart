class SonarrQueueEntry {
    int episodeID;
    double size;
    double sizeLeft;
    String status;

    SonarrQueueEntry(
        this.episodeID,
        this.size,
        this.sizeLeft,
        this.status,
    );
}
