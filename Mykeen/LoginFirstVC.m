//
//  LoginFirstVC.m
//  Mykeen
//
//  Created by Ilia Kohanovski on 6/22/14.
//  Copyright (c) 2014 Mykeen. All rights reserved.
//

#import "LoginFirstVC.h"
#import "Constants.h"
#import "LoginSecondVC.h"

@interface LoginFirstVC ()

@end

@implementation LoginFirstVC

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateButtonState];
    
    [SSKeychain deletePasswordForService:@"Mykeen" account:@"me"]; // for tests
    NSString *pass = [Utils getPass];
    if (pass){
        UIViewController * viewController = [self.navigationController.storyboard instantiateViewControllerWithIdentifier:@"LoginSecondVC"];
        [self.navigationController pushViewController:viewController animated:NO];
        return;
    }
    self.firstTextField.delegate = self;
    [self.firstTextField becomeFirstResponder];
}

- (IBAction)firstTextChanged:(id)sender {
    [self textChanged];
}

- (IBAction)secondTextChanged:(id)sender {
    [self textChanged];
}

-(void)buttonClicked:(id)sender{
    [Utils setPass:self.firstTextField.text];
    [self performSegueWithIdentifier:@"ShowSecondLogin" sender:self];
}

-(void)updateButtonState{
    self.button.hidden = !self.firstTextField.text || [self.firstTextField.text isEqualToString:@""] || ![self.firstTextField.text isEqualToString:self.secondTextField.text];
}
-(void)textChanged{
    [self updateButtonState];
}
@end
