//
//  LoginFirstVC.m
//  Mykeen
//
//  Created by Ilia Kohanovski on 6/22/14.
//  Copyright (c) 2014 Mykeen. All rights reserved.
//

#import "LoginFirstVC.h"
#import "Constants.h"
#import <Security/Security.h>

@interface LoginFirstVC ()

@end

@implementation LoginFirstVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateButtonState];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    SecItemAdd(<#CFDictionaryRef attributes#>, <#CFTypeRef *result#>)
    NSString *pass = [SSKeychain passwordForService:@"Mykeen" account:@"me"];


    //[defaults setBool:YES forKey:mkNotFirstTime];
    //[defaults removeObjectForKey:mkNotFirstTime];

    BOOL notFirstTime = [defaults boolForKey:mkNotFirstTime];
    if (notFirstTime){
        [self performSegueWithIdentifier:@"ShowSecondLogin" sender:self];
        return;
    }
    NSLog(@"sss");
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
    [self performSegueWithIdentifier:@"ShowSecondLogin" sender:self];
}

-(void)updateButtonState{
    self.button.hidden = !self.firstTextField || [self.firstTextField.text isEqualToString:@""] || ![self.firstTextField.text isEqualToString:self.secondTextField.text];
}
-(void)textChanged{
    [self updateButtonState];
}
@end
