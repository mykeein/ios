//
//  TableVC.m
//  Mykeen
//
//  Created by Ilia Kohanovski on 6/25/14.
//  Copyright (c) 2014 Mykeen. All rights reserved.
//

#import "TableVC.h"

@interface TableVC ()

@end

@implementation TableVC

-(void)viewDidLoad{
    [super viewDidLoad];

    //TODO to add banner on different view controller
//    // Create a view of the standard size at the top of the screen.
//    // Available AdSize constants are explained in GADAdSize.h.
//    self.bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
//    
//    // Specify the ad unit ID.
//    self.bannerView.adUnitID = ADMOB_UNIT_ID;
//    
//    // Let the runtime know which UIViewController to restore after taking
//    // the user wherever the ad goes and add it to the view hierarchy.
//    self.bannerView.rootViewController = self;
//    [self.view addSubview:self.bannerView];
//    
//    // Initiate a generic request to load it with an ad.
//    GADRequest *request = [GADRequest request];
//    
//    // Make the request for a test ad. Put in an identifier for
//    // the simulator as well as any devices you want to receive test ads.
//    request.testDevices = @[ @"GAD_SIMULATOR_ID" ];
//    [self.bannerView loadRequest:request];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
