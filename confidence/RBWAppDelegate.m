//
//  RBWAppDelegate.m
//  confidence
//
//  Created by Raemond on 4/7/14.
//  Copyright (c) 2014 Raemond. All rights reserved.
//

#import "RBWAppDelegate.h"
#import "RBWSentiment.h"
#import <Parse/Parse.h>

@implementation RBWAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    //self.window.backgroundColor = [UIColor whiteColor];
    //[self.window makeKeyAndVisible];
    [Parse setApplicationId:@"APPLICATION ID"
                  clientKey:@"CLIENT KEY"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    // Register for push notifications
    [application registerForRemoteNotificationTypes:
        UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeAlert |
        UIRemoteNotificationTypeSound];
    
    //_sentiments = [[NSDictionary alloc] init];
    _sentiments = [[NSMutableArray alloc] init];
    _currentCourse = [[NSString alloc] init];

    _changed = NO;
    
    NSLog(@"got past push notifaction allowal");
    
    return YES;
}

- (void)application:(UIApplication *)application
        didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken {
    // Store the deviceToken in the current installation and save it to Parse.
    _pushNotifications = YES;
    NSLog(@"got to push notification registration with parse.");
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:newDeviceToken];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application
        didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"Received push notification!");
    /*NSLog(@"%@", [userInfo objectForKey:@"student"]);*/
    NSString *course = [userInfo objectForKey:@"course"];
    if ([course isEqualToString:_currentCourse]) {
        NSNumber *value = [NSNumber numberWithInt:[[userInfo objectForKey:@"value"] intValue]];
        RBWSentiment *sentiment = [[RBWSentiment alloc] init];
        sentiment.username = [userInfo objectForKey:@"student"];
        sentiment.value = [NSNumber numberWithLong:[value longValue]-2];
        [_sentiments addObject:sentiment];
        
        /*if ([_sentiments objectForKey:course] == nil) {
            NSMutableArray *sentArray = [[NSMutableArray alloc] init];
            [sentArray addObject:sentiment];
            [_sentiments setValue:sentArray forUndefinedKey:course];
        } else {
            [[_sentiments valueForKey:course] addObject:sentiment];
        }
        if ([[_sentiments objectForKey:course] count] > 10)
            [[_sentiments objectForKey:course] removeObjectAtIndex:0];*/
        if ([_sentiments count] > 10)
            [_sentiments removeObjectAtIndex:0];
        _changed = YES;
    }
    //[PFPush handlePush:userInfo];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    _pushNotifications = NO;
    NSLog(@"%@", error);
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
