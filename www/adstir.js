
var adStirExport = {};
var options = {};

var defaultOptions = {
  bannerMediaId: "MEDIA-be5613e3",
  bannerSpotId: 1,
  bannerWidth: 320,
  bannerHeight: 50,
  bannerIntervalTime: 60,
  bannerBackgroundColor: "0xFFFFFF",
  interstitialMediaId: "MEDIA-be5613e3",
  interstitialSpotId: 2
};

adStirExport.setOptions = function(args) {
    options = args;
};

adStirExport.createBanner = function(successCallback, failureCallback) {
  cordova.exec(
    successCallback,
    failureCallback,
    'AdStir',
    'createBanner',
    [sendOptions()]
  );
};

adStirExport.showBanner = function(successCallback, failureCallback) {
  cordova.exec(
    successCallback,
    failureCallback,
    'AdStir',
    'showBanner',
    [sendOptions()]
  );
};

adStirExport.hideBanner = function(successCallback, failureCallback) {
  cordova.exec(
    successCallback,
    failureCallback,
    'AdStir',
    'hideBanner',
    [sendOptions()]
  );
};

adStirExport.createInterstitial = function(successCallback, failureCallback) {
  cordova.exec(
    successCallback,
    failureCallback,
    'AdStir',
    'createInterstitial',
    [sendOptions()]
  );
};

adStirExport.showInterstitial = function(successCallback, failureCallback) {
  cordova.exec(
    successCallback,
    failureCallback,
    'AdStir',
    'showInterstitial',
    []
  );
};

var sendOptions = function() {
  returnObj = {};
  for (var attr in defaultOptions) {
    returnObj[attr] = options[attr] || defaultOptions[attr];
  }
  return returnObj;
};

module.exports = adStirExport;
