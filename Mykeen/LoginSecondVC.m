//
//  LoginSecondVC.m
//  Mykeen
//
//  Created by Ilia Kohanovski on 6/22/14.
//  Copyright (c) 2014 Mykeen. All rights reserved.
//

#import "LoginSecondVC.h"

@interface LoginSecondVC ()

@end

@implementation LoginSecondVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    [self.firstTextField becomeFirstResponder];
}


@end
