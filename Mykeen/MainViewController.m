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
#import "RequestCell.h"

@interface MainViewController ()

@property (nonatomic, retain) GADBannerView *bannerView;
@property NSArray *items;
@property NSArray *requests;

@end

@implementation MainViewController

-(void)viewWillAppear:(BOOL)animated{
    self.navigationItem.hidesBackButton = YES;
    if ([self.segmentedControl selectedSegmentIndex] == 1) {
        [self segmentChanged:self]; //reload no email status
    }
}
-(void)viewDidLoad{
    [self showBanner];
    self.noEmailView.hidden = YES;
    
    UIBarButtonItem * settingsButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"edit_profile22"] style:UIBarButtonItemStylePlain target:self action:@selector(settingsClicked)];
    
    UIBarButtonItem * shareButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share2"] style:UIBarButtonItemStylePlain target:self action:nil];
    
    UIImageView * logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    UIBarButtonItem * logoButton = [[UIBarButtonItem alloc] initWithCustomView:logoImageView];
    //[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"logo"] style:UIBarButtonItemStylePlain target:self action:nil];
    
    self.navigationItem.rightBarButtonItems = @[settingsButton];
    self.navigationItem.leftBarButtonItems = @[shareButton];
    
    self.items = [self loadItemsFromDisk];
}

-(void)settingsClicked{
    [self performSegueWithIdentifier:@"ShowSettings" sender:self];
}
-(void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView
{
    NSLog(@"now");
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView!=self.tableView)
        return 0;
    
    if (self.segmentedControl.selectedSegmentIndex == 1)
        return [self.requests count];
    
    return [self.items count] + 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.segmentedControl.selectedSegmentIndex == 1){
        static NSString* requestCellIdentifier = @"RequestCell";
        RequestCell * cell = [tableView dequeueReusableCellWithIdentifier:requestCellIdentifier];
        NSDictionary * request = self.requests[indexPath.row];
        cell.ip.text = request[@"ip"];
        NSDate * date = [Utils dateForRFC3339DateTimeString:request[@"updated"]];
        cell.date.text = [date timeAgoSinceNow];
        return cell;

    }
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.segmentedControl.selectedSegmentIndex == 1)
        return 69;
    else
        return 44;
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
- (IBAction)segmentChanged:(id)sender {
    if ([self.segmentedControl selectedSegmentIndex] == 1) {
        [self.tableView setTableHeaderView:nil];
        if (![Utils getApproved])
            self.noEmailView.hidden = NO;
        else
            self.noEmailView.hidden = YES;
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *parameters = @{@"email": [Utils getEmail]};
        
        NSString * reqString = [NSString stringWithFormat:@"http://localhost:3000/api/requests/load?os=ios&ln=%@",LANG];
        [manager POST:reqString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             self.requests = responseObject;
             [self.tableView reloadData];
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
         }];
    }
    else {
        self.noEmailView.hidden = YES;
        [self.tableView setTableHeaderView:[[self searchDisplayController] searchBar]];
        [self.tableView reloadData];
    }
}
- (IBAction)settingsButtonClicked:(id)sender {
    [self performSegueWithIdentifier:@"ShowSettings" sender:self];
}

- (IBAction)ignoreRequestAction:(id)sender {
}

- (IBAction)sendRequestAction:(id)sender {
}
@end
