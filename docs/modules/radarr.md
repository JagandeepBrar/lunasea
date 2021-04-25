---
description: How to configure and add Radarr to LunaSea
---

# Radarr

Adding your Radarr instance to LunaSea only requires a few steps to get going!

{% hint style="warning" %}
This documentation only covers adding Radarr to LunaSea via local network \(LAN\) connections, and does not cover exposing Lidarr externally and connecting remotely.
{% endhint %}

## Preparing Radarr

### Find Your Local Network IP Address

Finding your local network IP address of the machine running Radarr is the first step to get setup. To find your local IP address, please look at the following guides:

* \*\*\*\*[**macOS**](https://osxdaily.com/2010/11/21/find-ip-address-mac/)\*\*\*\*
* \*\*\*\*[**Ubuntu**](https://ubuntuhandbook.org/index.php/2020/07/find-ip-address-ubuntu-20-04/)\*\*\*\*
* \*\*\*\*[**Windows**](https://support.microsoft.com/en-us/windows/find-your-ip-address-f21a9bbc-c582-55cd-35e0-73431160a1b9)

If you are running a different operating system, you can use any search engine to look up "Find local IP address on &lt;your operating system&gt;" to typically find tons of guides for any platform.

{% hint style="info" %}
It is recommended to set your host machine's IP address to be statically assigned instead of dynamic/DHCP. This ensures that the IP address will not change through machine or network reboots.
{% endhint %}

### Check What Port is Being Used

If using the default installation, Radarr runs on port **7878**. In most cases, this port is not changed and does not need to be changed.

The simplest way to check is to go to Radarr's web GUI, go to Settings -&gt; General and note the value entered into "Port Number".

### Ensure Radarr is Accessible Across Your Network

To ensure that Radarr is accessible across your local network, check the following:

* In Radarr's web GUI, go to Settings -&gt; General and enable advanced settings. Ensure that the "Bind Address" is set to `*`, as this makes Radarr bind to all network interfaces on the host machine.
* Check any enabled firewalls to confirm that the port running Radarr is not being blocked.
* **\(Windows\)**: Ensure that Radarr has been run as administrator at least once.

### Check If You Are Using a URL Base

In Radarr's web GUI, go to Settings -&gt; General and check the value of "URL Base". If you have nothing set, you can move on. If you do have a value set, please remember the set value as it will be necessary when setting the host within LunaSea.

## Connecting in LunaSea

### Host

The host is a combination of multiple values found above:

* The local IP address
* The port
* If being used, the URL base

Combine all the values into the following format: `<IP address>:<port>/<URL base>`

For example, if Radarr is running on port 7878 on a machine that has the IP address 192.168.100.100, the host is: `http://192.168.100.100:7878`.

### API Key

The API key is copied from Radarr's web GUI, by going to Settings -&gt; General and finding the API key value.

### Custom Headers

Custom headers allows users to attach custom request headers to each API call that is made. This is typically an advanced feature, and is not necessary in most network configurations.

