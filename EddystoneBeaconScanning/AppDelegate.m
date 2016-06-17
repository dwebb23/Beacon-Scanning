//
//  AppDelegate.m
//  EddystoneBeaconScanning
//
//  Created by Dan Webb on 6/17/16.
//
//

#import "AppDelegate.h"
#import "ViewController.h"

#import <GNSMessages.h>

static NSString *kMyAPIKey = @"<API key goes here>";

@interface AppDelegate ()
@property(nonatomic) GNSMessageManager *messageMgr;
@property(nonatomic) id<GNSSubscription> subscription;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
  self.window.rootViewController = navController;

  // Enable debug logging to help track down problems.
  [GNSMessageManager setDebugLoggingEnabled:YES];

  _messageMgr = [[GNSMessageManager alloc] initWithAPIKey:kMyAPIKey];

  GNSMessageHandler messageFoundHandler = ^(GNSMessage *message) {
    NSString *beaconString = [[NSString alloc] initWithData:message.content encoding:NSUTF8StringEncoding];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Found a Beacon"
                                                                   message:beaconString
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
  };
  _subscription = [_messageMgr
      subscriptionWithMessageFoundHandler:messageFoundHandler
                       messageLostHandler:^(GNSMessage *message) {}
                       paramsBlock:^(GNSSubscriptionParams *params) {
                         params.deviceTypesToDiscover = kGNSDeviceBLEBeacon;
                         params.beaconStrategy = [GNSBeaconStrategy strategyWithParamsBlock:^(GNSBeaconStrategyParams *beaconParams) {
                           beaconParams.includeIBeacons = NO;
                         }];
                       }];

  return YES;
}

@end
