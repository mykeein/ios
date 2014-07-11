//
//  MykeenNewItemVC.h
//  Mykeen
//
//  Created by Ilia Kohanovski on 7/7/14.
//  Copyright (c) 2014 Mykeen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CreateItemDelegate <NSObject>
@required
-(void)createItemWithTitle:(NSString *)title withUsername:(NSString *)username withPass:(NSString*)pass withNotes:(NSString*)notes;
@end

@interface NewItemVC : UIViewController


@property (weak, nonatomic) IBOutlet UITextField *itemTitle;

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *pass;
@property (weak, nonatomic) IBOutlet UITextField *notes;

- (IBAction)cancelButtonAction:(id)sender;
- (IBAction)saveButtonAction:(id)sender;

- (IBAction)generateButtonClick:(id)sender;

@property (weak, nonatomic) IBOutlet UISwitch *azSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *AZSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *numbersSwitch;


@property id<CreateItemDelegate> createItemDelegate;

@end
