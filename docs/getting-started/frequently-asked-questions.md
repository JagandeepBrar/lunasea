---
description: Frequently asked questions regarding LunaSea
---

# Frequently Asked Questions

## Modules

### How Do I Install a "Module"?

The software, or as I use in LunaSea "_Modules_", are all pieces of software that must be installed on a home computer or server. None of the currently supported software has been developed by myself, so the amount of support I can offer for each module has limitations. LunaSea does not itself have the functionality of that software, it acts as a remote.

### Can You Support "X" Feature/Module?

I take all requests into consideration! If you would like to request a feature there are a few ways I recommend:

* **\(Preferred\)** [**Feedback Board**](https://www.lunasea.app/feedback): The feedback board allows users to create, comment on, and vote on new features and general requests! This is the ideal way to request a new feature, as it allows other users to see active requests, it allows discussions to stay per-request, and the voting system gives me a good indication on the active demand for a feature.
* [**Discord**](https://www.lunasea.app/discord)
* [**Email**](mailto:hello@comet.tools)
* [**Reddit**](https://www.lunasea.app/reddit)

{% hint style="info" %}
I may not have the ability to respond to all requests directly, but please be ensured I do read everything!
{% endhint %}

### Why Isn't Feature/Module "X" Supported Yet?

As mentioned earlier, LunaSea is only developed by one person, and while I try to put as much time into LunaSea as I can, I still do have a family, a career, and I want to enjoy my personal time.

I also want to point out that I don't want to make LunaSea a wide ranging, but no depth application. I want every application to have as full of an implementation as possible, which can mean that new modules will take time to get implemented between one another.

### Torrent Client Support: Is It Coming?

Support for torrent clients is easily the most requested new module, and I definitely see the demand. However, torrent support currently **is not possible** to be added to LunaSea because of the restrictions Apple has put forward. Apple does not allow integration of P2P/torrent clients in any capacity for applications that are hosted on the App Store. This includes a P2P client that runs directly on the device and linking to a P2P client that is running on an external machine.

Torrent support is not completely off the table, and may come in the future! But at the moment, over 90% of the active userbase is using iOS-based devices, and it is hard to justify building a module \(that takes a lot of time\) that the mass majority of the user base would not be able to use.

{% hint style="info" %}
I am actively thinking of methods to get around this limitation, if you have any ideas consider commenting on the torrent client support [feedback board request](https://feedback.lunasea.app/features/torrent-clients-support).
{% endhint %}

## Development

### Who Makes LunaSea?

Only one person, me! Hi, my name is Jagandeep Brar, and I am a software engineer from Canada. I am currently the main and only developer on LunaSea, but I encourage anyone who is interested and wants to contribute to the project to make a pull request on GitHub!

### What is LunaSea Developed In?

LunaSea is developed using Google's hybrid framework, [Flutter](https://flutter.dev), which uses [Dart](https://dart.dev) as its core language. Using Flutter allows an indie developer like myself to build cross-platform applications more easily, as it is one single codebase that allows me to build across both mobile platforms, and in the future the potential of a web interface and desktop applications!

### How is LunaSea Free?

LunaSea started off as \(and still is\) a passion project, fuelled by my love for data hoarding and collecting. It was open-sourced soon after it's initial launch to allow LunaSea to get into the hands of as many users as possible, and to give back to the community where there is a lack of open-source, high quality mobile applications.

### Are You Ever Going To Charge Money/Insert Ads?

_**No.**_

The only possible reason that LunaSea will ever have any kind of payment model is if features are introduced that cost me recurring charges that are too large to bear. Any and all features that do not incur me a charge will be free, and even any features that would cost me money will become open-source, which offers everyone the ability to have a completely free experience in LunaSea.

### Can You Put LunaSea on a Third-Party App Store on iOS?

At the moment, this will not happen. Apple's developer terms of service dictates that providing the application through unofficial channels or illicit App Stores is against their terms and is grounds to have your developer account terminated. Since the Apple developer account is tied to my personal information, I do not want to get completely blocked from creating iOS/MacOS applications in the future, and will not be taking that risk.

However, since LunaSea is open-source, there are prebuilt IPAs available through GitHub for every release and will continue to be provided for every release.

### How Do I Join the Beta?

* [**TestFlight \(iOS\)**](https://www.lunasea.app/testflight): For iOS we must use Apple's TestFlight program, which requires you to download the TestFlight application to your device and click the link to join the beta. Please note that in-app purchases are not actually charged while running TestFlight releases, so if you want to donate within the application you must re-download the application from the App Store.
* [**Play Store \(Android\)**](https://www.lunasea.app/playstore): On the Play Store page there should be an option to join the beta directly! From thereon out you will get beta releases.

## Bugs & Feedback

### I Found a Bug! How Do I Let You Know?

I tried to make it as stable as possible, but bugs obviously will always be there \(when you fix a bug, you make 5 more...\). If you do run into a bug \(especially a fatal/crashing bug\), **please also attach the logs from the application into the report. Logs can be exported from the settings as a text file**.

* **\(Preferred\)** [**GitHub Issues**](https://github.com/CometTools/LunaSea/issues): The best place to alert me of new issues is directly on the GitHub page. Please try to follow the template for bug reports, but again I am not overly strict and a good explanation of the issue will suffice \(this may change in the future if it gets increasingly hard to manage\).
* [**Discord**](https://www.lunasea.app/discord)
* [**Email**](mailto:hello@comet.tools)
* [**Reddit**](https://www.lunasea.app/reddit)

### How Can I Request a New Feature?

I consider all feedback and actively try to integrate new features that are requested by the community, big or small! You have a few ways to request new features for LunaSea:

* **\(Preferred\)** [**Feedback & Feature Requests Board**](https://feedback.lunasea.app): A feedback board has been setup to allow all users to submit and vote on new requests. This is the preferred way of requesting a new feature, as it allows other users to show interest in your request which is all taken into consideration when choosing what to develop next!
* [**Discord**](https://www.lunasea.app/discord)
* [**Reddit**](https://www.lunasea.app/reddit)

## Support

### Why Don't The Settings Explain Much?

I understand that the settings section could definitely use better documentation and linking, but this ambiguity and sparse documentation directly within LunaSea is by design.

LunaSea took quite a runaround to initially get on the App Store because of its relationship with how you acquire _Linux ISOs_. After successfully getting it on the App Store, I want to avoid adding anything to LunaSea that would potentially get it revoked.

### "X" Won't Connect, Help!

The initial setup can either be incredibly easy or make you want to pull your hair out, I get that and that's what the community is here for! Please feel free to send a message to any of the listed methods to get support where either I or an awesome user in the community will surely come to help you out:

* [**Discord**](https://www.lunasea.app/discord)
* [**Email**](mailto:hello@comet.tools)
* [**Reddit**](https://www.lunasea.app/reddit)

A few quick tips on common problems:

* `localhost` and `0.0.0.0` are internal hostnames that means "this computer". They cannot and should not be used as the host, but is commonly used because users mainly access the service from the computer running it. In order for LunaSea to connect, you must find the local IP of your computer \(most common home networking configurations have it start with `192.168.0.x` or `192.168.1.x`\)
* Ensure you match the right API key to the right service. I know this seems like an obvious thing, but you'd be surprised how easy it is to mix up 3-4 API keys when you're going back and forth copying and pasting!
* For the -rr services, ensure the binding address in the advanced general settings is not set to `127.0.0.1` or `localhost`, but instead set to either `0.0.0.0`, `*`, or the local IP for the computer/server.
* Similarly for the clients, ensure that the host is set to `0.0.0.0`, or the local IP.
* As noted in the host prompt, you must add either `http://` or `https://` before the IP or domain. LunaSea does not make any assumptions on the protocol to use \(http or https\).
* Do not use `3xx` redirecting webpages. This is not supported for POST and PUT requests \(sending data back to the module\) and can cause many headaches, so ideally you should be pointing directly to the module on your network.
* \(**Windows Only**\): For a lot of software to correctly bind to your network, you need to ensure that you run the software as administrator. This is specifically very important for the -arrs, which will only bind to your host machine if you do not run it as administrator. 

### How Can I Access My Services Remotely?

While this is outside of the scope of this project, I can try to point you in the right direction!

* **Reverse Proxy**: A reverse proxy allows you to open 1 or 2 ports on your network \(typically 443 for SSL/https connections and 80 for http connections\). Using a reverse proxy also allows you to attach a domain name to your IP and generate a free SSL certificate for https \(hint, LetsEncrypt\). Some common options for reverse proxies are NGINX Proxy Manager, Traefik, NGINX, and Apache.
* **VPN Tunnelling**: Another option is to create a VPN tunnel back to your home network, which would allow you to access your services as if you are on your home network. Tools like WireGuard and OpenVPN are perfect for this use case. _This is technically the most secure method, but a bit less convenient than using a reverse proxy._
* **\(NOT RECOMMENDED\) Direct Port Forwarding**: Another option is directly forward the ports of the services on your router and access the services via `<External IP>:<Port>`. The reason this is not recommend is because all of the traffic is sent unencrypted \(you can use self-signed certificates, but this causes more headaches related to certificate authorities\), and the more ports that are open on your network the less secure it is.

### I Want to Complain! Where Can I Complain?

Sorry that LunaSea is not meeting your expectations, feel free to post criticisms or complaints to any of the social platforms or directly [email me](mailto:hello@comet.tools). I hope that I can remedy your complaints, all I ask is that you do not be abusive or disrespectful to myself or others in the community.

I also kindly request that before you submit a 1-star App Store/Play Store review that you consider contacting me directly with your complaints. 1-star reviews can really hurt a smaller application's rating since we do not typically get lots of reviews.

