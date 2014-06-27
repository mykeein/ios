//
//  MainViewController.m
//  Mykeen
//
//  Created by Ilia Kohanovski on 6/27/14.
//  Copyright (c) 2014 Mykeen. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (nonatomic, retain) GADBannerView *bannerView;

@end

@implementation MainViewController

-(void)viewDidLoad{
    // Create a view of the standard size at the top of the screen.
    // Available AdSize constants are explained in GADAdSize.h.
    self.bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    
    // Specify the ad unit ID.
    self.bannerView.adUnitID = ADMOB_UNIT_ID;

    // Let the runtime know which UIViewController to restore after taking
    // the user wherever the ad goes and add it to the view hierarchy.
    self.bannerView.rootViewController = self;
    [self.bannerContainerView addSubview:self.bannerView];

    // Initiate a generic request to load it with an ad.
    GADRequest *request = [GADRequest request];

    // Make the request for a test ad. Put in an identifier for
    // the simulator as well as any devices you want to receive test ads.
    request.testDevices = @[ @"GAD_SIMULATOR_ID" ];
    [self.bannerView loadRequest:request];
    NSLog(@"aaaaa");
}

@end
