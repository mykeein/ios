//
//  LoginFirstVC.h
//  Mykeen
//
//  Created by Ilia Kohanovski on 6/22/14.
//  Copyright (c) 2014 Mykeen. All rights reserved.
//

@interface LoginFirstVC : UIViewController <UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UIView *containerView;
- (IBAction)buttonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *firstTextField;
- (IBAction)firstTextFieldChanged:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property CGPoint containerCenter;
@end
