
var adStirExport = {};
var options = {};

var defaultOptions = {
  bannerMediaId: "aa",
  bannerSpotId: 0,
  bannerIntervalTime: 60,
  bannerBackgroundColor: "0xFFFFFF",
  interstitialApiKey: "308c2499c75c4a192f03c02b2fcebd16dcb45cc9",
  interstitialSpotId: "213208"
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
