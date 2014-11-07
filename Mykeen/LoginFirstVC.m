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

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSLog(@"shown");
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    NSLog(@"%f %f",kbSize.height, self.view.frame.size.height);
    float h = self.view.frame.size.height - kbSize.height;
    self.containerView.center = CGPointMake(self.view.frame.size.width/2, h/2);
    
    self.containerCenter = self.containerView.center;
    //self.containerView.hidden = NO;
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //[SSKeychain deletePasswordForService:@"Mykeen" account:@"me"]; // for tests
    NSString *pass = [Utils getPass];
    if (pass){
        UIViewController * viewController = [self.navigationController.storyboard instantiateViewControllerWithIdentifier:@"LoginSecondVC"];
        [self.navigationController pushViewController:viewController animated:NO];
        return;
    }
    
    self.containerView.center = self.view.center;
    self.containerCenter = self.containerView.center;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    //[self updateButtonState];
    
    CGPoint center = self.label.center;
    [self.label sizeToFit];
    self.label.center = CGPointMake(center.x, self.label.center.y);
    
    [self.label sizeToFit];
    self.label.textAlignment = NSTextAlignmentCenter;
    
    self.label.text = NSLocalizedString(@"master key text first screen", nil);
    [self.loginButton setTitle:NSLocalizedString(@"first screen login button text", nil) forState:UIControlStateNormal];
    
    self.navigationItem.hidesBackButton = YES;
    [self.firstTextField becomeFirstResponder];
    
    self.loginButton.enabled = NO;
}

-(void)firstTextFieldChanged:(id)sender{
    self.loginButton.enabled = self.firstTextField.text && ![self.firstTextField.text isEqualToString:@""];
}

-(void)buttonClicked:(id)sender{
    [Utils setPass:self.firstTextField.text];
    [self performSegueWithIdentifier:@"ShowSecondLogin" sender:self];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    LoginSecondVC * vc = segue.destinationViewController;
    vc.containerCenter = self.containerCenter;
}

@end
