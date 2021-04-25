---
description: How to configure and add newznab indexers to LunaSea
---

# Newznab Search

LunaSea supports any indexer that supports the [Newznab API specification](https://newznab.readthedocs.io/en/latest/). Most modern indexers \(including NZBHydra2\) are fully compliant with this specification, and compatible with LunaSea.

{% hint style="warning" %}
LunaSea supports infinite scrolling of search and category results, which can result in multiple API hits. It is only recommended to add indexers with high API limits to prevent quickly reaching your API limit. 
{% endhint %}

## Adding an Indexer

### Display Name

Your personal display name for the indexer. The display name can be anything, but indexers are displayed in **alphabetical order** and the display name you choose will determine where it lands in your list of indexers.

### Indexer API Host

This is the **API host** from the indexer. Do not confused this with the homepage for the indexer! Some indexers use the same URL, but many indexers will use a separate URL \(commonly [https://api.indexer.com](https://api.indexer.com)\).

If your indexer can and has been added to Lidarr, Radarr, or Sonarr, you can simply copy the URL from the indexer configuration page within their settings.

{% hint style="info" %}
A list of popular indexers and their API hosts is available at the end of this page.
{% endhint %}

### Indexer API Key

Your API key that is typically available in the dashboard of the indexer or received by email when originally signing up for the indexer.

If you are unable to find your API key, consider contacting the administrators of the indexer to get help! The LunaSea developer and community users can try to help, but we cannot guarantee support if nobody has access to said indexer.

### Custom Headers

Custom headers allows users to attach custom request headers to each API call that is made. This is typically an advanced feature, and is not necessary for most \(if not all\) public indexers.

## Indexer API Hosts

| Indexer | Host |
| :--- | ---: |
| **DOGnzb** | [https://api.dognzb.cr](https://api.dognzb.cr) |
| **DrunkenSlug** | [https://api.drunkenslug.com](https://api.drunkenslug.com) |
| **NZB.su** | [https://api.nzb.su](https://api.nzb.su) |
| **NZBCat** | [https://nzb.cat](https://nzb.cat) |
| **NZBFinder** | [https://nzbfinder.ws](https://nzbfinder.ws) |
| **NZBGeek** | [https://api.nzbgeek.info](https://api.nzbgeek.info) |
| **NZBPlanet** | [https://api.nzbplanet.net](https://api.nzbplanet.net) |
| **omgwtfnzbs** | [https://api.omgwtfnzbs.me](https://api.omgwtfnzbs.me) |
| **OZnzb** | [https://api.oznzb.com](https://api.oznzb.com) |
| **SimplyNZBs** | [https://simplynzbs.com](https://simplynzbs.com) |
| **Usenet Crawler** | [https://www.usenet-crawler.com](https://www.usenet-crawler.com) |

{% hint style="info" %}
_**Want to add additional indexers?**_

Contact me through GitHub, Discord, or Reddit!
{% endhint %}

