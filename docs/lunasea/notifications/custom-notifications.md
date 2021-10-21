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

Alternatively, you can copy the content of the URL after the last slash (after `device/` or `user/`) to obtain your Firebase device or user identifier.

## Endpoints

Custom notifications are supported by both device-based and user-based notifications, with full endpoint details below:

{% swagger baseUrl="https://notify.lunasea.app" path="/v1/custom/device/:device:id" method="post" summary="Device-Based" %}
{% swagger-description %}
Send a custom notification using a device token to a single device running LunaSea.
{% endswagger-description %}

{% swagger-parameter name="device:id" type="string" in="path" %}
The Firebase device identifier
{% endswagger-parameter %}

{% swagger-parameter name="title" type="string" in="body" %}
The notification's title.
{% endswagger-parameter %}

{% swagger-parameter name="body" type="string" in="body" %}
The notification's body content.
{% endswagger-parameter %}

{% swagger-parameter name="image" type="string" in="body" %}
A 

**publicly accessible**

 URL to an image that will be attached to the notification.
{% endswagger-parameter %}

{% swagger-response status="200" description="" %}
```javascript
{
    "status": "OK"
}
```
{% endswagger-response %}

{% swagger-response status="500" description="" %}
```javascript
{
    "status": "Internal Server Error"
}
```
{% endswagger-response %}
{% endswagger %}

{% swagger baseUrl="https://notify.lunasea.app" path="/v1/custom/user/:user:id" method="post" summary="User-Based" %}
{% swagger-description %}
Send a custom notification using a user token to all devices signed into that LunaSea account.
{% endswagger-description %}

{% swagger-parameter name="user:id" type="string" in="path" %}
The Firebase user identifier
{% endswagger-parameter %}

{% swagger-parameter name="title" type="string" in="body" %}
The notification's title.
{% endswagger-parameter %}

{% swagger-parameter name="body" type="string" in="body" %}
The notification's body content.
{% endswagger-parameter %}

{% swagger-parameter name="image" type="string" in="body" %}
A 

**publicly accessible**

 URL to an image that will be attached to the notification.
{% endswagger-parameter %}

{% swagger-response status="200" description="" %}
```javascript
{
    "status": "OK"
}
```
{% endswagger-response %}

{% swagger-response status="400" description="" %}
```javascript
{
    "status": "No devices found"
}
```
{% endswagger-response %}

{% swagger-response status="404" description="" %}
```javascript
{
    "status": "Invalid User ID"
}
```
{% endswagger-response %}

{% swagger-response status="500" description="" %}
```javascript
{
    "status": "Internal Server Error"
}
```
{% endswagger-response %}
{% endswagger %}

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
