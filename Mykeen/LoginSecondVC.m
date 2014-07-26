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
    
    AppDelegate * appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.loginViewController = self;
    appDelegate.loginNavigationController = self.navigationController;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    self.firstTextField.text = @"";
}


- (IBAction)buttonClicked:(id)sender {
    NSString * reallPass = [Utils getPass];
    NSString * enteredPass = self.firstTextField.text;
    if ([reallPass isEqualToString:enteredPass])
        [self performSegueWithIdentifier:@"ShowMainVC" sender:self];
    else{
        NSLocalizedString(@"Wrong Pass", nil);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Wrong Pass", nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok for wrong pass", nil) otherButtonTitles:nil, nil];
        [alert show];
    }
    
}
@end
