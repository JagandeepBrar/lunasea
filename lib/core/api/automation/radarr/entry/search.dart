class RadarrSearchEntry {
    String title;
    String titleSlug;
    String overview;
    int year;
    int tmdbId;
    List<dynamic> images;

    RadarrSearchEntry(
        this.title,
        this.titleSlug,
        this.overview,
        this.year,
        this.tmdbId,
        this.images,
    );

    String get bannerURI {
        for(var image in images) {
            if(image['coverType'] == 'banner') {
                return image['url'];
            }
        }
        return '';
    }

    String get fanartURI {
        for(var image in images) {
            if(image['coverType'] == 'fanart') {
                return image['url'];
            }
        }
        return '';
    }

    String get posterURI {
        for(var image in images) {
            if(image['coverType'] == 'poster') {
                return image['url'];
            }
        }
        return '';
    }
}