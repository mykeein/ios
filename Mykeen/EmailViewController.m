//
//  EmailViewController.m
//  Mykeen
//
//  Created by Ilia Kohanovski on 9/19/14.
//  Copyright (c) 2014 Mykeen. All rights reserved.
//

#import "EmailViewController.h"

@interface EmailViewController ()

@end

@implementation EmailViewController

-(void)viewDidLoad{
    self.emailTextField.placeholder = NSLocalizedString(@"your email", nil);
    [self.cancelButton setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
    [self.saveButton setTitle:NSLocalizedString(@"Save", nil) forState:UIControlStateNormal];
    self.emailTextField.text = [Utils getEmail];
    [self.emailTextField becomeFirstResponder];
}

-(void)newEmailRequest{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"email": self.emailTextField.text, @"registerId":[Utils uuid]};
    
    NSString * reqString = [NSString stringWithFormat:@"%@/api/user/new?os=ios&ln=%@",MYKEE_URL,LANG];
    NSLog(@"%@",parameters);
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:reqString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [Utils setEmail:self.emailTextField.text];

         NSDictionary *dic = responseObject;
         if (dic && [dic[@"status"] isEqualToString:@"send_approve_email_failed"])
         {
             UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"wrongEmailTitle", nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"wrongEmailOk", nil) otherButtonTitles:nil, nil];
             [alert show];
         }else{
             UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"pleaseApproveTitle", nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"pleaseApproveOk", nil) otherButtonTitles:nil, nil];
             [alert show];
             NSString * notApprovedString = NSLocalizedString(@"notApproved", nil);
             [self.notApprovedButton setTitle:notApprovedString forState:UIControlStateNormal];
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
     }];
}
-(void)changeEmailRequest{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"newEmail": self.emailTextField.text,
                                 @"registerId":[Utils uuid],
                                 @"oldEmail":[Utils getEmail]};
    
    NSString * reqString = [NSString stringWithFormat:@"%@/api/user/updateemail?os=ios&ln=%@",MYKEE_URL,LANG];
    [manager POST:reqString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [Utils setEmail:self.emailTextField.text];

         [Utils setApproved:NO];

         NSDictionary *dic = responseObject;
         if (dic && [dic[@"status"] isEqualToString:@"send_approve_email_failed"])
         {
             UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"wrongEmailTitle", nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"wrongEmailOk", nil) otherButtonTitles:nil, nil];
             [alert show];
         }else{
             UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"pleaseApproveTitle", nil) message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"pleaseApproveOk", nil) otherButtonTitles:nil, nil];
             [alert show];
             NSString * notApprovedString = NSLocalizedString(@"notApproved", nil);
             [self.notApprovedButton setTitle:notApprovedString forState:UIControlStateNormal];
         }
         
         NSLog(@"updateEmail %@", dic);
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
     }];
}
- (IBAction)saveAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

    if ([Utils getEmail]){
        [self changeEmailRequest];
    }else
        [self newEmailRequest];
}

- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
