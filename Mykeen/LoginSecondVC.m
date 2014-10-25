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

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSLog(@"shown");
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    NSLog(@"%f %f",kbSize.height, self.view.frame.size.height);
    float h = self.view.frame.size.height - kbSize.height;
    self.containerView.center = CGPointMake(self.view.frame.size.width/2, h/2);
    
    //self.containerView.hidden = NO;
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.containerView.center = self.view.center;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    //TODO in ios8 get keyboard height from the first view controller
    
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
