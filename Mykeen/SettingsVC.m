//
//  SettingsVC.m
//  Mykeen
//
//  Created by Ilia Kohanovski on 7/26/14.
//  Copyright (c) 2014 Mykeen. All rights reserved.
//

#import "SettingsVC.h"
#import "SettingsCell.h"

@interface SettingsVC ()

@property (nonatomic, retain) GADBannerView *bannerView;

@end

@implementation SettingsVC

-(void)checkForButtonStatus{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"email": [Utils getEmail],@"registerId":[Utils uuid]};
    
    NSString * reqString = [NSString stringWithFormat:@"http://localhost:3000/api/user/check?os=ios&ln=%@",LANG];
    [manager POST:reqString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if ([responseObject[@"status"] isEqualToString:@"send_approve_email_failed"]){
             [Utils setApproved:NO];
             NSString * wrongEmailString = NSLocalizedString(@"failedToSendApprovalEmail", nil);
             self.notApprovedButton.titleLabel.text = wrongEmailString;
             self.notApprovedButton.hidden = NO;
         }else if([responseObject[@"status"] isEqualToString:@"not_approved"]){
             [Utils setApproved:NO];
             NSString * notApprovedString = NSLocalizedString(@"notApproved", nil);
             self.notApprovedButton.titleLabel.text = notApprovedString;
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
    
    self.notApprovedButton.hidden = YES;
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    //[userDefaults removeObjectForKey:@"email"];
    NSString * email = [Utils getEmail];
    if (!email){
        NSString * noEmailString = NSLocalizedString(@"noEmail", nil);
        self.notApprovedButton.titleLabel.text = noEmailString;
        self.notApprovedButton.hidden = NO;
    }else{
        [self checkForButtonStatus];
    }

    
    [self showBanner];
}

- (IBAction)changeButtonClicked:(id)sender {
}

- (IBAction)notApprovedButtonClicked:(id)sender {
    if (![Utils getEmail])
        [self performSegueWithIdentifier:@"Email" sender:self];
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
