---
description: Setting up Lidarr for webhook-based push notifications
---

# Lidarr

## Preparation

* Read through the main [Notifications](./) page
* Copy your device-based or user-based webhook URL from LunaSea

## Setup the Webhook

Open Lidarr's web GUI, open the Settings and enter the "Connect" page. Hit the "+" button to add a new connection, and select "Webhook".

{% tabs %}
{% tab title="Name" %}
Select any name, for example "LunaSea"
{% endtab %}

{% tab title="Notification Triggers" %}
Select which events should trigger a push notification. The following triggers are supported:

| Trigger | Supported? |
| :--- | :---: |
| On Grab | **Yes**  ✅ |
| On Release Import | **Yes**  ✅ |
| On Upgrade | **Yes**  ✅ |
| On Download Failure |  No  ❌ |
| On Import Failure |  No  ❌ |
| On Rename | **Yes**  ✅ |
| On Track Retag | **Yes**  ✅ |
| On Health Issue |  No  ❌ |
{% endtab %}

{% tab title="Tags" %}
You can _**optionally**_ select a tag that must be attached to an artist for the webhook to get triggered.

This can be useful when working with a large media collection to only receive notifications for content you are actively monitoring.

If you want to receive notifications for all artists, leave the tags area empty.
{% endtab %}

{% tab title="URL" %}
Paste the full, copied device-based or user-based URL that was copied from LunaSea.

Each webhook can support a single user-based or device-based webhook URL. Attaching multiple device-based or user-based webhooks to a single Lidarr instance requires setting up multiple webhooks.
{% endtab %}

{% tab title="Method" %}
Keep the method on "**POST**". Changing the method to "**PUT**" will cause the webhooks to fail.
{% endtab %}

{% tab title="Username" %}

{% endtab %}

{% tab title="Password" %}

{% endtab %}
{% endtabs %}



