# overseerr (pre-release)

[![Pubdev][pubdev-shield]][pubdev]
![License][license-shield]

Dart library package to facilitate the connection to and from [Overseerr](https://overseerr.dev)'s API.

## Getting Started

In order to use this package, you need to have to fetch your API key from within Overseerr. Please ensure you do not publicly reveal your API key, as it will give any user with access full control of your Overseerr instance. To get started simply import the Overseerr package, and initialize a connection to your instance:

```dart
Overseerr overseerr = Overseerr(host: '<your instance URL>', apiKey: '<your API key>');
```

Once initialized, you can access any of the command handlers to quickly and easily make calls to Overseerr. For most calls that return data, model definitions have been created. Typings have also been created for parameters that have a set, finite list of options.

## Optional Parameters

There are a few optional parameters when initializing a Overseerr instance.

### `headers` | Map<dynamic, String> (default: null)

Allows you to add on any custom headers to each request.

```dart
Overseerr(
    host: '<your instance URL>',
    apiKey: '<your API key>',
    headers: {
        'authorization': '<auth_token>',
    },
);
```

### `followRedirects` | Boolean (default: true)

Allows you to define if the HTTP client should follow redirects.

```dart
Overseerr(
    host: '<your instance URL>',
    apiKey: '<your API key>',
    followRedirects: false, // Disables following redirects
);
```

### `maxRedirects` | Integer (default: 5)

Allows you to define the maximum amount of redirects the HTTP client should follow. If `followRediects` is set to false, then this parameter does nothing.

```dart
Overseerr(
    host: '<your instance URL>',
    apiKey: '<your API key>',
    maxRedirects: 1, // Only follow 1 redirect at most
);
```

## Custom Dio HTTP Client

This package uses [dio](https://pub.dev/packages/dio) to make all HTTP connections. The default constructor will create the HTTP client for you, or you can create your own Dio instance and create a `Overseerr` instance from it using the factory constructor:

```dart
Dio dio = Dio(
    BaseOptions(
        baseUrl: '<your instance URL>',
        queryParameters: {
            'apikey': '<your API key>',
        },
    ),
);
Overseerr overseerr = Overseerr.from(dio);
```

> You must ensure you set the BaseOptions specified above, specifically `baseUrl` and `queryParameters` otherwise the instance will not be able to create a successful connection to your machine.

[license-shield]: https://img.shields.io/github/license/CometTools/Dart-Packages?style=for-the-badge
[pubdev]: https://pub.dev/packages/overseerr/
[pubdev-shield]: https://img.shields.io/pub/v/overseerr.svg?style=for-the-badge
