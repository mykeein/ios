//
//  MykeenAppDelegate.m
//  Mykeen
//
//  Created by Ilia Kohanovski on 6/22/14.
//  Copyright (c) 2014 Mykeen. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate()

@property (retain, nonatomic) NSDate *backgroundTime;

@end

@implementation AppDelegate

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"failed to register for remote notifications");
}
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
    NSLog(@"My token is: %@", devToken);
    NSLog(@"my uuid is: %@",[Utils uuid]);
    
    NSString *strDevToken = [[NSString alloc]initWithFormat:@"%@",[[[devToken description]
                                                                    stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]]
                                                                   stringByReplacingOccurrencesOfString:@" "
                                                                   withString:@""]];
    NSLog(@"%@",strDevToken);
    
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/pushnotification/register?token=%@&uuid=%@&os=ios&lang=%@&v=%@", LIVEWALLS_URL, strDevToken, [self uuid],[[NSLocale preferredLanguages] objectAtIndex:0],kAppVersion]];
//    
//    NSLog(@"%@",url);
//    NSHTTPURLResponse * response;
//    NSError * error;
//    NSMutableURLRequest *request;
//    
//    request = [[NSMutableURLRequest alloc] initWithURL:url];
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    [NSURLConnection sendAsynchronousRequestWithWolfloToken:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        NSLog(@"push error");
//    }];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Utils uuid]; //initializing uuid
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeNone)];

    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    self.backgroundTime = [NSDate new];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    NSDate * fiveMinutesAgo = [NSDate dateWithTimeIntervalSinceNow:-60*5];
    if ([self.backgroundTime isEarlierThan:fiveMinutesAgo])
        [self.loginNavigationController popToViewController:self.loginViewController animated:NO];
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
