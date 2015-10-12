# cordova-plugin-nend

This is a cordova plugin, which provides a way to request AdStir ads natively from JavaScript.
As of today, only banner ad (320x50) is supported.

## Supported Platforms (and SDK version)

* iOS : AdStir SDK for iOS ver2.5.11

## Installation

```
cordova plugin add com.effers.kaky.adstir
```

## Getting Started

```javascript
var options = {};
options.bannerMediaId = "YOUR_MEDIA_ID";
options.bannerSpotId = YOUR_SPOT_ID;
options.bannerIntervalTime = 60; // refresh interval
options.bannerBackgroundColor = "0x6096C3"; // background color for banner view

AdStir.setOptions(options); // If you don't call this function, a key and an id for testing will be used instead.
AdStir.createBanner(); // Being invoked in "deviceready" event might be good.

// ...later
AdStir.showBanner();

// if you wanna hide existing banner
AdStir.hideBanner();
```
