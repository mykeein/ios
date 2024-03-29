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
#import "SendViewController.h"
#import "MyPersonalLinkCell.h"

@interface MainViewController ()

@property (nonatomic, retain) GADBannerView *bannerView;
@property NSArray *items;
@property NSMutableArray *requests;

@property BOOL loaded;
@property BOOL toUpdate;
@property int updateIndex;
@property Item * selectedItem;

@end

@implementation MainViewController

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    self.navigationItem.hidesBackButton = YES;
    if ([self.segmentedControl selectedSegmentIndex] == 1) {
        [self segmentChanged:self]; //reload no email status
    }
}
-(void)viewDidLoad{
    self.noEmailTitle.text = NSLocalizedString(@"Please Complete Email Settings",nil);
    self.noEmailDescription.text = NSLocalizedString(@"For using requests by personal link, you must complete your email settings",nil);
    self.noEmailDescription.font = [UIFont systemFontOfSize:14];
    self.noEmailDescription.textAlignment = NSTextAlignmentCenter;
    [self.noEmailSettingsButton setTitle:NSLocalizedString(@"Settings",nil) forState:UIControlStateNormal];
    
    [self showBanner];
    self.noEmailView.hidden = YES;
    
    UIBarButtonItem * settingsButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"edit_profile22"] style:UIBarButtonItemStylePlain target:self action:@selector(settingsClicked)];
    
    UIBarButtonItem * shareButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share2"] style:UIBarButtonItemStylePlain target:self action:@selector(share:)];
    
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
-(NSArray*)filterItemsBySearch{
    NSString * filterString = [NSString stringWithFormat:@"title like '%@*'",self.searchBar.text]; //another option @"title beginswith[c] James" or contains[cd]
    NSPredicate * predicate = [NSPredicate predicateWithFormat:filterString];
    NSArray * result = [self.items filteredArrayUsingPredicate:predicate];
    return result;
}
-(BOOL)noRequests{
    if (self.loaded && self.requests.count == 0)
        return YES;
    else
        return NO;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView!=self.tableView){
        if (![self.searchBar.text isEqualToString:@""])
            return [[self filterItemsBySearch]count];
        else
            return 0;
    }
    
    if (self.segmentedControl.selectedSegmentIndex == 1){
        if ([self noRequests])
            return 1;
        
        return [self.requests count];
    }
    
    return [self.items count] + 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.segmentedControl.selectedSegmentIndex == 1){
        if ([self noRequests] && indexPath.row==0){
            MyPersonalLinkCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"MyPersonalLinkCell"];
            [cell.linkButton setTitle:[self urlString] forState:UIControlStateNormal];
            return cell;
        }
        static NSString* requestCellIdentifier = @"RequestCell";
        RequestCell * cell = [tableView dequeueReusableCellWithIdentifier:requestCellIdentifier];
        NSDictionary * request = self.requests[indexPath.row];
        cell.ip.text = request[@"ip"];
        NSDate * date = [Utils dateForRFC3339DateTimeString:request[@"updated"]];
        cell.date.text = [date timeAgoSinceNow];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }
    if (self.tableView == tableView && indexPath.row == [self.items count]){
        static NSString* newCellIdentifier = @"NewCell";
        return [self.tableView dequeueReusableCellWithIdentifier:newCellIdentifier];
    }else{
        static NSString* itemCellIdentifier = @"ItemCell";
        ItemCell * cell = [self.tableView dequeueReusableCellWithIdentifier:itemCellIdentifier];
        Item * item = self.items[indexPath.row];
        cell.nameLabel.text = item.title;
        cell.iconImage.image = [UIImage imageNamed:item.iconImageName];
        
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.segmentedControl.selectedSegmentIndex == 1)
        return 69;
    else
        return 44;
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.cancelButtonIndex == buttonIndex)
        return;
    int index = actionSheet.firstOtherButtonIndex;
    NSString * toastText;
    NSString * copy;
    if (buttonIndex == index){
        copy = self.selectedItem.username;
        toastText = NSLocalizedString(@"username copied", nil);
    }else if (buttonIndex == ++index){
        copy = self.selectedItem.password;
        toastText = NSLocalizedString(@"password copied", nil);
    }else if (buttonIndex == ++index){
        copy = self.selectedItem.notes;
        toastText = NSLocalizedString(@"notes copied", nil);
    }
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = copy;
    [self.tableView makeToast:toastText];
}
-(NSString*)urlString{
    return [NSString stringWithFormat:@"%@/%@",MYKEE_URL,[Utils getEmail]];
}
-(IBAction)linkClicked:(id)sender{
    NSURL *url = [NSURL URLWithString:[self urlString]];
    [[UIApplication sharedApplication] openURL:url];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.segmentedControl.selectedSegmentIndex == 1){
        if ([self noRequests]){
            [self linkClicked:tableView];
        }
        return;
    }
    NSString * userName = NSLocalizedString(@"Username", nil);
    NSString * password = NSLocalizedString(@"Password", nil);
    NSString * notes = NSLocalizedString(@"Notes", nil);
    NSString * cancel = NSLocalizedString(@"Cancel", nil);
    Item * item = self.items[indexPath.row];
    self.selectedItem = item;
    
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:item.title delegate:self cancelButtonTitle:cancel destructiveButtonTitle:nil otherButtonTitles:userName,password, notes, nil];
    [actionSheet showInView:self.view];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - buttons
