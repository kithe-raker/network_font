# network_font

Help you easily uses font from network 💪

Also this package is inspired by [google_fonts](https://pub.dev/packages/google_fonts) and [cached_network_image](https://pub.dev/packages/cached_network_image)

## Getting Started

![](https://github.com/kithe-raker/network_font/blob/master/docs/example.gif)

This `network_font` package will help you use your custom font from network, so you don't have to store in `asset` folder in the project directory.

## How it work?

**Basically** just like [cached_network_image](https://pub.dev/packages/cached_network_image). If your font file from network isn't exists in user's cache directory or `expired`, this package'll download and store your font to user's cache directory.

![](https://github.com/kithe-raker/network_font/blob/master/docs/WorkFlow.png)

## How to use?

1️⃣ First step is to import `network_font`

```dart
import 'package:network_font/network_font.dart';
```

2️⃣ Second step is to declare you network font's data

```dart
final NetworkFont _networkFont = NetworkFont('family', url:'font_url');
```

3️⃣ Last step is to use `network_font`, there are 3 ways

1. NetworkFontText Widget

    ```dart
    NetworkFontText(
        'NetworkFontText Widget',
        font: _networkFont,
        style: TextStyle(fontSize: 18),
    ),
    ```

2. NetworkFont's style

    ```dart
    Text(
        'NetworkFont Style',
        style: _networkFont.style(fontSize: 18),
    ),
    ```

3. TextStyle *network_font* extension

    ```dart
    Text(
        'NetworkFont Extension',
        style: TextStyle(fontSize: 18).network(_networkFont),
    ),
    ```

    However there are no different in technical, only code style that's different 🏄‍♂️

## Other function

### `initFont`

<!-- markdownlint-disable code-block-style -->

    allow you to init font from network to your application.

<!-- markdownlint-restore -->

This function'll read font data from cache.
But If font data **doesn't exist** or **expired**, this function'll download from `fontData.url` and store it to user's cache directory.

Also This operation has unnecessary initialization checker to,
so call `initFont` on same `fontData` multiple-time will not repeated.

```dart
final NetworkFont _networkFont = NetworkFont('family', url:'font_url');

FontFunction.instance.initFont(_networkFont)
```

***Note: Currently only support OpenType (OTF) and TrueType (TTF) fonts.***

### `setExpiredDuration`

<!-- markdownlint-disable code-block-style -->

    Set expired duration of cached font.

<!-- markdownlint-restore -->

Default is 30 days

```dart
final DateTime _oneWeek = const Duration(days: 7);

FontFunction.instance.setExpiredDuration(_oneWeek)
```

***Note: You should call this before `initFont`***

## Join flutter community

🌎 [Global FlutterDev Discord](https://discord.gg/rflutterdev)

🇹🇭 [Thailand Flutter Developer Group](https://www.facebook.com/groups/1330912973657674)

🇹🇭 [FlutterDevTH Discord](https://discord.gg/bU9F9c7kG9)
