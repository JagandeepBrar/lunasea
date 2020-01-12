class NZBGetQueueEntry {
    int id;
    String name;
    String status;

    NZBGetQueueEntry(
        this.id,
        this.name,
        this.status,
    );

    bool get paused {
        return status == 'PAUSED';
    }
}
