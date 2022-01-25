---
description: On-Device Logging
---

# Logs

LunaSea includes an on-device logging system that helps debug crashes, issues, and support requests. LunaSea stores 3 different levels of logs:

1. **Warning**: Warning logs are non-crashing and non-critical errors that have occurred on the device. Warning logs would occur when failing to load an image, passing an incorrect encryption key when trying to restore a backup, etc.
2. **Error**: Error logs are non-crashing but critical errors that have occurred on the device. Error logs would occur on network errors, connection issues, errors returned from the module, etc.
3. **Fatal**: Fatal logs are crashing errors or unhandled errors that have occurred on the device. Fatal logs would occur when LunaSea fails to complete the boot process, fails to render the UI, etc.

### Viewing Log History

When a _handled_ error occurs, a toast notification will appear that allows you to directly view the error that just occurred.

LunaSea also stores a list of the **last 100 logs** that have occurred on the device. To access the history of logs, simply go to the Settings, enter the "System" page and tap "Logs".

{% hint style="info" %}
The log database size is checked on startup, so all logs that have occurred in the active session will remain in the log history until LunaSea is closed and reopened.
{% endhint %}

### Exporting Logs

LunaSea offers the ability to export your logs into a JSON file, which can be easily sent to the developer to help debug the problems. The exported logs also include additional information, including the code-execution stack trace to see exactly where in the code the error occurred.

To export your logs, simply go to the Settings, enter the "System" page and tap "Logs". On this page, tap the "Export" button available at the bottom. After a short amount of time, a system-level sharesheet should appear with the ability to share or save the exported logs to your device.

{% hint style="warning" %}
Because the exported logs contain code-execution stack traces, **the logs may unintentionally contain private information**.

Please ensure you do not publicly share your exported logs (or before sharing, manually scrub the exported logs). Only share the logs to trusted parties through private channels such as email or direct messages.
{% endhint %}

### Clearing Logs

LunaSea offers the ability to clear all recorded logs from your device. While an available option, it is not recommended to clear your logs often as LunaSea will internally ensure the log database does not grow to an obscenely large size.

To clear your logs, simply go to the Settings, enter the "System" page and tap "Logs". On this page, tap the "Clear" button available at the bottom.