-(NSIndexPath*)indexPathForSender:(id)sender{
    NSIndexPath* indexPath;
    UIView *view = [sender superview];
    while (![view isKindOfClass:[UITableViewCell class]]){
        view = [view superview];
    }
    indexPath = [self.tableView indexPathForCell:(UITableViewCell*)view]; //ios6
    return indexPath;
}

- (IBAction)swipeLeft:(id)sender {
    self.segmentedControl.selectedSegmentIndex = 0;
    [self segmentChanged:self];
}

- (IBAction)swipeRight:(id)sender {
    self.segmentedControl.selectedSegmentIndex = 1;
    [self segmentChanged:self];
}

- (IBAction)edit:(id)sender {
    self.toUpdate = YES;
    self.updateIndex = [self indexPathForSender:sender].row;
    [self performSegueWithIdentifier:@"NewItemVC" sender:self];
}

- (IBAction)newItemAction:(id)sender {
    self.toUpdate = NO;
    [self performSegueWithIdentifier:@"NewItemVC" sender:self];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"NewItemVC"]){
        NewItemVC * n = segue.destinationViewController;
        n.createItemDelegate = self;
        if (self.toUpdate)
            n.itemToUpdate = self.items[self.updateIndex];
    }
    if ([segue.identifier isEqualToString:@"SendVC"]){
        SendViewController *sendVC = segue.destinationViewController;
        
        NSIndexPath * indexPath = [self.tableView indexPathForCell:[[[sender superview]superview]superview]]; //ios7
        NSInteger rowOfTheCell = [indexPath row];
        
        NSDictionary * request = self.requests[rowOfTheCell];
        NSString *requestId = request[@"_id"];
        sendVC.requestId = requestId;
        sendVC.items = self.items;
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
- (IBAction)segmentChanged:(id)sender {
    if ([self.segmentedControl selectedSegmentIndex] == 1) {
        self.loaded = NO;
        [self.tableView setTableHeaderView:nil];
        [self.tableView reloadData];
        if (![Utils getApproved]){
            self.noEmailView.hidden = NO;
            return;
        }else
            self.noEmailView.hidden = YES;
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(loadRequestsAndReloadTheTable) object:nil];
        [self loadRequestsAndReloadTheTable];
    }
    else {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(loadRequestsAndReloadTheTable) object:nil];
        self.noEmailView.hidden = YES;
        [self.tableView setTableHeaderView:[[self searchDisplayController] searchBar]];
        [self.tableView reloadData];
    }
}
- (IBAction)settingsButtonClicked:(id)sender {
    [self performSegueWithIdentifier:@"ShowSettings" sender:self];
}
- (IBAction)share:(id)sender{
    NSString * text = NSLocalizedString(@"Are you have a difficult time remembering all your usernames and passwords? Try this", nil);
    NSString * urlString = @"https://mykee.in";
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSArray *activityItems = [NSArray arrayWithObjects:text, url,  nil];
    
    UIActivityViewController *avc = [[UIActivityViewController alloc]
                                     initWithActivityItems:activityItems
                                     applicationActivities:nil];
    
    
    avc.excludedActivityTypes = @[UIActivityTypeAssignToContact, UIActivityTypeAddToReadingList];
    
    
    //-- define the activity view completion handler
    avc.completionHandler = ^(NSString *activityType, BOOL completed){
        if (completed) {
            // NSLog(@"Selected activity was performed.");
        } else {
            if (activityType == NULL) {
                //   NSLog(@"User dismissed the view controller without making a selection.");
            } else {
                //  NSLog(@"Activity was not performed.");
            }
        }
    };
    [self presentViewController:avc animated:YES completion:nil];
}

