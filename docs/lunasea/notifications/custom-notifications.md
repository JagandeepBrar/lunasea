---
description: Creating a custom notification for webhook-based push notifications
---

# Custom Notifications

## Preparation

{% hint style="warning" %}
Custom notifications are considered an advanced feature, and requires basic knowledge of JSON syntax and creating your own scripts/tools to handle sending the payloads.
{% endhint %}

* Read through the main [Notifications](./) page
* Copy any module's device-based or user-based webhook URL from LunaSea

You will need to slightly modify the webhook URL you have copied from any of the modules. Simply replace the name of the module within the webhook URL to `custom` and you're good to go!

Alternatively, you can copy the content of the URL after the last slash \(after `device/` or `user/`\) to obtain your Firebase device or user identifier.

## Endpoints

Custom notifications are supported by both device-based and user-based notifications, with full endpoint details below:

{% api-method method="post" host="https://notify.lunasea.app" path="/v1/custom/device/:device\_id" %}
{% api-method-summary %}
Device-Based
{% endapi-method-summary %}

{% api-method-description %}
Send a custom notification using a device token to a single device running LunaSea.
{% endapi-method-description %}

{% api-method-spec %}
{% api-method-request %}
{% api-method-path-parameters %}
{% api-method-parameter name="device\_id" type="string" required=true %}
The Firebase device identifier
{% endapi-method-parameter %}
{% endapi-method-path-parameters %}

{% api-method-body-parameters %}
{% api-method-parameter name="title" type="string" required=true %}
The notification's title.
{% endapi-method-parameter %}

{% api-method-parameter name="body" type="string" required=true %}
The notification's body content.
{% endapi-method-parameter %}

{% api-method-parameter name="image" type="string" required=false %}
A **publicly accessible** URL to an image that will be attached to the notification.
{% endapi-method-parameter %}
{% endapi-method-body-parameters %}
{% endapi-method-request %}

{% api-method-response %}
{% api-method-response-example httpCode=200 %}
{% api-method-response-example-description %}
Acknowledgement that the webhook has been received.  
  
_**This does not necessarily mean that the notification was successful**_, just that the relay has received the request and passed initial validation.
{% endapi-method-response-example-description %}

```javascript
{
    "status": "OK"
}
```
{% endapi-method-response-example %}

{% api-method-response-example httpCode=500 %}
{% api-method-response-example-description %}
Will be returned when any other error occurs when trying to send the notification to your device.
{% endapi-method-response-example-description %}

```javascript
{
    "status": "Internal Server Error"
}
```
{% endapi-method-response-example %}
{% endapi-method-response %}
{% endapi-method-spec %}
{% endapi-method %}



{% api-method method="post" host="https://notify.lunasea.app" path="/v1/custom/user/:user\_id" %}
{% api-method-summary %}
User-Based
{% endapi-method-summary %}

{% api-method-description %}
Send a custom notification using a user token to all devices signed into that LunaSea account.
{% endapi-method-description %}

{% api-method-spec %}
{% api-method-request %}
{% api-method-path-parameters %}
{% api-method-parameter name="user\_id" type="string" required=true %}
The Firebase user identifier
{% endapi-method-parameter %}
{% endapi-method-path-parameters %}

{% api-method-body-parameters %}
{% api-method-parameter name="title" type="string" required=true %}
The notification's title.
{% endapi-method-parameter %}

{% api-method-parameter name="body" type="string" required=true %}
The notification's body content.
{% endapi-method-parameter %}

{% api-method-parameter name="image" type="string" required=false %}
A **publicly accessible** URL to an image that will be attached to the notification.
{% endapi-method-parameter %}
{% endapi-method-body-parameters %}
{% endapi-method-request %}

{% api-method-response %}
{% api-method-response-example httpCode=200 %}
{% api-method-response-example-description %}
Acknowledgement that the webhook has been received.  
  
_**This does not necessarily mean that the notification was successful**_, just that the relay has received the request and passed initial validation.
{% endapi-method-response-example-description %}

```javascript
{
    "status": "OK"
}
```
{% endapi-method-response-example %}

{% api-method-response-example httpCode=400 %}
{% api-method-response-example-description %}
Will be returned when no devices are found for a given user. Opening LunaSea on your device\(s\) should register the device automatically.
{% endapi-method-response-example-description %}

```javascript
{
    "status": "No devices found"
}
```
{% endapi-method-response-example %}

{% api-method-response-example httpCode=404 %}
{% api-method-response-example-description %}
Will be returned when a user with the given identifier can not be found in LunaSea's authentication table.
{% endapi-method-response-example-description %}

```javascript
{
    "status": "Invalid User ID"
}
```
{% endapi-method-response-example %}

{% api-method-response-example httpCode=500 %}
{% api-method-response-example-description %}
Will be returned when any other error occurs when trying to send the notification to the devices.
{% endapi-method-response-example-description %}

```javascript
{
    "status": "Internal Server Error"
}
```
{% endapi-method-response-example %}
{% endapi-method-response %}
{% endapi-method-spec %}
{% endapi-method %}

## Basic Troubleshooting

* Ensure that the required `title` parameter is a string type.
  * If the type is not a string, the notification will fail.
  * Sending no value or a null value will result in the title "Unknown Title" being used.
* Ensure that the required `body` parameter is a string type. 
  * If the type is not a string, the notification will fail.
  * Sending no value or a null value will result in the body "Unknown Content" being used.
* If sending an image, ensure that the content is a valid URL.
  * If the content is not a valid URL, the notification will fail.
  * The URL must contain the protocol, `http://` or `https://`.
  * The URL must be a direct link to the image and does not redirect.
  * The URL must be publicly accessible, not requiring any authentication to access.
* If sending an image, the image must be a supported image type.
  * Supported types include JPGs, PNGs, and animated GIFs.

