//
//  AppDelegate.m
//  100
//
//  Created by apple on 24/04/14.
//  Copyright (c) 2014 100. All rights reserved.
//

#import "AppDelegate.h"
#import  <Accounts/Accounts.h>
#import <Social/Social.h>
@implementation AppDelegate





- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
   
            
    
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
   
    UIApplication* app = [UIApplication sharedApplication];
    NSArray*    oldNotifications = [app scheduledLocalNotifications];
    GADBannerView *bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait];
    
    
    
    if ([oldNotifications count] > 0)
        [app cancelAllLocalNotifications];
   
    
    
    NSArray *notifications = [app scheduledLocalNotifications];
    if ([notifications count] > 0)
        [app presentLocalNotificationNow:notifications[0]];
    
    //UInavigation controller
    UINavigationController *_navigationController=[[[UINavigationController alloc]initWithRootViewController:[[[HomeVC alloc]init]autorelease]]autorelease];
    _navigationController.navigationBarHidden=YES;
    
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    //Vungle SDK intializtion
    //VungleSDK *sdk = [VungleSDK sharedSDK];
    //[sdk startWithAppId:kVungleAppId];
    
    self.window.rootViewController=_navigationController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)dealloc{
    [_window release];
    [super dealloc];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSDate *alertTime = [[NSDate date]
                         dateByAddingTimeInterval:19200];
    UIApplication* app = [UIApplication sharedApplication];
    UILocalNotification* notifyAlarm = [[UILocalNotification alloc]
                                        init];
    if (notifyAlarm)
    {
        notifyAlarm.fireDate = alertTime;
        notifyAlarm.timeZone = [NSTimeZone defaultTimeZone];
        notifyAlarm.repeatInterval = 0;
        notifyAlarm.soundName = @"button-33a.mp3";
        notifyAlarm.alertBody = @"Time to make 100 !";
        [app scheduleLocalNotification:notifyAlarm];
    }
}




@end
