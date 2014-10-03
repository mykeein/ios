//
//  MykeenNewItemVC.h
//  Mykeen
//
//  Created by Ilia Kohanovski on 7/7/14.
//  Copyright (c) 2014 Mykeen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"

@protocol CreateItemDelegate <NSObject>
@required
-(void)createOrUpdateItemWithTitle:(NSString *)title withUsername:(NSString *)username withPass:(NSString*)pass withNotes:(NSString*)notes withIconImageName:(NSString*)iconImageName;
@end

@interface NewItemVC : UIViewController <UITextFieldDelegate>

@property (nonatomic,retain) Item *itemToUpdate;

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
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@property (retain, nonatomic) NSString *iconImageName;

@end
