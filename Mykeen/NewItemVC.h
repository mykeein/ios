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
-(void)createItemWithName:(NSString *)name withPass:(NSString*)pass withDescription:(NSString*)description;
@end

@interface NewItemVC : UIViewController


@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *pass;
@property (weak, nonatomic) IBOutlet UITextView *description;
- (IBAction)cancelButtonAction:(id)sender;
- (IBAction)saveButtonAction:(id)sender;

@property id<CreateItemDelegate> createItemDelegate;

@end
