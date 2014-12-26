//
//  SendViewController.h
//  Mykee
//
//  Created by Ilia Kohanovski on 11/29/14.
//  Copyright (c) 2014 Mykeen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendViewController : UIViewController <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property NSArray *items;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, retain) NSString * requestId;

@end
