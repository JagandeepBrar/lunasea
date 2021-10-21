---
description: Setting up Overseerr for webhook-based push notifications
---

# Overseerr

## Preparation

* Read through the main [Notifications](./) page
* Copy your device-based or user-based webhook URL from LunaSea

## Setup the Webhook

Starting with Overseerr v1.24.0, Overseerr now has native support for adding LunaSea as a notification agent!

Open Overseerr's web GUI, open the Settings, enter the "Notifications" tab, and select "LunaSea". Ensure that the agent is enabled, then follow each tab below to setup the webhook:

{% tabs %}
{% tab title="Webhook URL" %}
Paste the full device-based or user-based URL that was copied from LunaSea.

Overseerr currently only supports 1 LunaSea notification agent, which means you can only setup a single user-based or device-based notification.
{% endtab %}

{% tab title="Profile Name" %}
{% hint style="warning" %}
This step is only required if you are _**not**_ using the default LunaSea profile (`default`). LunaSea will assume the default profile when none is supplied.

Correctly setting up this field is critically important to get full deep-linking support.
{% endhint %}

The profile name field should be an **exact match** to the profile that this module instance was added to within LunaSea. Capitalization and punctuation _does_ matter.
{% endtab %}

{% tab title="Notification Types" %}
Select which events should trigger a push notification. The following triggers are supported:

| Trigger                      | Supported? |
| ---------------------------- | :--------: |
| Media Requested              |  **Yes** ✅ |
| Media Automatically Approved |  **Yes** ✅ |
| Media Approved               |  **Yes** ✅ |
| Media Declined               |  **Yes** ✅ |
| Media Available              |  **Yes** ✅ |
| Media Failed                 |  **Yes** ✅ |
{% endtab %}
{% endtabs %}

Once setup, close LunaSea and run the webhook test in Overseerr. You should receive a new notification letting you know that LunaSea is ready to receive Overseerr notifications!

## Example

An example Overseerr webhook can be seen below:

* This is a user-based notification webhook, meaning it will be sent to all devices that are linked to the user ID `1234567890`.
* The webhook is associated with the profile named `My Profile`.

![](<../../.gitbook/assets/overseerr\_notification\_sample\_v2 (1).png>)
