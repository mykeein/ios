//
//  MykeenAppDelegate.h
//  Mykeen
//
//  Created by Ilia Kohanovski on 6/22/14.
//  Copyright (c) 2014 Mykeen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic,retain) UINavigationController *loginNavigationController;
@property(nonatomic,retain) UIViewController *loginViewController;

@end
