//
//  MainViewController.h
//  Mykeen
//
//  Created by Ilia Kohanovski on 6/27/14.
//  Copyright (c) 2014 Mykeen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GADBannerView.h"
#import "NewItemVC.h"

@interface MainViewController : UIViewController <UISearchDisplayDelegate, UITableViewDataSource, UITableViewDelegate, CreateItemDelegate>

@property (weak, nonatomic) IBOutlet UIView *bannerContainerView;

- (IBAction)edit:(id)sender;
- (IBAction)newItemAction:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
