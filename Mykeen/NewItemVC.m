//
//  MykeenNewItemVC.m
//  Mykeen
//
//  Created by Ilia Kohanovski on 7/7/14.
//  Copyright (c) 2014 Mykeen. All rights reserved.
//

#import "NewItemVC.h"
#import "IconVC.h"

@interface NewItemVC ()<UpdateIconDelegate>

@end

@implementation NewItemVC

-(void)viewDidAppear:(BOOL)animated{
    [self.itemTitle becomeFirstResponder];
}

- (IBAction)cancelButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        // do nothing
    }];
}

- (IBAction)saveButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        [self.createItemDelegate createOrUpdateItemWithTitle:self.itemTitle.text withUsername:self.userName.text withPass:self.pass.text withNotes:self.notes.text withIconImageName:self.iconImageName];
    }];
}
-(void)viewDidLoad{
    if (self.itemToUpdate)
        [self updateFieldsWithItem:self.itemToUpdate];
    else{
        self.iconImageName = @"icon_13";
    }
}

-(void)updateFieldsWithItem:(Item*)item{
    self.itemTitle.text = item.title;
    self.userName.text = item.username;
    self.pass.text = item.password;
    self.notes.text = item.notes;
    [self.iconImage setImage:[UIImage imageNamed:item.iconImageName]];
    self.iconImageName = item.iconImageName;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField==self.itemTitle)
        [self.userName becomeFirstResponder];
    else if (textField==self.userName)
        [self.pass becomeFirstResponder];
    else if (textField==self.pass)
        [self.notes becomeFirstResponder];
    else if (textField==self.notes)
        [self saveButtonAction:self];
    
    return YES;
}

- (IBAction)generateButtonClick:(id)sender {
    static NSString * az = @"abcdefghijklmnopqrstuvwxyz";
    static NSString * AZ = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    static NSString * numbers = @"0123456789";
    
    NSMutableString *letters = [NSMutableString stringWithCapacity: 200];
    if (self.azSwitch.isOn)
        [letters appendString:az];
    if (self.AZSwitch.isOn)
        [letters appendString:AZ];
    if (self.numbersSwitch.isOn)
        [letters appendString:numbers];
    
    if (![letters length])
        self.pass.text = NSLocalizedString(@"select at least one checkbox", nil);
    else
        self.pass.text = [self randomStringWithLetters:letters];
        
}
-(NSString*)randomStringWithLetters:(NSString*)letters{
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: 12];
    
    for (int i=0; i<12; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length]) % [letters length]]];
    }
    
    return randomString;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"IconVC"]){
        IconVC *vc = segue.destinationViewController;
        vc.delegate = self;
    }
}

-(void)setIconWithImageName:(NSString *)imageName{
    self.iconImageName = imageName;
    [self.iconImage setImage:[UIImage imageNamed:imageName]];
}

@end
