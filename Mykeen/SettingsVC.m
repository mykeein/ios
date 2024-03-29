//
//  SettingsVC.m
//  Mykeen
//
//  Created by Ilia Kohanovski on 7/26/14.
//  Copyright (c) 2014 Mykeen. All rights reserved.
//

#import "SettingsVC.h"
#import "SettingsCell.h"
#import "EmailViewController.h"

@interface SettingsVC () <UIAlertViewDelegate>

@property (nonatomic, retain) GADBannerView *bannerView;

@end

@implementation SettingsVC

-(void)checkForButtonStatus{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"email": [Utils getEmail],@"registerId":[Utils uuid]};
    
    NSString * reqString = [NSString stringWithFormat:@"%@/api/user/check?os=ios&ln=%@",MYKEE_URL,LANG];
    [manager POST:reqString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if ([responseObject[@"status"] isEqualToString:@"send_approve_email_failed"]){
             [Utils setApproved:NO];
             NSString * wrongEmailString = NSLocalizedString(@"failedToSendApprovalEmail", nil);
             [self.notApprovedButton setTitle:wrongEmailString forState:UIControlStateNormal];
             self.notApprovedButton.hidden = NO;
         }else if([responseObject[@"status"] isEqualToString:@"not_approved"]){
             [Utils setApproved:NO];
             NSString * notApprovedString = NSLocalizedString(@"notApproved", nil);
             [self.notApprovedButton setTitle:notApprovedString forState:UIControlStateNormal];
             self.notApprovedButton.hidden = NO;
         }else if ([responseObject[@"status"] isEqualToString:@"success"]){
             [Utils setApproved:YES];
         }
         NSLog(@"JSON: %@", responseObject);
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
     }];
    
    //self.tableView.scrollEnabled = NO;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.emailLabel.text = NSLocalizedString(@"Email", @"on settings view");
    [self.changeButton setTitle:NSLocalizedString(@"Change", @"change email button on settings view") forState:UIControlStateNormal];
    NSString * notApprovedString = NSLocalizedString(@"notApproved", nil);
    [self.notApprovedButton setTitle:notApprovedString forState:UIControlStateNormal];
    
    self.notApprovedButton.hidden = YES;
    NSString * email = [Utils getEmail];
    if (!email){
        NSString * noEmailString = NSLocalizedString(@"noEmail", nil);
        [self.notApprovedButton setTitle:noEmailString forState:UIControlStateNormal];
        self.notApprovedButton.hidden = NO;
    }else if ([Utils getApproved]){
        // do nothing. ok now
    }else{
        [self checkForButtonStatus];
    }
    
    [self showBanner];
}

- (IBAction)changeButtonClicked:(id)sender {
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"Email"]){
        EmailViewController * c = segue.destinationViewController;
        c.notApprovedButton = self.notApprovedButton;
    }
}
- (IBAction)notApprovedButtonClicked:(id)sender {
    if (![Utils getEmail])
        [self performSegueWithIdentifier:@"Email" sender:self];
    else{
        NSString * title = NSLocalizedString(@"Email Was Not Approved", nil);
        NSString * description = NSLocalizedString(@"Please approve email received from 'mykee.in support' - Did not receive?", nil);
        NSString * sendAgain = NSLocalizedString(@"Send again", nil);
        NSString * cancel = NSLocalizedString(@"Cancel", nil);
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:title message:description delegate:self cancelButtonTitle:cancel otherButtonTitles:sendAgain, nil];
        [alert show];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==alertView.cancelButtonIndex)
        return;
    else{
        [self sendEmail];
    }
}
-(void)sendEmail{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"newEmail": [Utils getEmail],
                                 @"registerId":[Utils uuid],
                                 @"oldEmail":[Utils getEmail]};
    
    NSString * reqString = [NSString stringWithFormat:@"%@/api/user/updateemail?os=ios&ln=%@",MYKEE_URL,LANG];
    [manager POST:reqString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {

     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
     }];
}
-(void)showBanner{
    // Create a view of the standard size at the top of the screen.
    // Available AdSize constants are explained in GADAdSize.h.
    self.bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    
    // Specify the ad unit ID.
    self.bannerView.adUnitID = ADMOB_UNIT_ID;
    
    // Let the runtime know which UIViewController to restore after taking
    // the user wherever the ad goes and add it to the view hierarchy.
    self.bannerView.rootViewController = self;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    self.bannerView.frame = CGRectMake(0, screenHeight-50-64, 320, 50);
    [self.view addSubview:self.bannerView];
    
    // Initiate a generic request to load it with an ad.
    GADRequest *request = [GADRequest request];
    
    // Make the request for a test ad. Put in an identifier for
    // the simulator as well as any devices you want to receive test ads.
    request.testDevices = @[ @"GAD_SIMULATOR_ID" ];
    [self.bannerView loadRequest:request];
}
@end
