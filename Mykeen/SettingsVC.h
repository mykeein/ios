//
//  SettingsVC.h
//  Mykeen
//
//  Created by Ilia Kohanovski on 7/26/14.
//  Copyright (c) 2014 Mykeen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsVC : UIViewController

- (IBAction)changeButtonClicked:(id)sender;
- (IBAction)notApprovedButtonClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *notApprovedButton;

@end
