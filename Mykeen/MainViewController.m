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

-(void)viewWillAppear:(BOOL)animated{
    self.navigationItem.hidesBackButton = YES;
}
-(void)viewDidLoad{
    [self showBanner];
    self.items = [self loadItemsFromDisk];
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
        cell.nameLabel.text = item.title;
        
        return cell;
    }
}

- (IBAction)edit:(id)sender {
}

- (IBAction)newItemAction:(id)sender {
    [self performSegueWithIdentifier:@"NewItemVC" sender:self];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"NewItemVC"]){
        NewItemVC * n = segue.destinationViewController;
        n.createItemDelegate = self;
    }
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


#pragma mark - delegates
-(void)createItemWithTitle:(NSString *)title withUsername:(NSString *)username withPass:(NSString *)pass withNotes:(NSString *)notes
{
    Item *newItem = [[Item alloc] init];
    newItem.title = title;
    newItem.username = username;
    newItem.password = pass;
    newItem.notes = notes;
    
    [self saveItemToDisk:newItem];
    self.items = [self loadItemsFromDisk];
    [self.tableView reloadData];
}

#pragma mark - disk
- (void)saveItemToDisk:(Item*)item {
    NSString *path = @"~/Documents/items";
    path = [path stringByExpandingTildeInPath];

    NSMutableArray * arr = [self.items mutableCopy];
    [arr addObject:item];
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:arr];
    NSData * encryptedData =[data encryptedDataWithPass:[Utils getPass] error:nil];
    [encryptedData writeToFile:path atomically:YES];
}
- (NSArray*)loadItemsFromDisk {
    NSString *path = @"~/Documents/items";
    path = [path stringByExpandingTildeInPath];
    NSData * data = [NSData dataWithContentsOfFile:path];
    NSData * decodedData = [data decryptedDataWithPass:[Utils getPass] error:nil];
    NSArray * arr = [NSKeyedUnarchiver unarchiveObjectWithData:decodedData];
    return arr;
}
@end
