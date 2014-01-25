//
//  AMIOAppDelegate.m
//  Amio
//
//  Created by Devon on 1/25/14.
//  Copyright (c) 2014 Devon. All rights reserved.
//

#import "AMIOAppDelegate.h"
#import "AMIOMainViewController.h"
#import "AMIOUser.h"
#import "AMIOGroup.h"
#import <Parse/Parse.h>


@implementation AMIOAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    // Parse stuff.
    [Parse setApplicationId:@"4GE07BfZ8uxc0q3hF3H9XQR7ucIhxyKb7OAkognn"
                  clientKey:@"Y1x2ooR4oWkwNDZHBvgvR0k3AHOr5o2EuSrGDUdr"];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    [AMIOUser registerSubclass];
    [AMIOGroup registerSubclass];
    
    // View Controller Setup
    AMIOMainViewController *mainViewController = [[AMIOMainViewController alloc] initWithStyle:UITableViewStyleGrouped];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:24.0f],
                                                           NSForegroundColorAttributeName: [UIColor orangeColor]}];
    [[self window] setRootViewController:navController];
    [self.window makeKeyAndVisible];
    
    return YES;
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
