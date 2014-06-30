//
//  MainViewController.m
//  Mykeen
//
//  Created by Ilia Kohanovski on 6/27/14.
//  Copyright (c) 2014 Mykeen. All rights reserved.
//

#import "MainViewController.h"
#import "Item.h"
#import "ItemCell.h"
#import "NewCell.h"

@interface MainViewController ()

@property (nonatomic, retain) GADBannerView *bannerView;
@property NSArray *items;

@end

@implementation MainViewController

-(void)viewDidLoad{
    [self showBanner];
}
-(void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView
{
    NSLog(@"now");
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.items count] + 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == [self.items count]){
        static NSString* newCellIdentifier = @"NewCell";
        return [tableView dequeueReusableCellWithIdentifier:newCellIdentifier];
    }else{
        static NSString* itemCellIdentifier = @"ItemCell";
        ItemCell * cell = [tableView dequeueReusableCellWithIdentifier:itemCellIdentifier];
        Item * item = self.items[indexPath.row];
        cell.nameLabel.text = item.name;
        
        return cell;
    }
}

- (IBAction)edit:(id)sender {
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
    self.bannerView.frame = CGRectMake(0, screenHeight-50, 320, 50);
    [self.view addSubview:self.bannerView];
    
    // Initiate a generic request to load it with an ad.
    GADRequest *request = [GADRequest request];
    
    // Make the request for a test ad. Put in an identifier for
    // the simulator as well as any devices you want to receive test ads.
    request.testDevices = @[ @"GAD_SIMULATOR_ID" ];
    [self.bannerView loadRequest:request];
}
@end
