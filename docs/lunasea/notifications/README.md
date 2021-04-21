---
description: How to setup webhook-based push notifications with LunaSea
---

# Notifications

Many of the supported modules have support for webhooks, which we can utilize with the hosted notification relay to get rich, instant notifications with deep-linking support sent as push notifications directly to your devices running LunaSea!

| Module | Supported? | Deep Linking? |
| :--- | :---: | :---: |
| [Lidarr](lidarr.md) | **Yes**  ✅ |  No  ❌ |
| NZBGet |  No  ❌ |  No  ❌ |
| [Overseerr](overseerr.md) | **Yes**  ✅ | No  ❌ |
| [Radarr](radarr.md) | **Yes**  ✅ | **Yes**  ✅ |
| SABnzbd |  No  ❌ | No  ❌ |
| [Sonarr](sonarr.md) | **Yes**  ✅ | **Yes**  ✅ |
| [Tautulli](tautulli.md) | **Yes**  ✅ | **Yes**  ✅ |

{% hint style="info" %}
**Notifications are only available in LunaSea v5.0.0+.**

_Support for additional modules will come over time!_
{% endhint %}

## Notification Types

LunaSea supports two different types of notifications: **User-Based** and **Device-Based**.

### User-Based Notifications

User-based notifications send notifications to all devices that are linked to your LunaSea account. Your device is automatically linked when you register or sign in to your account. This means that any current and future devices that are signed-in to your account will receive notifications automatically.

### Device-Based Notifications

Device-based notifications send notifications to a single, specific device. Device-based notifications do not require a LunaSea account, but require you to register every device as a new webhook in the module.

## Getting Your Webhook URLs

To get the correct webhook URL for each module, simply head to the Settings within LunaSea, then into the "Notifications" page! The buttons on each module card will copy the **full, constructed webhook URL** to receive user-based or device-based notifications for that specific module. Please ensure to copy and use the correct webhook URL for each module, as mixing them up can lead to unexpected results.

{% hint style="warning" %}
**Do not publicly share your user-based or device-based URL!**

Anyone with access to your user or device webhook URLs can send notifications to your account or device.
{% endhint %}

