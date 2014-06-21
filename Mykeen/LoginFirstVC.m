//
//  LoginFirstVC.m
//  Mykeen
//
//  Created by Ilia Kohanovski on 6/22/14.
//  Copyright (c) 2014 Mykeen. All rights reserved.
//

#import "LoginFirstVC.h"

@interface LoginFirstVC ()

@end

@implementation LoginFirstVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"mkNotFirstTime"];
    // [defaults setObject:numbers forKey:@"numberArray"];

    BOOL notFirstTime = [defaults boolForKey:@"mkNotFirstTime"];
    if (notFirstTime)
        [self performSegueWithIdentifier:@"LoginSecond" sender:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
