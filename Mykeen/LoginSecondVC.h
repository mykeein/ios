//
//  LoginSecondVC.h
//  Mykeen
//
//  Created by Ilia Kohanovski on 6/22/14.
//  Copyright (c) 2014 Mykeen. All rights reserved.
//

#import "AppDelegate.h"

@interface LoginSecondVC : UIViewController

@property (weak, nonatomic) IBOutlet UIView *containerView;
- (IBAction)buttonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *firstTextField;
- (IBAction)firstTextFieldChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property CGPoint containerCenter;
@end
