#import "CDVAdStir.h"
#import <AdstirAds/AdstirAds.h>
#import "AdstirInterstitial.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface CDVAdStir ()

@property (strong) UIView *bannerView;
@property (strong) AdstirInterstitial *inter;

@end

@implementation CDVAdStir

- (void)createBanner:(CDVInvokedUrlCommand *)command {
    NSLog(@"createBanner");

    CDVPluginResult *pluginResult;
    NSString *callbackId = command.callbackId;

    NSDictionary* options = [command argumentAtIndex:0 withDefault:[NSNull null]];

    int bannerWidth = [[options objectForKey:@"bannerWidth"] intValue];
    int bannerHeight = [[options objectForKey:@"bannerHeight"] intValue];

    AdstirAdSize adstirAdSize;
    if (bannerWidth == 320 && bannerHeight == 50) adstirAdSize = kAdstirAdSize320x50;
    else if (bannerWidth == 320 && bannerHeight == 100) adstirAdSize = kAdstirAdSize320x100;
    else if (bannerWidth == 300 && bannerHeight == 250) adstirAdSize = kAdstirAdSize300x250;
    else if (bannerWidth == 728 && bannerHeight == 90) adstirAdSize = kAdstirAdSize728x90;
    else {
        NSLog(@"Error: Specified banner ad size is not supported.");
        return;
    }

    CGRect sf = self.webView.superview.bounds;

    int originX = (sf.size.width - bannerWidth) / 2;
    int originY = sf.size.height - bannerHeight;

    NSLog(@"Media ID: %@", [options objectForKey:@"bannerMediaId"]);
    NSLog(@"Spot ID: %d", [[options objectForKey:@"bannerSpotId"] intValue]);

    AdstirMraidView *aAdstir = [[AdstirMraidView alloc] initWithAdSize:adstirAdSize origin:CGPointMake(originX, 0)
        media:[options objectForKey:@"bannerMediaId"] spot:[[options objectForKey:@"bannerSpotId"] intValue]];
    aAdstir.intervalTime = [[options objectForKey:@"bannerIntervalTime"] intValue];

    UIView *bannerContainerView =
        [[UIView alloc] initWithFrame:CGRectMake(0, originY, sf.size.width, 50)];

    unsigned colorInt;
    [[NSScanner scannerWithString:[options objectForKey:@"bannerBackgroundColor"]] scanHexInt:&colorInt];
    bannerContainerView.backgroundColor = UIColorFromRGB(colorInt);

    [bannerContainerView addSubview:aAdstir];
    self.bannerView = bannerContainerView;

    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

- (void)showBanner:(CDVInvokedUrlCommand *)command {
    NSLog(@"showBanner");

    CDVPluginResult *pluginResult;
    NSString *callbackId = command.callbackId;

    CGRect wf = self.webView.frame;
    wf.size.height = self.webView.superview.bounds.size.height - 50;
    self.webView.frame = wf;

    [self.webView.superview addSubview:self.bannerView];

    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

- (void)hideBanner:(CDVInvokedUrlCommand *)command {
    NSLog(@"hideBanner");

    CDVPluginResult *pluginResult;
    NSString *callbackId = command.callbackId;

    CGRect wf = self.webView.frame;
    wf.size.height = self.webView.superview.bounds.size.height;
    self.webView.frame = wf;

    [self.bannerView removeFromSuperview];

    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}


 - (void)createInterstitial:(CDVInvokedUrlCommand *)command {
    NSLog(@"createInterstitial");

    CDVPluginResult *pluginResult;
    NSString *callbackId = command.callbackId;

    NSDictionary* options = [command argumentAtIndex:0 withDefault:[NSNull null]];

    self.inter = [[AdstirInterstitial alloc] init];
    self.inter.media = [options objectForKey:@"interstitialMediaId"];
    self.inter.spot = [[options objectForKey:@"interstitialSpotId"] intValue];
    [self.inter load];

    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

- (void)showInterstitial:(CDVInvokedUrlCommand *)command {
    NSLog(@"showInterstitial");

    CDVPluginResult *pluginResult;
    NSString *callbackId = command.callbackId;

    UIViewController *rootViewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    [self.inter showTypeA:rootViewController];

    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

@end
