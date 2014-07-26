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

-(void)viewDidLoad{
    [super viewDidLoad];
    self.tableView.scrollEnabled = NO;
    [self showBanner];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* settingsIdentifier = @"SettingsCell";
    SettingsCell * cell = [tableView dequeueReusableCellWithIdentifier:settingsIdentifier];
    return cell;
}

- (IBAction)changeButtonClicked:(id)sender {
}

- (IBAction)notApprovedButtonClicked:(id)sender {
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
