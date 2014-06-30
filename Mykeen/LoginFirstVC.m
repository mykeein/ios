//
//  LoginFirstVC.m
//  Mykeen
//
//  Created by Ilia Kohanovski on 6/22/14.
//  Copyright (c) 2014 Mykeen. All rights reserved.
//

#import "LoginFirstVC.h"
#import "Constants.h"

@interface LoginFirstVC ()

@end

@implementation LoginFirstVC

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:mkNotFirstTime];

    BOOL notFirstTime = [defaults boolForKey:mkNotFirstTime];
    if (notFirstTime){
        [self performSegueWithIdentifier:@"LoginSecond" sender:self];
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

-(void)textChanged{
    if ([self.firstTextField.text isEqualToString:@""])
        return;
    if ([self.firstTextField.text isEqualToString:self.secondTextField.text])
        NSLog(@"privet");
}
@end