#pragma mark - delegates
-(void)dropItem{
    [self removeItemFromDisk:self.items[self.updateIndex]];
    self.items = [self loadItemsFromDisk];
    [self.tableView reloadData];
}
-(void)createOrUpdateItemWithTitle:(NSString *)title withUsername:(NSString *)username withPass:(NSString *)pass withNotes:(NSString *)notes withIconImageName:(NSString *)iconImageName
{
    Item *item = self.toUpdate ? self.items[self.updateIndex] : [[Item alloc] init];
    item.title = title;
    item.username = username;
    item.password = pass;
    item.notes = notes;
    item.iconImageName = iconImageName;
    
    [self saveItemToDisk:item];
    self.items = [self loadItemsFromDisk];
    [self.tableView reloadData];
}

#pragma mark - disk
- (void)removeItemFromDisk:(Item*)item{
    NSString *path = @"~/Documents/items";
    path = [path stringByExpandingTildeInPath];
    
    NSMutableArray * arr = [self.items mutableCopy];
    [arr removeObject:item];
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:arr];
    NSData * encryptedData =[data encryptedDataWithPass:[Utils getPass] error:nil];
    [encryptedData writeToFile:path atomically:YES];
}
- (void)saveItemToDisk:(Item*)item {
    NSString *path = @"~/Documents/items";
    path = [path stringByExpandingTildeInPath];

    NSMutableArray * arr = [self.items mutableCopy];
    if (!arr)
        arr = [[NSMutableArray alloc] initWithCapacity:10];
    if (!self.toUpdate)
        [arr addObject:item];
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:arr];
    NSData * encryptedData =[data encryptedDataWithPass:[Utils getPass] error:nil];
    [encryptedData writeToFile:path atomically:YES];
}
- (NSArray*)loadItemsFromDisk {
    NSString *path = @"~/Documents/items";
    path = [path stringByExpandingTildeInPath];
    
    //[[NSFileManager defaultManager] removeItemAtPath:path error:nil]; //testing

    NSData * data = [NSData dataWithContentsOfFile:path];
    if (!data){
        Item * item = [[Item alloc] init];
        item.title = NSLocalizedString(@"Key Example", nil);
        item.username = @"mymail@email.com";
        item.password = @"Password123";
        item.notes = NSLocalizedString(@"notes about this key example", nil);
        item.iconImageName = @"icon_13";

        [self saveItemToDisk:item];
        return [self loadItemsFromDisk];
    }
    NSData * decodedData = [data decryptedDataWithPass:[Utils getPass] error:nil];
    NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithData:decodedData];

    return arr;
}
-(void)loadRequestsAndReloadTheTable{
    if ([self.segmentedControl selectedSegmentIndex] != 1) {
        //TODO concurrent
        return;
    }
    self.loaded = NO;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"email": [Utils getEmail], @"registerId":[Utils uuid]};
    
    NSString * reqString = [NSString stringWithFormat:@"%@/api/requests/load?os=ios&ln=%@",MYKEE_URL,LANG];
    [manager POST:reqString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         self.loaded = YES;
         self.requests = [responseObject mutableCopy];
         [self.tableView reloadData];
         if ([self.segmentedControl selectedSegmentIndex] == 1) {
             [self performSelector:@selector(loadRequestsAndReloadTheTable) withObject:nil afterDelay:3];
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         if ([self.segmentedControl selectedSegmentIndex] == 1) {
             [self performSelector:@selector(loadRequestsAndReloadTheTable) withObject:nil afterDelay:3];
         }
     }];
}

- (IBAction)ignoreRequestAction:(id)sender {
    NSIndexPath * indexPath = [self.tableView indexPathForCell:[[[sender superview]superview]superview]]; //ios7
    NSInteger rowOfTheCell = [indexPath row];
    
    NSDictionary * request = self.requests[rowOfTheCell];
    NSString *requestId = request[@"_id"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"email": [Utils getEmail], @"registerId":[Utils uuid],@"requestId":requestId};
    
    NSString * reqString = [NSString stringWithFormat:@"%@/api/requests/warn?os=ios&ln=%@",MYKEE_URL,LANG];
    [manager POST:reqString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(loadRequestsAndReloadTheTable) object:nil];
         //[self.requests removeObjectAtIndex:rowOfTheCell];
         //[self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
         [self loadRequestsAndReloadTheTable];
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
     }];

}

- (IBAction)sendRequestAction:(id)sender {
}

@end
