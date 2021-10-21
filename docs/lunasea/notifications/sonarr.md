---
description: Setting up Sonarr for webhook-based push notifications
---

# Sonarr

## Preparation

* Read through the main [Notifications](./) page
* Copy your device-based or user-based webhook URL from LunaSea

## Setup the Webhook

Open Sonarr's web GUI, open the Settings and enter the "Connect" page. Hit the "+" button to add a new connection, and select "Webhook". Please follow each tab below to setup the webhook:

{% tabs %}
{% tab title="Name" %}
Select any name, for example "LunaSea".
{% endtab %}

{% tab title="Triggers" %}
Select which events should trigger a push notification. The following triggers are supported:

| Trigger                            | Supported? |
| ---------------------------------- | :--------: |
| On Grab                            |  **Yes** ✅ |
| On Import                          |  **Yes** ✅ |
| On Upgrade                         |  **Yes** ✅ |
| On Rename                          |  **Yes** ✅ |
| On Series Delete                   |  **Yes** ✅ |
| On Episode File Delete             |  **Yes** ✅ |
| On Episode File Delete For Upgrade |  **Yes** ✅ |
| On Health Issue                    |  **Yes** ✅ |
| Include Health Warnings            |  **Yes** ✅ |
{% endtab %}

{% tab title="Tags" %}
You can _**optionally**_ select a tag that must be attached to a series for the webhook to get triggered.

This can be useful when working with a large media collection to only receive notifications for content you are actively monitoring.

If you want to receive notifications for all series, leave the tags area empty.
{% endtab %}

{% tab title="URL" %}
Paste the full device-based or user-based URL that was copied from LunaSea.

Each webhook can support a single user-based or device-based webhook URL. Attaching multiple device-based or user-based webhooks to a single Sonarr instance requires setting up multiple webhooks.
{% endtab %}

{% tab title="Method" %}
Keep the method on "**POST**". Changing the method to "**PUT**" will cause the webhooks to fail.
{% endtab %}

{% tab title="Username" %}
{% hint style="warning" %}
This step is only required if you are _**not**_ using the default LunaSea profile (`default`). LunaSea will assume the default profile when none is supplied.

Correctly setting up this field is critically important to get full deep-linking support.
{% endhint %}

The username field should be an **exact match** to the profile that this module instance was added to within LunaSea. Capitalization and punctuation _does_ matter.
{% endtab %}

{% tab title="Password" %}
Leave the password field empty. Setting this field will currently have no effect.
{% endtab %}
{% endtabs %}

Once setup, close LunaSea and run the webhook test in Sonarr. You should receive a new notification letting you know that LunaSea is ready to receive Sonarr notifications!

## Example

An example Sonarr webhook can be seen below:

* No tags are set for this webhook, meaning all series will trigger a notification.
* This is a user-based notification webhook, meaning it will be sent to all devices that are linked to the user ID `1234567890`.
* The webhook is associated with the profile named `My Profile`.

![](<../../.gitbook/assets/sonarr\_notification\_example (1).png>)
