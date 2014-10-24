//
//  LoginSecondVC.m
//  Mykeen
//
//  Created by Ilia Kohanovski on 6/22/14.
//  Copyright (c) 2014 Mykeen. All rights reserved.
//

#import "LoginSecondVC.h"

@interface LoginSecondVC ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LoginSecondVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGPoint center = self.label.center;
    [self.label sizeToFit];
    self.label.center = CGPointMake(center.x, self.label.center.y);

    [self.label sizeToFit];
    self.label.textAlignment = NSTextAlignmentCenter;
    
    self.label.text = NSLocalizedString(@"master key text second screen", nil);
    [self.loginButton setTitle:NSLocalizedString(@"second screen login button text", nil) forState:UIControlStateNormal];
    
    
    

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
