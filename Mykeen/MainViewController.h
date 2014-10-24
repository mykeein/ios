//
//  MainViewController.h
//  Mykeen
//
//  Created by Ilia Kohanovski on 6/27/14.
//  Copyright (c) 2014 Mykeen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewItemVC.h"

@interface MainViewController : UIViewController <UISearchDisplayDelegate, UITableViewDataSource, UITableViewDelegate, CreateItemDelegate,UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIView *bannerContainerView;
- (IBAction)swipeLeft:(id)sender;
- (IBAction)swipeRight:(id)sender;

- (IBAction)edit:(id)sender;
- (IBAction)newItemAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *editItemAction;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
- (IBAction)segmentChanged:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *noEmailView;
- (IBAction)settingsButtonClicked:(id)sender;

- (IBAction)ignoreRequestAction:(id)sender;
- (IBAction)sendRequestAction:(id)sender;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end
