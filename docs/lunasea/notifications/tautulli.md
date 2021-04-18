---
description: Setting up Tautulli for webhook-based push notifications
---

# Tautulli

## Preparation

* Read through the main [Notifications](./) page
* Copy your device-based or user-based webhook URL from LunaSea

## Setup the Webhook

Open Tautulli's web GUI, open the Settings and enter the "Notification Agents" page. Hit the "Add a new notification agent" button to add a new agent, and select "Webhook". Please follow each tab below to setup the webhook:

{% tabs %}
{% tab title="Configuration" %}
### **Webhook URL**

Paste the full device-based or user-based URL that was copied from LunaSea.

Each webhook can support a single user-based or device-based webhook URL. Attaching multiple device-based or user-based webhooks to a single Sonarr instance requires setting up multiple webhooks.

### Webhook Method

Keep the method on "**POST**". Changing the method to "**PUT**" will cause the webhooks to fail.

### Description

An _optional_ description for the webhook to help identify the webhook in the list of notification agents.
{% endtab %}

{% tab title="Triggers" %}
Select which events should trigger a push notification. The following triggers are supported:

| Trigger | Supported? |
| :--- | :---: |
| Playback Start | **Yes**  ✅ |
| Playback Stop | **Yes**  ✅ |
| Playback Pause | **Yes**  ✅ |
| Playback Resume | **Yes**  ✅ |
| Playback Error | **Yes**  ✅ |
| Transcode Decision Change | **Yes**  ✅ |
| Watched | **Yes**  ✅ |
| Buffer Warning | **Yes**  ✅ |
| User Concurrent Streams | **Yes**  ✅ |
| User New Device | **Yes**  ✅ |
| Recently Added | **Yes**  ✅ |
| Plex Server Down | **Yes**  ✅ |
| Plex Server Back Up | **Yes**  ✅ |
| Plex Remote Access Down | **Yes**  ✅ |
| Plex Remote Access Back Up | **Yes**  ✅ |
| Plex Update Available | **Yes**  ✅ |
| Tautulli Update Available | **Yes**  ✅ |
| Tautulli Database Corruption | **Yes**  ✅ |
{% endtab %}

{% tab title="Conditions" %}
You can _**optionally**_ add conditions that must be met for the webhook notifications to trigger.

You can set as many conditions as you like, and can combine different conditions for different triggers by adding separate webhooks to Tautulli. 
{% endtab %}

{% tab title="Data" %}
The following two sections apply to **every** trigger, and needs to be completed for each trigger being used. If the trigger is not being used in this notification agent, you do not need to fill in the data.

### JSON Headers

{% hint style="warning" %}
This step is only required if you are _**not**_ using the default LunaSea profile \(`default`\). LunaSea will assume the default profile when none is supplied.

Correctly setting up this field is critically important to get full deep-linking support.
{% endhint %}

To attach your profile to the webhook, we need to manually create the JSON headers that will include the authorization header. This header will only contain the name of your profile, and no private information.

To create the authorization header:

1. Go to DebugBear's [Basic Auth Header Generator](https://www.debugbear.com/basic-auth-header-generator).
2. The username field should be an **exact match** to the profile that this module instance was added to within LunaSea. Capitalization and punctuation _does_ matter.
3. The password field should be kept empty.
4. Copy the generated authorization header **after** `Authorization:` .
5. Get the [template JSON headers](https://github.com/CometTools/LunaSea-Notification-Relay/blob/master/data/tautulli/_header.jsonc) and follow the instructions to insert the generated header into the template.
6. Copy and paste the template \(ensure you copy below the line specified in the file\) into each trigger's JSON headers area that is used within this webhook.

### JSON Data

Each trigger has a specific JSON data payload that must be included in the request.

1. Go to the list of JSON data payload templates [here](https://github.com/CometTools/LunaSea-Notification-Relay/tree/master/data/tautulli).
2. Open the template that matches the trigger being added.
3. Copy the JSON data and paste it into the JSON data section for the trigger \(You can hit the "Raw" button on GitHub to easily copy the entire JSON payload\).
{% endtab %}
{% endtabs %}

## Advanced: Custom Notification Body

{% hint style="info" %}
Each notification trigger has a default notification body that matches the built-in Discord notification agent messages. This step is _**optional**_ and is not required.
{% endhint %}

Each notification trigger has support for having a custom notification body for that trigger. You must still use the template JSON data as explained above, but you can enter in your custom message into the empty `message` key in the JSON payload. You **must not** delete the `event_type` key that is in the template, else the notification will fail.

Use the notification parameters as explained at the top of the "Data" tab in the dialog within Tautulli to build your customized notification body.

