---
description: How to setup webhook-based push notifications with LunaSea
---

# Notifications

## Getting Started

Many of the supported modules have support for webhooks, which we can utilize with the hosted notification relay to get rich, instant notifications with deep-linking support sent as push notifications directly to your devices running LunaSea!

| Module | Supported? |
| :---: | :---: |
| [Lidarr](lidarr.md) | **Yes**  ✅ |
| NZBGet |  No  ❌ |
| [Overseerr](overseerr.md) | **Yes**  ✅ |
| [Radarr](radarr.md) | **Yes**  ✅ |
| SABnzbd |  No  ❌ |
| [Sonarr](sonarr.md) | **Yes**  ✅ |
| [Tautulli](tautulli.md) | **Yes**  ✅ |
| [Overseerr](overseerr.md) | **Yes**  ✅ |

{% hint style="info" %}
Support for additional modules will come over time!
{% endhint %}

## Notification Types

LunaSea supports two different types of notifications: **User-Based** and **Device-Based**.

### User-Based Notifications

User-based notifications send notifications to all devices that are registed to your LunaSea account. Your device is automatically registered when you register or sign in to your account. This means that any device that is currently signed-in to your account will receive notifications automatically.

### Device-Based Notifications

Device-based notifications send notifications to a single, specific device. Device-based notifications do not require a LunaSea account, but require you to register every device as a new webhook in the module.

## Getting Your User or Device Token



